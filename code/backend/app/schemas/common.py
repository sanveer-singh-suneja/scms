from typing import Any, Generic, Optional, TypeVar
from pydantic import BaseModel

T = TypeVar("T")


class Pagination(BaseModel):
    page: int
    limit: int
    total: int
    totalPages: int


class StandardResponse(BaseModel, Generic[T]):
    success: bool = True
    data: Optional[T] = None
    pagination: Optional[Pagination] = None

    @classmethod
    def ok(cls, data: Any) -> "StandardResponse":
        return cls(success=True, data=data)

    @classmethod
    def list_ok(cls, data: Any, page: int, limit: int, total: int) -> "StandardResponse":
        total_pages = (total + limit - 1) // limit if limit > 0 else 1
        return cls(
            success=True,
            data=data,
            pagination=Pagination(page=page, limit=limit, total=total, totalPages=total_pages),
        )


class ErrorDetail(BaseModel):
    code: str
    message: str


class ErrorResponse(BaseModel):
    success: bool = False
    error: ErrorDetail
