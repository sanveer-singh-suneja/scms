from sqlmodel import Session
from app.models import Notification
from app.models.enums import NotificationType

_TEMPLATES: dict[NotificationType, tuple[str, str]] = {
    NotificationType.BOOKING_RECEIVED: (
        "Booking Received",
        "Your booking request has been received and will be processed at allocation time.",
    ),
    NotificationType.BOOKING_CONFIRMED: (
        "Booking Confirmed!",
        "Your booking has been confirmed. Please collect your equipment at the scheduled time.",
    ),
    NotificationType.BOOKING_WAITLISTED: (
        "Added to Waitlist",
        "You are on the waitlist for this slot. You will be notified if a spot opens up.",
    ),
    NotificationType.WAITLIST_PROMOTED: (
        "Waitlist Promoted!",
        "A spot opened up — your booking is now confirmed! Collect your equipment on time.",
    ),
    NotificationType.BOOKING_CANCELLED: (
        "Booking Cancelled",
        "Your booking has been cancelled.",
    ),
    NotificationType.RETURN_REMINDER: (
        "Return Reminder",
        "Please return your equipment — it is due in 2 hours.",
    ),
    NotificationType.OVERDUE_ALERT: (
        "Equipment Overdue",
        "Your equipment is overdue. Please return it immediately to avoid further action.",
    ),
    NotificationType.RETURN_CONFIRMED: (
        "Return Confirmed",
        "Your equipment has been returned successfully. Thank you!",
    ),
    NotificationType.DAMAGE_LOGGED: (
        "Damage Recorded",
        "Your return was processed with damage noted. Please contact the sports office.",
    ),
}


def create_notification(
    session: Session,
    student_id: int,
    notification_type: NotificationType,
    message_override: str | None = None,
) -> Notification:
    title, default_message = _TEMPLATES[notification_type]
    notif = Notification(
        student_id=student_id,
        type=notification_type,
        title=title,
        message=message_override or default_message,
    )
    session.add(notif)
    return notif
