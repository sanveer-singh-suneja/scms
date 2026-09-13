from fastapi import APIRouter, HTTPException, Query, status
from sqlalchemy import func
from sqlmodel import select

from app.core.dependencies import CurrentStudent, SessionDep
from app.models import Notification
from app.schemas.common import StandardResponse
from app.schemas.notification import NotificationRead, UnreadCountRead

router = APIRouter(prefix="/notifications", tags=["notifications"])


@router.get("")
def list_notifications(
    student: CurrentStudent,
    session: SessionDep,
    page: int = Query(1, ge=1),
    limit: int = Query(20, ge=1, le=100),
):
    query = select(Notification).where(Notification.student_id == student.id).order_by(Notification.created_at.desc())
    total = len(session.exec(query).all())
    items = session.exec(query.offset((page - 1) * limit).limit(limit)).all()
    return StandardResponse.list_ok(
        [NotificationRead.model_validate(n) for n in items], page, limit, total
    )


@router.get("/unread-count")
def get_unread_count(student: CurrentStudent, session: SessionDep):
    count = session.exec(
        select(func.count()).select_from(Notification).where(
            Notification.student_id == student.id,
            Notification.is_read == False,
        )
    ).one()
    return StandardResponse.ok(UnreadCountRead(unread_count=count))


@router.put("/{notification_id}/read")
def mark_read(notification_id: int, student: CurrentStudent, session: SessionDep):
    notif = session.get(Notification, notification_id)
    if not notif or notif.student_id != student.id:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "NOT_FOUND", "message": "Notification not found."},
        )
    notif.is_read = True
    session.add(notif)
    session.commit()
    session.refresh(notif)
    return StandardResponse.ok(NotificationRead.model_validate(notif))


@router.post("/mark-all-read")
def mark_all_read(student: CurrentStudent, session: SessionDep):
    notifs = session.exec(
        select(Notification).where(
            Notification.student_id == student.id,
            Notification.is_read == False,
        )
    ).all()
    for n in notifs:
        n.is_read = True
        session.add(n)
    session.commit()
    return StandardResponse.ok({"updated": len(notifs)})
