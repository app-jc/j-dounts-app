import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/features/auth/domain/auth_repository.dart';
import 'package:j_dounts_app/features/auth/domain/validators/auth_validators.dart';
import 'package:j_dounts_app/features/auth/presentation/flow/auth_flow_cubit.dart';

enum PhoneStatus { idle, submitting, submitted }

final class PhoneState extends Equatable {
  const PhoneState({
    this.phone = '',
    this.status = PhoneStatus.idle,
    this.failure,
    this.hasBlurred = false,
  });

  final String phone;
  final PhoneStatus status;
  final Failure? failure;
  final bool hasBlurred;

  bool get isValid => normalizePhone(phone) != null;

  PhoneState copyWith({
    String? phone,
    PhoneStatus? status,
    Failure? failure,
    bool clearFailure = false,
    bool? hasBlurred,
  }) => PhoneState(
    phone: phone ?? this.phone,
    status: status ?? this.status,
    failure: clearFailure ? null : failure ?? this.failure,
    hasBlurred: hasBlurred ?? this.hasBlurred,
  );

  @override
  List<Object?> get props => [phone, status, failure, hasBlurred];
}

final class PhoneCubit extends Cubit<PhoneState> {
  PhoneCubit(this._authRepository) : super(const PhoneState());

  final AuthRepository _authRepository;
  bool _isSubmitting = false;

  void updatePhone(String phone) {
    emit(
      state.copyWith(
        phone: phone,
        clearFailure: true,
        status: PhoneStatus.idle,
      ),
    );
  }

  void markBlurred() {
    if (state.hasBlurred) return;
    emit(
      state.copyWith(
        hasBlurred: true,
        failure: state.isValid ? null : const ValidationFailure(),
      ),
    );
  }

  Future<void> submit(AuthFlowType flow) async {
    if (_isSubmitting || !state.isValid) {
      if (!state.isValid) {
        emit(
          state.copyWith(hasBlurred: true, failure: const ValidationFailure()),
        );
      }
      return;
    }

    _isSubmitting = true;
    emit(state.copyWith(status: PhoneStatus.submitting, clearFailure: true));
    final phone = normalizePhone(state.phone)!;
    final registrationResult = await _authRepository.isRegistered(phone);
    final registrationFailure = registrationResult.fold(
      onSuccess: (isRegistered) => _flowFailure(flow, isRegistered),
      onFailure: (failure) => failure,
    );
    if (registrationFailure != null) {
      _finishWithFailure(registrationFailure);
      return;
    }

    final otpResult = await _authRepository.requestOtp(phone);
    final failure = otpResult.fold(
      onSuccess: (_) => null,
      onFailure: (value) => value,
    );
    if (failure != null) {
      _finishWithFailure(failure);
      return;
    }

    _isSubmitting = false;
    emit(state.copyWith(phone: phone, status: PhoneStatus.submitted));
  }

  Failure? _flowFailure(AuthFlowType flow, bool isRegistered) {
    if (flow == AuthFlowType.login && !isRegistered) {
      return const AuthFailure(code: AuthFailureCode.notRegistered);
    }
    if (flow == AuthFlowType.registration && isRegistered) {
      return const ConflictFailure(code: ConflictFailureCode.duplicatePhone);
    }
    return null;
  }

  void _finishWithFailure(Failure failure) {
    _isSubmitting = false;
    emit(state.copyWith(status: PhoneStatus.idle, failure: failure));
  }
}
