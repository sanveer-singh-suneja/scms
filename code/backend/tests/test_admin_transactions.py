"""Tests for the admin /admin/transactions endpoint."""
from datetime import datetime, timedelta, timezone

from sqlmodel import Session

from app.models import Transaction
from app.models.enums import TransactionStatus
from tests.conftest import auth_headers


def _make_transaction(session: Session, student_id: int, equipment_id: int, issued_by: int,
                      status: TransactionStatus = TransactionStatus.ISSUED) -> Transaction:
    now = datetime.now(timezone.utc)
    txn = Transaction(
        student_id=student_id,
        equipment_id=equipment_id,
        issued_by=issued_by,
        issued_at=now - timedelta(hours=2),
        due_at=now + timedelta(hours=2),
        status=status,
    )
    session.add(txn)
    session.commit()
    session.refresh(txn)
    return txn


def test_admin_list_transactions(client, session, admin_user, staff_user, student_arjun, cricket_bat):
    txn = _make_transaction(session, student_arjun.id, cricket_bat.id, staff_user.id)

    resp = client.get("/api/admin/transactions", headers=auth_headers(admin_user.id, "ADMIN"))
    assert resp.status_code == 200
    body = resp.json()
    assert body["success"] is True
    assert body["pagination"]["total"] >= 1
    ids = [t["id"] for t in body["data"]]
    assert txn.id in ids


def test_admin_list_transactions_filter_by_status(client, session, admin_user, staff_user, student_arjun, cricket_bat):
    issued = _make_transaction(session, student_arjun.id, cricket_bat.id, staff_user.id, TransactionStatus.ISSUED)
    overdue = _make_transaction(session, student_arjun.id, cricket_bat.id, staff_user.id, TransactionStatus.OVERDUE)

    resp = client.get("/api/admin/transactions?status=OVERDUE", headers=auth_headers(admin_user.id, "ADMIN"))
    assert resp.status_code == 200
    data = resp.json()["data"]
    statuses = [t["status"] for t in data]
    assert all(s == "OVERDUE" for s in statuses)
    txn_ids = [t["id"] for t in data]
    assert overdue.id in txn_ids
    assert issued.id not in txn_ids


def test_admin_list_transactions_filter_by_equipment(client, session, admin_user, staff_user, student_arjun, cricket_bat):
    txn = _make_transaction(session, student_arjun.id, cricket_bat.id, staff_user.id)

    resp = client.get(
        f"/api/admin/transactions?equipment_id={cricket_bat.id}",
        headers=auth_headers(admin_user.id, "ADMIN"),
    )
    assert resp.status_code == 200
    data = resp.json()["data"]
    assert len(data) >= 1
    assert all(t["equipment_id"] == cricket_bat.id for t in data)
    # equipment_name should be enriched
    matched = next((t for t in data if t["id"] == txn.id), None)
    assert matched is not None
    assert matched["equipment_name"] == cricket_bat.name


def test_admin_list_transactions_pagination(client, session, admin_user, staff_user, student_arjun, cricket_bat):
    for _ in range(5):
        _make_transaction(session, student_arjun.id, cricket_bat.id, staff_user.id)

    resp = client.get("/api/admin/transactions?page=1&limit=2", headers=auth_headers(admin_user.id, "ADMIN"))
    assert resp.status_code == 200
    body = resp.json()
    assert len(body["data"]) <= 2
    assert body["pagination"]["limit"] == 2
    assert body["pagination"]["total"] >= 5


def test_admin_transactions_requires_admin_auth(client, session, staff_user, student_arjun, cricket_bat):
    _make_transaction(session, student_arjun.id, cricket_bat.id, staff_user.id)

    # Staff token should be rejected
    resp = client.get("/api/admin/transactions", headers=auth_headers(staff_user.id, "STAFF"))
    assert resp.status_code == 403

    # No token at all — HTTPBearer raises 403 by default when no credentials
    resp_no_auth = client.get("/api/admin/transactions")
    assert resp_no_auth.status_code in (401, 403)
