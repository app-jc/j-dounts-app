import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/features/auth/domain/auth_identity.dart';

abstract interface class AuthRepository {
  Future<Result<void>> requestOtp(String phone);

  Future<Result<String?>> pendingOtp(String phone);

  Future<Result<bool>> isRegistered(String phone);

  Future<Result<AuthIdentity>> verifyOtp({
    required String phone,
    required String code,
  });

  Future<Result<void>> verifyRegistrationOtp({
    required String phone,
    required String code,
  });

  Future<Result<AuthIdentity>> registerMember({
    required String phone,
    required String firstName,
    required String? lastName,
    required DateTime dateOfBirth,
  });

  Future<Result<void>> deleteMember(int memberId);
}
