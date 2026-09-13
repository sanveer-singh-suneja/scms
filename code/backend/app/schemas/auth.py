from pydantic import BaseModel, EmailStr


class StudentRegisterRequest(BaseModel):
    student_id: str
    name: str
    email: EmailStr
    department: str
    password: str


class StudentLoginRequest(BaseModel):
    email: EmailStr
    password: str


class StaffLoginRequest(BaseModel):
    email: EmailStr
    password: str


class TokenResponse(BaseModel):
    token: str
    token_type: str = "bearer"


class StudentAuthResponse(BaseModel):
    token: str
    token_type: str = "bearer"
    student: dict


class StaffAuthResponse(BaseModel):
    token: str
    token_type: str = "bearer"
    user: dict
