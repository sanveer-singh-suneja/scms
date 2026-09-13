# SCMS Backend — CLAUDE.md

## Stack

| Layer      | Technology                              |
|------------|-----------------------------------------|
| Framework  | FastAPI 0.115                           |
| ORM        | SQLModel 0.0.21                         |
| Database   | PostgreSQL (SQLite for tests)           |
| Migrations | Alembic                                 |
| Auth       | JWT via python-jose + passlib[bcrypt]   |
| Scheduler  | APScheduler (background)                |

## Directory Structure

```
backend/
├── app/
│   ├── main.py                  FastAPI app entry point
│   ├── core/
│   │   ├── config.py            Settings (pydantic-settings)
│   │   ├── database.py          Engine + get_session
│   │   ├── security.py          JWT + password hashing
│   │   └── dependencies.py      Auth DI: CurrentStudent, CurrentUser, AdminUser
│   ├── models/
│   │   ├── enums.py             All canonical status enums
│   │   └── *.py                 10 SQLModel table models
│   ├── schemas/
│   │   └── *.py                 Pydantic request/response schemas
│   ├── routers/
│   │   ├── auth.py              POST /api/auth/student/{register,login}
│   │   │                        POST /api/auth/staff/login
│   │   ├── students.py          GET /api/students/qr, /usage-stats
│   │   ├── equipment.py         GET /api/equipment[/:id[/availability]]
│   │   ├── slots.py             GET /api/slots[/:id]
│   │   ├── bookings.py          CRUD /api/bookings
│   │   ├── qr.py                POST /api/qr/validate/{student,equipment}
│   │   ├── transactions.py      POST /api/transactions/issue, /:id/return
│   │   ├── notifications.py     GET/PUT /api/notifications
│   │   ├── inventory.py         CRUD /api/inventory (admin write, staff read)
│   │   ├── admin/               Admin-only routes
│   │   └── staff/               Staff-only routes
│   ├── services/
│   │   ├── fairness_engine.py   run_batch_allocation, promote_waitlist
│   │   ├── booking.py           create_booking, cancel_booking
│   │   ├── transaction.py       issue_equipment, return_equipment
│   │   ├── overdue.py           detect_overdue, send_return_reminders
│   │   ├── notification.py      create_notification
│   │   └── analytics.py         aggregation queries
│   └── jobs/
│       └── scheduler.py         APScheduler background jobs
├── alembic/                     Database migrations
├── seed/
│   └── demo_data.py             Hackathon demo seed
├── tests/                       Pytest test suite
├── requirements.txt
├── .env.example
└── alembic.ini
```

## Running

```bash
# Install deps
pip install -r requirements.txt

# Set up .env
cp .env.example .env
# Edit DATABASE_URL

# Run migrations (or use create_db_and_tables for dev)
alembic upgrade head

# Seed demo data
python -m seed.demo_data

# Start server
uvicorn app.main:app --reload --port 8000
```

## Running Tests

```bash
pytest tests/ -v
```

Tests use SQLite in-memory. No PostgreSQL required for tests.

## Authentication Rules

NEVER share endpoints between student and staff/admin roles.

- Student token role = "STUDENT" → use `CurrentStudent` dependency
- Staff/Admin token role = "STAFF" or "ADMIN" → use `CurrentUser` or `AdminUser`
- Use `AdminUser` for admin-only endpoints
- Never use student token on staff endpoint and vice versa

## Locked Business Rules

- BR-BOOK-05: All bookings start as REQUESTED
- BR-BOOK-06: Batch allocation only, never per-submission
- BR-OVR-05: ACTIVE Defaulter blocks new bookings; does NOT set StudentStatus.SUSPENDED
- BR-FAIR-01: priority_score = S_norm + P_recency (see FAIRNESS_ALGORITHM.md)
- BR-FAIR-02: Lower score = higher priority. Sort ASCENDING.

## NEVER DO

- Never compute priority scores in a router or schema
- Never set StudentStatus.SUSPENDED automatically for overdue equipment
- Never invent API endpoints not in docs/API_CONTRACT.md
- Never hard-code credentials or URLs
