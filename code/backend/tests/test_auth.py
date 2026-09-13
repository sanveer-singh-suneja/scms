import pytest
from fastapi.testclient import TestClient
from sqlmodel import Session


def test_student_register(client: TestClient):
    res = client.post("/api/auth/student/register", json={
        "student_id": "CS999",
        "name": "Test User",
        "email": "testuser@test.com",
        "department": "CS",
        "password": "password123",
    })
    assert res.status_code == 201
    data = res.json()
    assert data["success"] is True
    assert "token" in data["data"]


def test_student_register_duplicate_email(client: TestClient):
    payload = {
        "student_id": "CS100",
        "name": "User A",
        "email": "dup@test.com",
        "department": "CS",
        "password": "pass",
    }
    client.post("/api/auth/student/register", json=payload)
    payload["student_id"] = "CS101"
    res = client.post("/api/auth/student/register", json=payload)
    assert res.status_code == 409
    assert res.json()["error"]["code"] == "EMAIL_ALREADY_EXISTS"


def test_student_login(client: TestClient):
    client.post("/api/auth/student/register", json={
        "student_id": "CS200",
        "name": "Login User",
        "email": "login@test.com",
        "department": "CS",
        "password": "mypass",
    })
    res = client.post("/api/auth/student/login", json={"email": "login@test.com", "password": "mypass"})
    assert res.status_code == 200
    assert res.json()["data"]["token"] is not None


def test_student_login_wrong_password(client: TestClient):
    client.post("/api/auth/student/register", json={
        "student_id": "CS201",
        "name": "User",
        "email": "user201@test.com",
        "department": "CS",
        "password": "correct",
    })
    res = client.post("/api/auth/student/login", json={"email": "user201@test.com", "password": "wrong"})
    assert res.status_code == 401
    assert res.json()["error"]["code"] == "INVALID_CREDENTIALS"


def test_staff_login(client: TestClient, staff_user):
    res = client.post("/api/auth/staff/login", json={"email": "staff@test.com", "password": "staff123"})
    assert res.status_code == 200
    assert res.json()["data"]["user"]["role"] == "STAFF"
