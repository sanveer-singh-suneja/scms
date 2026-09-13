"""
Demo seed data for the SCMS hackathon demo.

Matches the DEMO_SCENARIO.md:
- 1 Admin, 1 Staff
- 5 Cricket Bats
- 1 Slot (capacity=1, today's date)
- 2 Students: Arjun (4 sessions last 7 days) and Riya (new student)

Run: python -m seed.demo_data
"""
import secrets
import sys
import os
from datetime import date, datetime, time, timedelta, timezone

# Ensure backend root is on path when running directly
sys.path.insert(0, os.path.dirname(os.path.dirname(__file__)))

from sqlmodel import Session, select
from app.core.database import create_db_and_tables, engine
from app.core.security import hash_password
from app.models import (
    Booking, Equipment, FairnessConfig, Slot, Student,
    Transaction, UsageStatistics, User,
)
from app.models.enums import (
    BookingStatus, EquipmentCondition, EquipmentStatus,
    SlotStatus, StudentStatus, TransactionStatus, UserRole, UserStatus,
)


def seed() -> None:
    create_db_and_tables()

    with Session(engine) as session:
        # ── FairnessConfig (singleton) ──────────────────────────────────────
        if not session.get(FairnessConfig, 1):
            session.add(FairnessConfig(id=1))
            session.commit()
            print("Seeded FairnessConfig defaults.")

        # ── Admin ───────────────────────────────────────────────────────────
        admin = session.exec(select(User).where(User.email == "admin@scms.edu")).first()
        if not admin:
            admin = User(
                name="SCMS Admin",
                email="admin@scms.edu",
                password_hash=hash_password("admin123"),
                role=UserRole.ADMIN,
                status=UserStatus.ACTIVE,
            )
            session.add(admin)
            session.commit()
            session.refresh(admin)
            print(f"Seeded Admin: admin@scms.edu / admin123 (id={admin.id})")

        # ── Staff ────────────────────────────────────────────────────────────
        staff = session.exec(select(User).where(User.email == "staff@scms.edu")).first()
        if not staff:
            staff = User(
                name="Sports Staff",
                email="staff@scms.edu",
                password_hash=hash_password("staff123"),
                role=UserRole.STAFF,
                status=UserStatus.ACTIVE,
                created_by=admin.id,
            )
            session.add(staff)
            session.commit()
            session.refresh(staff)
            print(f"Seeded Staff: staff@scms.edu / staff123 (id={staff.id})")

        # ── Equipment: 5 Cricket Bats ────────────────────────────────────────
        equipment_items = []
        for i in range(1, 6):
            qr = f"CRICKET-BAT-{i:03d}"
            eq = session.exec(select(Equipment).where(Equipment.qr_code == qr)).first()
            if not eq:
                eq = Equipment(
                    name=f"Cricket Bat #{i}",
                    category="Cricket",
                    qr_code=qr,
                    location="Sports Room A",
                    added_by=admin.id,
                )
                session.add(eq)
            equipment_items.append(eq)
        session.commit()
        for eq in equipment_items:
            session.refresh(eq)
        print(f"Seeded {len(equipment_items)} Cricket Bats.")

        # ── Student Arjun (4 sessions in last 7 days) ────────────────────────
        arjun = session.exec(select(Student).where(Student.email == "arjun@college.edu")).first()
        if not arjun:
            arjun = Student(
                student_id="CS2021001",
                name="Arjun Sharma",
                email="arjun@college.edu",
                department="Computer Science",
                password_hash=hash_password("arjun123"),
                qr_identifier=secrets.token_urlsafe(32),
                status=StudentStatus.ACTIVE,
            )
            session.add(arjun)
            session.commit()
            session.refresh(arjun)

            # Create usage stats and 4 past transactions
            stats = UsageStatistics(student_id=arjun.id, sessions_last_7_days=4, total_sessions=4)
            session.add(stats)

            now = datetime.now(timezone.utc)
            for j in range(4):
                bat = equipment_items[j % len(equipment_items)]
                issued_at = now - timedelta(days=j + 1, hours=2)
                returned_at = issued_at + timedelta(hours=1)
                txn = Transaction(
                    student_id=arjun.id,
                    equipment_id=bat.id,
                    issued_at=issued_at,
                    due_at=issued_at + timedelta(hours=2),
                    returned_at=returned_at,
                    status=TransactionStatus.RETURNED,
                    condition_on_return=EquipmentCondition.GOOD,
                    issued_by=staff.id,
                    returned_to=staff.id,
                )
                session.add(txn)
            session.commit()
            print(f"Seeded Student Arjun: arjun@college.edu / arjun123 (id={arjun.id}, 4 sessions)")

        # ── Student Riya (new, no history) ───────────────────────────────────
        riya = session.exec(select(Student).where(Student.email == "riya@college.edu")).first()
        if not riya:
            riya = Student(
                student_id="CS2021042",
                name="Riya Patel",
                email="riya@college.edu",
                department="Computer Science",
                password_hash=hash_password("riya123"),
                qr_identifier=secrets.token_urlsafe(32),
                status=StudentStatus.ACTIVE,
            )
            session.add(riya)
            session.commit()
            session.refresh(riya)

            stats_riya = UsageStatistics(student_id=riya.id, sessions_last_7_days=0, total_sessions=0)
            session.add(stats_riya)
            session.commit()
            print(f"Seeded Student Riya: riya@college.edu / riya123 (id={riya.id}, new student)")

        # ── Demo Slot: Cricket Bat #1, today, capacity=1 ─────────────────────
        target_bat = equipment_items[0]
        today = date.today()
        tomorrow_9am = datetime.combine(today + timedelta(days=1), time(9, 0), tzinfo=timezone.utc)
        cutoff = datetime.now(timezone.utc) + timedelta(hours=1)

        existing_slot = session.exec(
            select(Slot).where(
                Slot.equipment_id == target_bat.id,
                Slot.date == today + timedelta(days=1),
            )
        ).first()
        if not existing_slot:
            demo_slot = Slot(
                equipment_id=target_bat.id,
                date=today + timedelta(days=1),
                start_time=time(9, 0),
                end_time=time(10, 0),
                capacity=1,
                available_count=1,
                booking_cutoff_at=cutoff,
                status=SlotStatus.OPEN,
                created_by=admin.id,
            )
            session.add(demo_slot)
            session.commit()
            session.refresh(demo_slot)
            print(f"Seeded Demo Slot: Cricket Bat #1, {today + timedelta(days=1)} 09:00-10:00, capacity=1 (id={demo_slot.id})")

        print("\n=== Demo Credentials ===")
        print("Admin:    admin@scms.edu  / admin123")
        print("Staff:    staff@scms.edu  / staff123")
        print("Student:  arjun@college.edu / arjun123  (4 sessions — lower fairness priority)")
        print("Student:  riya@college.edu  / riya123   (new student — highest fairness priority)")
        print("\nFairness Demo: Both students book the same slot.")
        print("After allocation: Riya (score=0.0) → CONFIRMED, Arjun (score≈1.5) → WAITLISTED")


if __name__ == "__main__":
    seed()
