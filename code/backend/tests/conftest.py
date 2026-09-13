"""
Test configuration — uses an in-memory SQLite database.
FastAPI test client with dependency overrides for auth.
"""
import secrets
import pytest
from fastapi.testclient import TestClient
from sqlmodel import Session, SQLModel, create_engine
from sqlmodel.pool import StaticPool

from app.core.database import get_session
from app.core.security import create_access_token, hash_password
from app.main import app
from app.models import (
    Equipment, FairnessConfig, Slot, Student, Transaction, UsageStatistics, User,
)
from app.models.enums import (
    EquipmentCondition, EquipmentStatus, SlotStatus, StudentStatus, TransactionStatus,
    UserRole, UserStatus,
)
from datetime import date, datetime, time, timedelta, timezone


TEST_DB_URL = "sqlite://"


@pytest.fixture(name="session")
def session_fixture():
    engine = create_engine(TEST_DB_URL, connect_args={"check_same_thread": False}, poolclass=StaticPool)
    SQLModel.metadata.create_all(engine)
    with Session(engine) as session:
        yield session
    SQLModel.metadata.drop_all(engine)


@pytest.fixture(name="client")
def client_fixture(session: Session):
    def override_get_session():
        yield session

    app.dependency_overrides[get_session] = override_get_session
    client = TestClient(app, raise_server_exceptions=False)
    yield client
    app.dependency_overrides.clear()


@pytest.fixture
def admin_user(session: Session) -> User:
    user = User(
        name="Test Admin",
        email="admin@test.com",
        password_hash=hash_password("admin123"),
        role=UserRole.ADMIN,
        status=UserStatus.ACTIVE,
    )
    session.add(user)
    session.commit()
    session.refresh(user)
    return user


@pytest.fixture
def staff_user(session: Session, admin_user: User) -> User:
    user = User(
        name="Test Staff",
        email="staff@test.com",
        password_hash=hash_password("staff123"),
        role=UserRole.STAFF,
        status=UserStatus.ACTIVE,
        created_by=admin_user.id,
    )
    session.add(user)
    session.commit()
    session.refresh(user)
    return user


@pytest.fixture
def student_arjun(session: Session, cricket_bat: Equipment, admin_user: User) -> Student:
    student = Student(
        student_id="CS001",
        name="Arjun Sharma",
        email="arjun@test.com",
        department="CS",
        password_hash=hash_password("arjun123"),
        qr_identifier=secrets.token_urlsafe(32),
        status=StudentStatus.ACTIVE,
    )
    session.add(student)
    session.commit()
    session.refresh(student)
    stats = UsageStatistics(student_id=student.id, sessions_last_7_days=4, total_sessions=4)
    session.add(stats)

    # Create 4 completed transactions in the last 7 days so the fairness engine
    # actually counts them (engine reads Transaction.returned_at, not UsageStatistics)
    now = datetime.now(timezone.utc)
    for i in range(4):
        txn = Transaction(
            student_id=student.id,
            equipment_id=cricket_bat.id,
            issued_at=now - timedelta(days=i + 1, hours=2),
            due_at=now - timedelta(days=i + 1, hours=1),
            returned_at=now - timedelta(days=i + 1),
            status=TransactionStatus.RETURNED,
            issued_by=admin_user.id,
        )
        session.add(txn)

    session.commit()
    return student


@pytest.fixture
def student_riya(session: Session) -> Student:
    student = Student(
        student_id="CS002",
        name="Riya Patel",
        email="riya@test.com",
        department="CS",
        password_hash=hash_password("riya123"),
        qr_identifier=secrets.token_urlsafe(32),
        status=StudentStatus.ACTIVE,
    )
    session.add(student)
    session.commit()
    session.refresh(student)
    stats = UsageStatistics(student_id=student.id, sessions_last_7_days=0, total_sessions=0)
    session.add(stats)
    session.commit()
    return student


@pytest.fixture
def cricket_bat(session: Session, admin_user: User) -> Equipment:
    eq = Equipment(
        name="Cricket Bat #1",
        category="Cricket",
        qr_code="CRICKET-BAT-001",
        status=EquipmentStatus.AVAILABLE,
        condition=EquipmentCondition.GOOD,
        added_by=admin_user.id,
    )
    session.add(eq)
    session.commit()
    session.refresh(eq)
    return eq


@pytest.fixture
def open_slot(session: Session, cricket_bat: Equipment, admin_user: User) -> Slot:
    now = datetime.now(timezone.utc)
    slot = Slot(
        equipment_id=cricket_bat.id,
        date=date.today() + timedelta(days=1),
        start_time=time(9, 0),
        end_time=time(10, 0),
        capacity=1,
        available_count=1,
        booking_cutoff_at=now + timedelta(hours=2),
        status=SlotStatus.OPEN,
        created_by=admin_user.id,
    )
    session.add(slot)
    session.commit()
    session.refresh(slot)
    return slot


@pytest.fixture
def fairness_config(session: Session) -> FairnessConfig:
    cfg = FairnessConfig(id=1)
    session.add(cfg)
    session.commit()
    session.refresh(cfg)
    return cfg


def auth_headers(user_id: int, role: str) -> dict:
    token = create_access_token(str(user_id), role)
    return {"Authorization": f"Bearer {token}"}
