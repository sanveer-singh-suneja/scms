from fastapi import APIRouter, HTTPException, Query, status
from pydantic import BaseModel, EmailStr
from sqlmodel import select

from app.core.dependencies import AdminUser, SessionDep
from app.core.security import hash_password
from app.models import User
from app.models.enums import UserRole, UserStatus
from app.schemas.common import StandardResponse

router = APIRouter(prefix="/admin/staff", tags=["admin-staff"])


class StaffCreate(BaseModel):
    name: str
    email: EmailStr
    password: str
    role: UserRole = UserRole.STAFF


class StaffUpdate(BaseModel):
    name: str | None = None
    email: EmailStr | None = None
    role: UserRole | None = None


@router.get("")
def list_staff(
    admin: AdminUser,
    session: SessionDep,
    page: int = Query(1, ge=1),
    limit: int = Query(20, ge=1, le=100),
):
    query = select(User)
    total = len(session.exec(query).all())
    items = session.exec(query.offset((page - 1) * limit).limit(limit)).all()
    return StandardResponse.list_ok(
        [{"id": u.id, "name": u.name, "email": u.email, "role": u.role, "status": u.status, "created_at": u.created_at.isoformat()} for u in items],
        page, limit, total,
    )


@router.post("", status_code=201)
def create_staff(body: StaffCreate, admin: AdminUser, session: SessionDep):
    if session.exec(select(User).where(User.email == body.email)).first():
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail={"code": "EMAIL_ALREADY_EXISTS", "message": "Email already registered."},
        )
    user = User(
        name=body.name,
        email=body.email,
        password_hash=hash_password(body.password),
        role=body.role,
        status=UserStatus.ACTIVE,
        created_by=admin.id,
    )
    session.add(user)
    session.commit()
    session.refresh(user)
    return StandardResponse.ok({"id": user.id, "name": user.name, "email": user.email, "role": user.role})


@router.put("/{user_id}")
def update_staff(user_id: int, body: StaffUpdate, admin: AdminUser, session: SessionDep):
    user = session.get(User, user_id)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "NOT_FOUND", "message": "User not found."},
        )
    if body.name is not None:
        user.name = body.name
    if body.email is not None:
        existing = session.exec(select(User).where(User.email == body.email, User.id != user_id)).first()
        if existing:
            raise HTTPException(
                status_code=status.HTTP_409_CONFLICT,
                detail={"code": "EMAIL_ALREADY_EXISTS", "message": "Email already in use."},
            )
        user.email = body.email
    if body.role is not None:
        user.role = body.role
    session.add(user)
    session.commit()
    session.refresh(user)
    return StandardResponse.ok({"id": user.id, "name": user.name, "email": user.email, "role": user.role})


@router.patch("/{user_id}/deactivate")
def deactivate_staff(user_id: int, admin: AdminUser, session: SessionDep):
    if user_id == admin.id:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail={"code": "CANNOT_SELF_DEACTIVATE", "message": "You cannot deactivate your own account."},
        )
    user = session.get(User, user_id)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"code": "NOT_FOUND", "message": "User not found."},
        )
    user.status = UserStatus.INACTIVE
    session.add(user)
    session.commit()
    return StandardResponse.ok({"id": user.id, "status": user.status})
