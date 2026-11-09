import 'dart:math';

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

final class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository(
    this._users, {
    this.latency = fakeAuthLatency,
    this.clock = const SystemClock(),
  });

  final LocalUserSource _users;
  final Duration latency;
  final Clock clock;
  final Map<String, String> _pendingOtps = {};

  @override
  Future<Result<void>> requestOtp(String phone) async {
    if (!_isCanonicalPhone(phone)) {
      return const FailureResult(ValidationFailure());
    }
    await Future<void>.delayed(latency);
    try {
      if (await _users.findMemberIdByPhone(phone) == null) {
        _pendingOtps[phone] = _generateOtp();
      }
    } on SqliteException catch (error) {
      return FailureResult(StorageFailure(cause: error));
    }
    return const Success<void>(null);
  }

  @override
  Future<Result<String?>> pendingOtp(String phone) async {
    if (!_isCanonicalPhone(phone)) {
      return const FailureResult(ValidationFailure());
    }
    return Success(_pendingOtps[phone]);
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
      if (await _users.findMemberIdByPhone(phone) != null) {
        return const FailureResult(
          ConflictFailure(code: ConflictFailureCode.duplicatePhone),
        );
      }
      if (_pendingOtps[phone] != code) {
        return const FailureResult(AuthFailure(code: AuthFailureCode.wrongOtp));
      }
      _pendingOtps.remove(phone);
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
    await Future<void>.delayed(latency);
    try {
      await _users.deleteMember(memberId);
      return const Success<void>(null);
    } on SqliteException catch (error) {
      return FailureResult(StorageFailure(cause: error));
    }
  }

  bool _isCanonicalPhone(String phone) => normalizePhone(phone) == phone;

  String _generateOtp() => Random().nextInt(1000000).toString().padLeft(6, '0');

  String? _normalizeLastName(String? lastName) {
    final normalized = lastName?.trim();
    return normalized == null || normalized.isEmpty ? null : normalized;
  }
}
