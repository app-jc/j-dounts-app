import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/features/auth/domain/auth_identity.dart';

abstract interface class AuthRepository {
  /// Requests an OTP
  Future<Result<void>> requestOtp(String phone);

  /// Retrieves the pending OTP for the given phone number, if any.
  Future<Result<String?>> pendingOtp(String phone);

  /// Checks if the given phone number is already registered.
  Future<Result<bool>> isRegistered(String phone);

  /// Verifies the provided OTP code
  Future<Result<AuthIdentity>> verifyOtp({
    required String phone,
    required String code,
  });

  /// Verifies the provided OTP code for registration purposes.
  Future<Result<void>> verifyRegistrationOtp({
    required String phone,
    required String code,
  });

  /// Registers a new member with the provided details.
  Future<Result<AuthIdentity>> registerMember({
    required String phone,
    required String firstName,
    required String? lastName,
    required DateTime dateOfBirth,
  });

  /// Deletes a member with the given member ID.
  Future<Result<void>> deleteMember(int memberId);
}
