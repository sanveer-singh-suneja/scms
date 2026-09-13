from contextlib import asynccontextmanager
from fastapi import FastAPI, HTTPException, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse

from app.core.config import settings
from app.core.database import create_db_and_tables
from app.jobs.scheduler import start_scheduler, stop_scheduler
from app.routers import auth, bookings, equipment, inventory, notifications, qr, slots, students, transactions
from app.routers.admin import analytics, bookings as admin_bookings, defaulters, fairness, slots as admin_slots, staff, transactions as admin_transactions
from app.routers.staff import queue


@asynccontextmanager
async def lifespan(app: FastAPI):
    create_db_and_tables()
    start_scheduler()
    yield
    stop_scheduler()


app = FastAPI(
    title="SCMS API",
    description="Smart Sports Equipment Management System",
    version="1.0.0",
    lifespan=lifespan,
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.cors_origins_list,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.exception_handler(HTTPException)
async def http_exception_handler(request: Request, exc: HTTPException):
    detail = exc.detail
    if isinstance(detail, dict) and "code" in detail:
        error = detail
    else:
        error = {"code": "HTTP_ERROR", "message": str(detail)}
    return JSONResponse(
        status_code=exc.status_code,
        content={"success": False, "error": error},
    )


@app.exception_handler(Exception)
async def generic_exception_handler(request: Request, exc: Exception):
    message = str(exc) if settings.APP_ENV != "production" else "An unexpected error occurred."
    return JSONResponse(
        status_code=500,
        content={"success": False, "error": {"code": "INTERNAL_ERROR", "message": message}},
    )


API_PREFIX = "/api"

app.include_router(auth.router, prefix=API_PREFIX)
app.include_router(students.router, prefix=API_PREFIX)
app.include_router(equipment.router, prefix=API_PREFIX)
app.include_router(slots.router, prefix=API_PREFIX)
app.include_router(bookings.router, prefix=API_PREFIX)
app.include_router(qr.router, prefix=API_PREFIX)
app.include_router(transactions.router, prefix=API_PREFIX)
app.include_router(notifications.router, prefix=API_PREFIX)
app.include_router(inventory.router, prefix=API_PREFIX)
app.include_router(admin_slots.router, prefix=API_PREFIX)
app.include_router(admin_bookings.router, prefix=API_PREFIX)
app.include_router(defaulters.router, prefix=API_PREFIX)
app.include_router(analytics.router, prefix=API_PREFIX)
app.include_router(fairness.router, prefix=API_PREFIX)
app.include_router(staff.router, prefix=API_PREFIX)
app.include_router(admin_transactions.router, prefix=API_PREFIX)
app.include_router(queue.router, prefix=API_PREFIX)


@app.get("/api/health")
def health():
    return {"status": "ok", "service": "SCMS API"}
