"""Tests for equipment issue and return transactions."""
import pytest
from datetime import date, datetime, time, timedelta, timezone
from sqlmodel import Session

from app.models import Booking, Slot, Transaction
from app.models.enums import BookingStatus, EquipmentCondition, SlotStatus, TransactionStatus
from app.services.booking import create_booking
from app.services.fairness_engine import run_batch_allocation
from app.services.transaction import issue_equipment, return_equipment
from tests.conftest import auth_headers


def _confirm_booking(session: Session, slot: Slot, student, fairness_config) -> Booking:
    """Helper: submit booking and run allocation to confirm it."""
    booking = create_booking(session, student, slot.id)
    slot.status = SlotStatus.PENDING_ALLOCATION
    session.add(slot)
    session.commit()
    run_batch_allocation(session, slot.id)
    session.refresh(booking)
    return booking


def test_issue_equipment(session: Session, student_riya, open_slot, cricket_bat, staff_user, fairness_config):
    booking = _confirm_booking(session, open_slot, student_riya, fairness_config)
    assert booking.status == BookingStatus.CONFIRMED

    txn = issue_equipment(session, booking.id, cricket_bat.id, staff_user.id)
    assert txn.status == TransactionStatus.ISSUED
    assert txn.student_id == student_riya.id
    assert txn.equipment_id == cricket_bat.id

    session.refresh(cricket_bat)
    assert cricket_bat.status.value == "ISSUED"


def test_issue_non_confirmed_booking_fails(session: Session, student_riya, open_slot, cricket_bat, staff_user, fairness_config):
    booking = create_booking(session, student_riya, open_slot.id)
    with pytest.raises(Exception) as exc_info:
        issue_equipment(session, booking.id, cricket_bat.id, staff_user.id)
    assert "BOOKING_NOT_CONFIRMED" in str(exc_info.value.detail)


def test_issue_wrong_equipment_fails(session: Session, student_riya, open_slot, cricket_bat, admin_user, staff_user, fairness_config):
    from app.models import Equipment
    from app.models.enums import EquipmentStatus

    other_bat = Equipment(
        name="Other Bat", category="Cricket", qr_code="OTHER-BAT-001",
        status=EquipmentStatus.AVAILABLE, added_by=admin_user.id,
    )
    session.add(other_bat)
    session.commit()

    booking = _confirm_booking(session, open_slot, student_riya, fairness_config)
    session.refresh(other_bat)
    with pytest.raises(Exception) as exc_info:
        issue_equipment(session, booking.id, other_bat.id, staff_user.id)
    assert "EQUIPMENT_MISMATCH" in str(exc_info.value.detail)


def test_return_equipment_good(session: Session, student_riya, open_slot, cricket_bat, staff_user, fairness_config):
    booking = _confirm_booking(session, open_slot, student_riya, fairness_config)
    txn = issue_equipment(session, booking.id, cricket_bat.id, staff_user.id)

    returned = return_equipment(session, txn.id, EquipmentCondition.GOOD, None, staff_user.id)
    assert returned.status == TransactionStatus.RETURNED
    assert returned.condition_on_return == EquipmentCondition.GOOD

    session.refresh(cricket_bat)
    assert cricket_bat.status.value == "AVAILABLE"

    session.refresh(booking)
    assert booking.status == BookingStatus.COMPLETED


def test_return_damaged_without_report_fails(session: Session, student_riya, open_slot, cricket_bat, staff_user, fairness_config):
    booking = _confirm_booking(session, open_slot, student_riya, fairness_config)
    txn = issue_equipment(session, booking.id, cricket_bat.id, staff_user.id)
    with pytest.raises(Exception) as exc_info:
        return_equipment(session, txn.id, EquipmentCondition.DAMAGED, None, staff_user.id)
    assert "DAMAGE_REPORT_REQUIRED" in str(exc_info.value.detail)


def test_return_damaged_with_report(session: Session, student_riya, open_slot, cricket_bat, staff_user, fairness_config):
    booking = _confirm_booking(session, open_slot, student_riya, fairness_config)
    txn = issue_equipment(session, booking.id, cricket_bat.id, staff_user.id)
    returned = return_equipment(session, txn.id, EquipmentCondition.DAMAGED, "Handle cracked", staff_user.id)
    assert returned.status == TransactionStatus.RETURNED_DAMAGED
    assert returned.damage_report == "Handle cracked"
