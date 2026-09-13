/// All errors the app can encounter, normalized from backend + network.
sealed class AppException implements Exception {
  const AppException();

  String get userMessage;
}

/// Backend returned {"success": false, "error": {"code": "...", "message": "..."}}
final class ApiException extends AppException {
  const ApiException({required this.code, required this.message});

  final String code;
  final String message;

  @override
  String get userMessage => message;

  @override
  String toString() => 'ApiException($code): $message';
}

/// Network unreachable, timeout, DNS failure
final class NetworkException extends AppException {
  const NetworkException([this.detail]);

  final String? detail;

  @override
  String get userMessage =>
      'Unable to connect. Please check your internet connection.';
}

/// HTTP error without a structured body (5xx, unexpected format)
final class ServerException extends AppException {
  const ServerException({required this.statusCode});

  final int statusCode;

  @override
  String get userMessage => 'Server error ($statusCode). Please try again.';
}

/// Local validation before sending a request
final class ValidationException extends AppException {
  const ValidationException(this.message);

  final String message;

  @override
  String get userMessage => message;
}

/// JWT expired — user needs to re-login
final class SessionExpiredException extends AppException {
  const SessionExpiredException();

  @override
  String get userMessage => 'Your session has expired. Please sign in again.';
}

// ---------------------------------------------------------------------------
// Named error codes from the backend API contract
// ---------------------------------------------------------------------------

abstract final class ApiErrorCode {
  static const unauthorized = 'UNAUTHORIZED';
  static const tokenExpired = 'TOKEN_EXPIRED';
  static const forbidden = 'FORBIDDEN';
  static const invalidCredentials = 'INVALID_CREDENTIALS';
  static const accountSuspended = 'ACCOUNT_SUSPENDED';
  static const accountInactive = 'ACCOUNT_INACTIVE';
  static const emailAlreadyExists = 'EMAIL_ALREADY_EXISTS';
  static const studentIdAlreadyExists = 'STUDENT_ID_ALREADY_EXISTS';
  static const slotNotAvailable = 'SLOT_NOT_AVAILABLE';
  static const slotBookingClosed = 'SLOT_BOOKING_CLOSED';
  static const duplicateBooking = 'DUPLICATE_BOOKING';
  static const usageCapReached = 'USAGE_CAP_REACHED';
  static const activeDefaulter = 'ACTIVE_DEFAULTER';
  static const bookingNotFound = 'BOOKING_NOT_FOUND';
  static const bookingCannotCancel = 'BOOKING_CANNOT_CANCEL';
  static const equipmentNotFound = 'EQUIPMENT_NOT_FOUND';
  static const equipmentMismatch = 'EQUIPMENT_MISMATCH';
  static const equipmentAlreadyIssued = 'EQUIPMENT_ALREADY_ISSUED';
  static const transactionNotFound = 'TRANSACTION_NOT_FOUND';
  static const invalidTransactionState = 'INVALID_TRANSACTION_STATE';
  static const damageReportRequired = 'DAMAGE_REPORT_REQUIRED';
  static const qrNotFound = 'QR_NOT_FOUND';
}
