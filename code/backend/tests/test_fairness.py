"""
Tests for the batch allocation fairness engine.
Key scenario: Riya (new student) should beat Arjun (4 sessions) even if Arjun books first.
"""
import pytest
from datetime import datetime, timezone
from sqlmodel import Session, select

from app.models import Booking, FairnessConfig, Slot
from app.models.enums import BookingStatus, SlotStatus
from app.services.booking import create_booking
from app.services.fairness_engine import run_batch_allocation


def _transition_to_pending(session: Session, slot: Slot) -> None:
    slot.status = SlotStatus.PENDING_ALLOCATION
    session.add(slot)
    session.commit()
    session.refresh(slot)


def test_fairness_riya_beats_arjun(
    session: Session,
    student_arjun,
    student_riya,
    open_slot: Slot,
    fairness_config: FairnessConfig,
):
    """
    Arjun has 4 sessions (high score → low priority).
    Riya has 0 sessions (score=0.0 → highest priority).
    Both request the same slot of capacity=1.
    After allocation: Riya=CONFIRMED, Arjun=WAITLISTED.
    """
    booking_arjun = create_booking(session, student_arjun, open_slot.id)
    booking_riya = create_booking(session, student_riya, open_slot.id)

    assert booking_arjun.status == BookingStatus.REQUESTED
    assert booking_riya.status == BookingStatus.REQUESTED

    _transition_to_pending(session, open_slot)
    result = run_batch_allocation(session, open_slot.id)

    assert result["confirmed"] == 1
    assert result["waitlisted"] == 1

    session.refresh(booking_arjun)
    session.refresh(booking_riya)

    assert booking_riya.status == BookingStatus.CONFIRMED, "Riya should be CONFIRMED"
    assert booking_arjun.status == BookingStatus.WAITLISTED, "Arjun should be WAITLISTED"
    assert booking_arjun.queue_position == 1
    assert booking_riya.priority_score < booking_arjun.priority_score


def test_all_zero_sessions(
    session: Session,
    student_riya,
    open_slot: Slot,
    fairness_config: FairnessConfig,
):
    """When all students have zero sessions, tie-break by created_at."""
    import secrets
    from app.models import Student, UsageStatistics
    from app.models.enums import StudentStatus
    from app.core.security import hash_password

    student2 = Student(
        student_id="CS003",
        name="Student 2",
        email="s2@test.com",
        department="CS",
        password_hash=hash_password("pass"),
        qr_identifier=secrets.token_urlsafe(32),
        status=StudentStatus.ACTIVE,
    )
    session.add(student2)
    session.commit()
    session.refresh(student2)
    session.add(UsageStatistics(student_id=student2.id))
    session.commit()

    open_slot.capacity = 1
    open_slot.available_count = 1
    session.add(open_slot)
    session.commit()

    b1 = create_booking(session, student_riya, open_slot.id)
    b2 = create_booking(session, student2, open_slot.id)

    _transition_to_pending(session, open_slot)
    run_batch_allocation(session, open_slot.id)

    session.refresh(b1)
    session.refresh(b2)

    # Earlier booking (Riya) should be CONFIRMED
    assert b1.status == BookingStatus.CONFIRMED
    assert b2.status == BookingStatus.WAITLISTED


def test_empty_batch_closes_slot(
    session: Session,
    open_slot: Slot,
    fairness_config: FairnessConfig,
):
    """Slot with no REQUESTED bookings at allocation time → CLOSED."""
    _transition_to_pending(session, open_slot)
    result = run_batch_allocation(session, open_slot.id)

    assert result["confirmed"] == 0
    session.refresh(open_slot)
    assert open_slot.status == SlotStatus.CLOSED


def test_capacity_two_both_confirmed(
    session: Session,
    student_arjun,
    student_riya,
    open_slot: Slot,
    fairness_config: FairnessConfig,
):
    """When capacity >= num requesters, all get CONFIRMED."""
    open_slot.capacity = 2
    open_slot.available_count = 2
    session.add(open_slot)
    session.commit()

    b1 = create_booking(session, student_arjun, open_slot.id)
    b2 = create_booking(session, student_riya, open_slot.id)

    _transition_to_pending(session, open_slot)
    result = run_batch_allocation(session, open_slot.id)

    assert result["confirmed"] == 2
    assert result["waitlisted"] == 0

    session.refresh(b1)
    session.refresh(b2)
    assert b1.status == BookingStatus.CONFIRMED
    assert b2.status == BookingStatus.CONFIRMED
