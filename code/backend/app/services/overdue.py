"""
Overdue detection service — run as a scheduled job.
Detects ISSUED transactions past their due_at and creates Defaulter records.
"""
from datetime import datetime, timedelta, timezone
from sqlmodel import Session, select

from app.models import Defaulter, Notification, Transaction
from app.models.enums import DefaulterStatus, NotificationType, TransactionStatus
from app.services.notification import create_notification


def detect_overdue(session: Session) -> int:
    """
    Mark ISSUED transactions past due_at as OVERDUE.
    Create Defaulter records and send OVERDUE_ALERT notifications.
    Returns count of newly overdue transactions.
    """
    now = datetime.now(timezone.utc)

    overdue_txns = session.exec(
        select(Transaction).where(
            Transaction.status == TransactionStatus.ISSUED,
            Transaction.due_at < now,
        )
    ).all()

    count = 0
    for txn in overdue_txns:
        txn.status = TransactionStatus.OVERDUE
        session.add(txn)

        existing_defaulter = session.exec(
            select(Defaulter).where(Defaulter.transaction_id == txn.id)
        ).first()
        if existing_defaulter is None:
            overdue_days = int((now - txn.due_at.replace(tzinfo=timezone.utc) if txn.due_at.tzinfo is None else now - txn.due_at).total_seconds() / 86400)
            defaulter = Defaulter(
                student_id=txn.student_id,
                transaction_id=txn.id,
                detected_at=now,
                overdue_days=max(overdue_days, 1),
                status=DefaulterStatus.ACTIVE,
            )
            session.add(defaulter)
            create_notification(session, txn.student_id, NotificationType.OVERDUE_ALERT)
            count += 1

    session.commit()
    return count


def send_return_reminders(session: Session) -> int:
    """
    Send RETURN_REMINDER to students with equipment due within 2 hours.
    Idempotent: skips if a reminder was already sent for this transaction.
    Returns count of new reminders sent.
    """
    now = datetime.now(timezone.utc)
    window_end = now + timedelta(hours=2)

    due_soon = session.exec(
        select(Transaction).where(
            Transaction.status == TransactionStatus.ISSUED,
            Transaction.due_at >= now,
            Transaction.due_at <= window_end,
        )
    ).all()

    count = 0
    for txn in due_soon:
        # Idempotency: skip if a reminder was already sent for this transaction slot
        already_sent = session.exec(
            select(Notification).where(
                Notification.student_id == txn.student_id,
                Notification.type == NotificationType.RETURN_REMINDER,
                Notification.created_at >= txn.due_at - timedelta(hours=2),
            )
        ).first()
        if already_sent:
            continue
        create_notification(session, txn.student_id, NotificationType.RETURN_REMINDER)
        count += 1

    session.commit()
    return count
