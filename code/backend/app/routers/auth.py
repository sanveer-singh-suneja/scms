import secrets
from fastapi import APIRouter, HTTPException, status
from sqlmodel import select

from app.core.dependencies import CurrentStudent, CurrentUser, SessionDep
from app.core.security import create_access_token, hash_password, verify_password
from app.models import Student, UsageStatistics
from app.models.enums import StudentStatus
from app.schemas.auth import StudentLoginRequest, StudentRegisterRequest, StaffLoginRequest
from app.schemas.common import StandardResponse
from app.models import User
from app.models.enums import UserStatus

router = APIRouter(prefix="/auth", tags=["auth"])


@router.post("/student/register", status_code=201)
def register_student(body: StudentRegisterRequest, session: SessionDep):
    if session.exec(select(Student).where(Student.email == body.email)).first():
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail={"code": "EMAIL_ALREADY_EXISTS", "message": "Email already registered."},
        )
    if session.exec(select(Student).where(Student.student_id == body.student_id)).first():
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail={"code": "STUDENT_ID_ALREADY_EXISTS", "message": "Student ID already registered."},
        )
    student = Student(
        student_id=body.student_id,
        name=body.name,
        email=body.email,
        department=body.department,
        password_hash=hash_password(body.password),
        qr_identifier=secrets.token_urlsafe(32),
        status=StudentStatus.ACTIVE,
    )
    session.add(student)
    session.commit()
    session.refresh(student)

    stats = UsageStatistics(student_id=student.id)
    session.add(stats)
    session.commit()

    token = create_access_token(str(student.id), "STUDENT")
    return StandardResponse.ok({
        "token": token,
        "token_type": "bearer",
        "student": {
            "id": student.id, "name": student.name, "email": student.email,
            "student_id": student.student_id, "department": student.department,
            "status": student.status,
        },
    })


@router.post("/student/login")
def login_student(body: StudentLoginRequest, session: SessionDep):
    student = session.exec(select(Student).where(Student.email == body.email)).first()
    if not student or not verify_password(body.password, student.password_hash):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail={"code": "INVALID_CREDENTIALS", "message": "Invalid email or password."},
        )
    if student.status == StudentStatus.SUSPENDED:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail={"code": "ACCOUNT_SUSPENDED", "message": "Account is suspended."},
        )
    token = create_access_token(str(student.id), "STUDENT")
    return StandardResponse.ok({
        "token": token,
        "token_type": "bearer",
        "student": {
            "id": student.id, "name": student.name, "email": student.email,
            "student_id": student.student_id, "department": student.department,
            "status": student.status,
        },
    })


@router.post("/staff/login")
def login_staff(body: StaffLoginRequest, session: SessionDep):
    user = session.exec(select(User).where(User.email == body.email)).first()
    if not user or not verify_password(body.password, user.password_hash):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail={"code": "INVALID_CREDENTIALS", "message": "Invalid email or password."},
        )
    if user.status == UserStatus.INACTIVE:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail={"code": "ACCOUNT_INACTIVE", "message": "Account is deactivated."},
        )
    token = create_access_token(str(user.id), user.role.value)
    return StandardResponse.ok({
        "token": token,
        "token_type": "bearer",
        "user": {"id": user.id, "name": user.name, "email": user.email, "role": user.role},
    })


@router.get("/me")
def get_me(student: CurrentStudent):
    return StandardResponse.ok({
        "id": student.id,
        "student_id": student.student_id,
        "name": student.name,
        "email": student.email,
        "department": student.department,
        "status": student.status,
    })


@router.get("/me/staff")
def get_me_staff(user: CurrentUser):
    return StandardResponse.ok({
        "id": user.id,
        "name": user.name,
        "email": user.email,
        "role": user.role,
        "status": user.status,
    })
