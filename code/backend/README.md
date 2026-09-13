# SCMS Backend

FastAPI + SQLModel + PostgreSQL backend for the Smart Sports Equipment Management System.

## Quick Start

```bash
# 1. Create virtual environment
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# 2. Install dependencies
pip install -r requirements.txt

# 3. Configure environment
cp .env.example .env
# Edit DATABASE_URL to point to your PostgreSQL instance

# 4. Run migrations
alembic upgrade head

# 5. Seed demo data
python -m seed.demo_data

# 6. Start the server
uvicorn app.main:app --reload --port 8000
```

API docs: http://localhost:8000/docs

## Demo Credentials (after seeding)

| Role    | Email              | Password  |
|---------|--------------------|-----------|
| Admin   | admin@scms.edu     | admin123  |
| Staff   | staff@scms.edu     | staff123  |
| Student | arjun@college.edu  | arjun123  |
| Student | riya@college.edu   | riya123   |

## Tests

```bash
pytest tests/ -v
```

Uses SQLite in-memory — no PostgreSQL needed for tests.

## Architecture

- **Auth**: Separate `/api/auth/student/login` and `/api/auth/staff/login` endpoints.
  JWT tokens carry `role` claim used for RBAC on every protected endpoint.
- **Batch Allocation**: Bookings are collected as `REQUESTED`. At `booking_cutoff_at`,
  the fairness engine runs and assigns `CONFIRMED`/`WAITLISTED` status.
- **Fairness**: `priority_score = S_norm + P_recency`. Lower = higher priority.
- **Defaulter Blocking**: Students with an `ACTIVE` Defaulter record cannot submit new bookings.
  `StudentStatus.SUSPENDED` is a separate admin-only action — not auto-applied.
- **Scheduler**: APScheduler runs overdue detection, slot transitions, return reminders,
  and NO_SHOW detection in the background.

## API Prefix

All endpoints: `/api/...`  
See `docs/API_CONTRACT.md` for the full endpoint list.
