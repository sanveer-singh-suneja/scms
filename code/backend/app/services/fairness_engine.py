"""
Batch allocation fairness engine.
See docs/FAIRNESS_ALGORITHM.md for the canonical specification.
"""
from datetime import datetime, timedelta, timezone
from dataclasses import dataclass
from decimal import Decimal
from sqlmodel import Session, select

from app.models import Booking, FairnessConfig, Slot, Transaction
from app.models.enums import BookingStatus, NotificationType, SlotStatus, TransactionStatus
from app.services.notification import create_notification


@dataclass
class _BookingScore:
    booking_id: int
    student_id: int
    sessions_7d: int
    days_since: float
    priority_score: float
    created_at: datetime


def _get_config(session: Session) -> FairnessConfig:
    cfg = session.get(FairnessConfig, 1)
    if cfg is None:
        cfg = FairnessConfig()
        session.add(cfg)
        session.commit()
        session.refresh(cfg)
    return cfg


def _sessions_last_7_days(session: Session, student_id: int, now: datetime) -> int:
    cutoff = now - timedelta(days=7)
    results = session.exec(
        select(Transaction).where(
            Transaction.student_id == student_id,
            Transaction.returned_at >= cutoff,
            Transaction.status.in_([TransactionStatus.RETURNED, TransactionStatus.RETURNED_DAMAGED]),
        )
    ).all()
    return len(results)


def _days_since_last_session(session: Session, student_id: int, now: datetime) -> float:
    """Returns days since last completed session, or 9999.0 if no history."""
    txn = session.exec(
        select(Transaction)
        .where(
            Transaction.student_id == student_id,
            Transaction.status.in_([TransactionStatus.RETURNED, TransactionStatus.RETURNED_DAMAGED]),
            Transaction.returned_at.is_not(None),
        )
        .order_by(Transaction.returned_at.desc())
    ).first()
    if txn is None or txn.returned_at is None:
        return 9999.0
    ret_at = txn.returned_at
    if ret_at.tzinfo is None:
        ret_at = ret_at.replace(tzinfo=timezone.utc)
    delta = now - ret_at
    return delta.total_seconds() / 86400.0


def run_batch_allocation(session: Session, slot_id: int) -> dict:
    """
    Run batch allocation for a slot in PENDING_ALLOCATION state.
    Returns summary dict with counts.
    """
    slot = session.get(Slot, slot_id)
    if slot is None:
        raise ValueError(f"Slot {slot_id} not found")
    if slot.status != SlotStatus.PENDING_ALLOCATION:
        raise ValueError(f"Slot {slot_id} is not in PENDING_ALLOCATION state (current: {slot.status})")

    now = datetime.now(timezone.utc)
    cfg = _get_config(session)

    requests = session.exec(
        select(Booking).where(
            Booking.slot_id == slot_id,
            Booking.status == BookingStatus.REQUESTED,
        )
    ).all()

    if not requests:
        slot.status = SlotStatus.CLOSED
        slot.allocation_run_at = now
        session.add(slot)
        session.commit()
        return {"confirmed": 0, "waitlisted": 0, "slot_status": SlotStatus.CLOSED}

    # Compute per-student stats in a separate data structure (avoid mutating ORM objects)
    scores: list[_BookingScore] = []
    for req in requests:
        s7d = _sessions_last_7_days(session, req.student_id, now)
        d = _days_since_last_session(session, req.student_id, now)
        scores.append(_BookingScore(
            booking_id=req.id,
            student_id=req.student_id,
            sessions_7d=s7d,
            days_since=d,
            priority_score=0.0,
            created_at=req.created_at,
        ))

    max_sessions = max(s.sessions_7d for s in scores)

    T = float(cfg.recency_threshold_days)
    W = float(cfg.recency_weight)

    for score in scores:
        s_norm = score.sessions_7d / max(max_sessions, 1)
        d = score.days_since
        p_recency = max(0.0, (T - d) * W) if d < T else 0.0
        score.priority_score = s_norm + p_recency

    # Sort ascending by priority_score, tie-break by created_at ascending
    sorted_scores = sorted(scores, key=lambda s: (s.priority_score, s.created_at))

    # Build a lookup map
    booking_map: dict[int, Booking] = {b.id: b for b in requests}

    capacity = slot.capacity
    confirmed_count = 0
    waitlisted_count = 0

    for i, score in enumerate(sorted_scores):
        req = booking_map[score.booking_id]
        req.allocated_at = now
        req.priority_score = Decimal(str(round(score.priority_score, 4)))
        if i < capacity:
            req.status = BookingStatus.CONFIRMED
            req.queue_position = None
            confirmed_count += 1
            create_notification(session, req.student_id, NotificationType.BOOKING_CONFIRMED)
        else:
            req.status = BookingStatus.WAITLISTED
            req.queue_position = i - capacity + 1
            waitlisted_count += 1
            create_notification(session, req.student_id, NotificationType.BOOKING_WAITLISTED)
        session.add(req)

    slot.allocation_run_at = now
    slot.available_count = max(0, capacity - confirmed_count)
    slot.status = SlotStatus.FULL if slot.available_count == 0 else SlotStatus.OPEN
    session.add(slot)
    session.commit()

    return {
        "confirmed": confirmed_count,
        "waitlisted": waitlisted_count,
        "slot_status": slot.status,
    }


def promote_waitlist(session: Session, slot_id: int) -> Booking | None:
    """
    Promote the first WAITLISTED booking for a slot to CONFIRMED.
    Called when a CONFIRMED booking is cancelled or becomes NO_SHOW.
    Returns the promoted booking or None.
    """
    first_waitlisted = session.exec(
        select(Booking).where(
            Booking.slot_id == slot_id,
            Booking.status == BookingStatus.WAITLISTED,
        ).order_by(Booking.queue_position.asc())
    ).first()

    if first_waitlisted is None:
        return None

    promoted_position = first_waitlisted.queue_position
    first_waitlisted.status = BookingStatus.CONFIRMED
    first_waitlisted.queue_position = None
    session.add(first_waitlisted)

    create_notification(session, first_waitlisted.student_id, NotificationType.WAITLIST_PROMOTED)

    # Decrement queue_position for remaining waitlisted
    remaining = session.exec(
        select(Booking).where(
            Booking.slot_id == slot_id,
            Booking.status == BookingStatus.WAITLISTED,
            Booking.queue_position > promoted_position,
        )
    ).all()
    for b in remaining:
        b.queue_position -= 1
        session.add(b)

    slot = session.get(Slot, slot_id)
    if slot and slot.status == SlotStatus.FULL:
        slot.status = SlotStatus.OPEN
        session.add(slot)

    return first_waitlisted
