"""
Background scheduler for periodic jobs:
- Overdue detection (every hour)
- Slot cutoff transition (every 5 minutes)
- NO_SHOW detection (every 10 minutes)
"""
from datetime import datetime, timedelta, timezone
from apscheduler.schedulers.background import BackgroundScheduler
from sqlmodel import Session, select

from app.core.database import engine
from app.models import Booking, Slot
from app.models.enums import BookingStatus, SlotStatus
from app.services.fairness_engine import promote_waitlist, run_batch_allocation
from app.services.overdue import detect_overdue, send_return_reminders

scheduler = BackgroundScheduler(timezone="UTC")


def job_detect_overdue() -> None:
    with Session(engine) as session:
        count = detect_overdue(session)
        if count:
            print(f"[scheduler] overdue: {count} new overdue transactions")


def job_return_reminders() -> None:
    with Session(engine) as session:
        count = send_return_reminders(session)
        if count:
            print(f"[scheduler] reminders: {count} return reminders sent")


def job_transition_slots() -> None:
    """Move OPEN slots past their booking_cutoff_at to PENDING_ALLOCATION."""
    now = datetime.now(timezone.utc)
    with Session(engine) as session:
        open_past_cutoff = session.exec(
            select(Slot).where(
                Slot.status == SlotStatus.OPEN,
                Slot.booking_cutoff_at <= now,
            )
        ).all()
        for slot in open_past_cutoff:
            slot.status = SlotStatus.PENDING_ALLOCATION
            session.add(slot)
        if open_past_cutoff:
            session.commit()
            print(f"[scheduler] transition: {len(open_past_cutoff)} slots → PENDING_ALLOCATION")

        # Auto-run allocation for slots in PENDING_ALLOCATION
        pending = session.exec(
            select(Slot).where(Slot.status == SlotStatus.PENDING_ALLOCATION)
        ).all()
        for slot in pending:
            try:
                result = run_batch_allocation(session, slot.id)
                print(f"[scheduler] allocation slot={slot.id}: {result}")
            except Exception as e:
                print(f"[scheduler] allocation error slot={slot.id}: {e}")


def job_detect_no_show() -> None:
    """Mark CONFIRMED bookings with no transaction 30 min after slot start as NO_SHOW."""
    now = datetime.now(timezone.utc)
    no_show_window = timedelta(minutes=30)

    with Session(engine) as session:
        # Find slots that started > 30 min ago and are not yet CLOSED
        from app.models import Transaction
        from app.models.enums import TransactionStatus

        past_slots = session.exec(
            select(Slot).where(
                Slot.status.in_([SlotStatus.OPEN, SlotStatus.FULL]),
                Slot.date <= now.date(),
            )
        ).all()

        for slot in past_slots:
            slot_start = datetime.combine(slot.date, slot.start_time, tzinfo=timezone.utc)
            if now < slot_start + no_show_window:
                continue

            confirmed = session.exec(
                select(Booking).where(
                    Booking.slot_id == slot.id,
                    Booking.status == BookingStatus.CONFIRMED,
                )
            ).all()
            for booking in confirmed:
                has_txn = session.exec(
                    select(Transaction).where(Transaction.booking_id == booking.id)
                ).first()
                if not has_txn:
                    booking.status = BookingStatus.NO_SHOW
                    session.add(booking)
                    slot.available_count = min(slot.available_count + 1, slot.capacity)
                    session.add(slot)
                    promote_waitlist(session, slot.id)
            session.commit()


def start_scheduler() -> None:
    scheduler.add_job(job_detect_overdue, "interval", hours=1, id="overdue_detection")
    scheduler.add_job(job_return_reminders, "interval", hours=1, id="return_reminders")
    scheduler.add_job(job_transition_slots, "interval", minutes=5, id="slot_transitions")
    scheduler.add_job(job_detect_no_show, "interval", minutes=10, id="no_show_detection")
    scheduler.start()
    print("[scheduler] Started background scheduler.")


def stop_scheduler() -> None:
    if scheduler.running:
        scheduler.shutdown()
