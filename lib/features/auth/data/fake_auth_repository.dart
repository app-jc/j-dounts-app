import 'package:drift/native.dart';

import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/core/time/clock.dart';
import 'package:j_dounts_app/features/auth/data/local_user_source.dart';
import 'package:j_dounts_app/features/auth/domain/auth_identity.dart';
import 'package:j_dounts_app/features/auth/domain/auth_repository.dart';
import 'package:j_dounts_app/features/auth/domain/validators/auth_validators.dart';

const Duration fakeAuthLatency = Duration(seconds: 1);
const String _fakeOtpCode = '123456';
const int _sqliteUniqueConstraintCode = 2067;

/// A Mock Backend (FakeAuthRepository) of [AuthRepository], stimulates authentication operations.
final class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository(
    this._users, {
    this.latency = fakeAuthLatency,
    this.clock = const SystemClock(),
  });

  final LocalUserSource _users;
  final Duration latency;
  final Clock clock;

  @override
  Future<Result<void>> requestOtp(String phone) async {
    // Validate the phone number format.
    if (!_isCanonicalPhone(phone)) {
      return const FailureResult(ValidationFailure());
    }
    // Simulate network latency.
    await Future<void>.delayed(latency);

    return const Success<void>(null);
  }

  @override
  Future<Result<String?>> pendingOtp(String phone) async {
    if (!_isCanonicalPhone(phone)) {
      return const FailureResult(ValidationFailure());
    }
    return Success(
      await _users.findMemberIdByPhone(phone) == null ? _fakeOtpCode : null,
    );
  }

  @override
  Future<Result<bool>> isRegistered(String phone) async {
    if (!_isCanonicalPhone(phone)) {
      return const FailureResult(ValidationFailure());
    }
    await Future<void>.delayed(latency);
    try {
      return Success(await _users.findMemberIdByPhone(phone) != null);
    } on SqliteException catch (error) {
      return FailureResult(StorageFailure(cause: error));
    }
  }

  @override
  Future<Result<AuthIdentity>> verifyOtp({
    required String phone,
    required String code,
  }) async {
    if (!_isCanonicalPhone(phone) || !isValidOtp(code)) {
      return const FailureResult(ValidationFailure());
    }
    await Future<void>.delayed(latency);
    try {
      final memberId = await _users.findMemberIdByPhone(phone);
      if (memberId == null) {
        return const FailureResult(
          AuthFailure(code: AuthFailureCode.notRegistered),
        );
      }
      if (code != _fakeOtpCode) {
        return const FailureResult(AuthFailure(code: AuthFailureCode.wrongOtp));
      }
      return Success(AuthIdentity(memberId: memberId));
    } on SqliteException catch (error) {
      return FailureResult(StorageFailure(cause: error));
    }
  }

  @override
  Future<Result<void>> verifyRegistrationOtp({
    required String phone,
    required String code,
  }) async {
    if (!_isCanonicalPhone(phone) || !isValidOtp(code)) {
      return const FailureResult(ValidationFailure());
    }
    await Future<void>.delayed(latency);
    try {
      // Check if the phone number is already registered. If it is, return a conflict failure.
      if (await _users.findMemberIdByPhone(phone) != null) {
        return const FailureResult(
          ConflictFailure(code: ConflictFailureCode.duplicatePhone),
        );
      }
      // Check if the provided OTP code matches the pending OTP for the given phone number.
      if (code != _fakeOtpCode) {
        return const FailureResult(AuthFailure(code: AuthFailureCode.wrongOtp));
      }
      return const Success<void>(null);
    } on SqliteException catch (error) {
      return FailureResult(StorageFailure(cause: error));
    }
  }

  @override
  Future<Result<AuthIdentity>> registerMember({
    required String phone,
    required String firstName,
    required String? lastName,
    required DateTime dateOfBirth,
  }) async {
    if (!_isCanonicalPhone(phone) ||
        !isValidFirstName(firstName) ||
        !isValidLastName(lastName ?? '') ||
        !isValidDateOfBirth(
          year: dateOfBirth.year,
          month: dateOfBirth.month,
          day: dateOfBirth.day,
          clock: clock,
        )) {
      return const FailureResult(ValidationFailure());
    }
    // Simulate network latency.
    await Future<void>.delayed(latency);

    try {
      final memberId = await _users.createMember(
        phone: phone,
        firstName: firstName.trim(),
        lastName: _normalizeLastName(lastName),
        dateOfBirth: dateOfBirth,
      );
      return Success(AuthIdentity(memberId: memberId));
    } on SqliteException catch (error) {
      if (error.extendedResultCode == _sqliteUniqueConstraintCode) {
        return FailureResult(
          ConflictFailure(
            code: ConflictFailureCode.duplicatePhone,
            cause: error,
          ),
        );
      }
      return FailureResult(StorageFailure(cause: error));
    }
  }

  @override
  Future<Result<void>> deleteMember(int memberId) async {
    if (memberId <= 0) {
      return const FailureResult(ValidationFailure());
    }
    // Simulate network latency.
    await Future<void>.delayed(latency);

    try {
      await _users.deleteMember(memberId);
      return const Success<void>(null);
    } on SqliteException catch (error) {
      return FailureResult(StorageFailure(cause: error));
    }
  }

  /// Validates if the provided phone number is in canonical format.
  bool _isCanonicalPhone(String phone) => normalizePhone(phone) == phone;

  /// Generates a random 6-digit OTP code

  /// Normalizes the last name by trimming whitespace and returning `null` if it's empty.
  String? _normalizeLastName(String? lastName) {
    final normalized = lastName?.trim();
    return normalized == null || normalized.isEmpty ? null : normalized;
  }
}
