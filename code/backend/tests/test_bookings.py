"""Tests for booking creation, cancellation, and cap enforcement."""
import pytest
from fastapi.testclient import TestClient
from sqlmodel import Session

from app.models import Booking, FairnessConfig
from app.models.enums import BookingStatus
from app.services.booking import create_booking
from tests.conftest import auth_headers


def test_submit_booking(client: TestClient, student_arjun, open_slot, fairness_config):
    headers = auth_headers(student_arjun.id, "STUDENT")
    res = client.post("/api/bookings", json={"slot_id": open_slot.id}, headers=headers)
    assert res.status_code == 201
    data = res.json()["data"]
    assert data["status"] == "REQUESTED"
    assert data["equipment"]["id"] is not None
    assert data["slot"]["id"] is not None


def test_duplicate_booking(client: TestClient, student_arjun, open_slot, fairness_config):
    headers = auth_headers(student_arjun.id, "STUDENT")
    client.post("/api/bookings", json={"slot_id": open_slot.id}, headers=headers)
    res = client.post("/api/bookings", json={"slot_id": open_slot.id}, headers=headers)
    assert res.status_code == 409
    assert res.json()["error"]["code"] == "DUPLICATE_BOOKING"


def test_cancel_requested_booking(
    session: Session, client: TestClient, student_arjun, open_slot, fairness_config
):
    booking = create_booking(session, student_arjun, open_slot.id)
    headers = auth_headers(student_arjun.id, "STUDENT")
    res = client.delete(f"/api/bookings/{booking.id}", headers=headers)
    assert res.status_code == 200
    assert res.json()["data"]["status"] == "CANCELLED"


def test_cancel_nonexistent_booking(client: TestClient, student_arjun, open_slot, fairness_config):
    headers = auth_headers(student_arjun.id, "STUDENT")
    res = client.delete("/api/bookings/99999", headers=headers)
    assert res.status_code == 404
    assert res.json()["error"]["code"] == "BOOKING_NOT_FOUND"


def test_usage_cap_enforcement(
    session: Session, client: TestClient, student_arjun, open_slot, fairness_config, admin_user, cricket_bat
):
    """Student cannot book more than daily_usage_cap=2 sessions per day."""
    from datetime import date, time, timedelta, timezone, datetime as dt
    from app.models import Equipment, Slot, Transaction
    from app.models.enums import EquipmentStatus, SlotStatus, TransactionStatus, EquipmentCondition

    # Create 2 issued transactions today (at daily cap)
    for i in range(2):
        eq = Equipment(
            name=f"Bat {i+10}", category="Cricket", qr_code=f"BAT-CAP-{i}",
            added_by=admin_user.id, status=EquipmentStatus.ISSUED,
        )
        session.add(eq)
        session.commit()
        session.refresh(eq)
        now = dt.now(timezone.utc)
        txn = Transaction(
            student_id=student_arjun.id,
            equipment_id=eq.id,
            issued_at=now,
            due_at=now + timedelta(hours=1),
            status=TransactionStatus.ISSUED,
            issued_by=admin_user.id,
        )
        session.add(txn)
    session.commit()

    headers = auth_headers(student_arjun.id, "STUDENT")
    res = client.post("/api/bookings", json={"slot_id": open_slot.id}, headers=headers)
    assert res.status_code == 400
    assert res.json()["error"]["code"] == "USAGE_CAP_REACHED"


def test_booking_requires_auth(client: TestClient, open_slot):
    res = client.post("/api/bookings", json={"slot_id": open_slot.id})
    assert res.status_code == 403  # HTTPBearer raises 403 for missing auth
