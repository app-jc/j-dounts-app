import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/core/time/clock.dart';
import 'package:j_dounts_app/features/auth/domain/auth_repository.dart';
import 'package:j_dounts_app/features/auth/domain/auth_identity.dart';
import 'package:j_dounts_app/features/auth/domain/otp_state_machine.dart';
import 'package:j_dounts_app/features/auth/domain/validators/auth_validators.dart';

enum OtpStatus { idle, verifying, verified, resending }

final class OtpState extends Equatable {
  const OtpState({
    required this.attempt,
    this.code = '',
    this.status = OtpStatus.idle,
    this.failure,
    this.remaining = otpResendInterval,
    this.shakeToken = 0,
    this.identity,
  });

  final OtpAttemptState attempt;
  final String code;
  final OtpStatus status;
  final Failure? failure;
  final Duration remaining;
  final int shakeToken;
  final AuthIdentity? identity;

  bool get isLocked => attempt.isLocked;
  bool get canSubmit =>
      isValidOtp(code) &&
      !isLocked &&
      remaining > Duration.zero &&
      status == OtpStatus.idle;

  OtpState copyWith({
    OtpAttemptState? attempt,
    String? code,
    OtpStatus? status,
    Failure? failure,
    Duration? remaining,
    int? shakeToken,
    bool clearFailure = false,
    AuthIdentity? identity,
  }) => OtpState(
    attempt: attempt ?? this.attempt,
    code: code ?? this.code,
    status: status ?? this.status,
    failure: clearFailure ? null : failure ?? this.failure,
    remaining: remaining ?? this.remaining,
    shakeToken: shakeToken ?? this.shakeToken,
    identity: identity ?? this.identity,
  );

  @override
  List<Object?> get props => [
    attempt,
    code,
    status,
    failure,
    remaining,
    shakeToken,
    identity,
  ];
}

final class OtpCubit extends Cubit<OtpState> {
  OtpCubit(
    this._authRepository, {
    required this.phone,
    this.isRegistration = false,
    Clock? clock,
  }) : _clock = clock ?? const SystemClock(),
       super(
         OtpState(attempt: OtpStateMachine.start(clock ?? const SystemClock())),
       ) {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
    if (isRegistration) unawaited(_prepareAutofill());
  }

  final AuthRepository _authRepository;
  final Clock _clock;
  final String phone;
  final bool isRegistration;
  late final Timer _timer;
  Timer? _autofillTimer;
  bool _isBusy = false;

  void updateCode(String code) {
    if (state.status != OtpStatus.idle || state.isLocked) return;
    emit(state.copyWith(code: code, clearFailure: true));
  }

  Future<void> verify() async {
    if (_isBusy || !state.canSubmit) return;
    _isBusy = true;
    emit(state.copyWith(status: OtpStatus.verifying, clearFailure: true));
    final result = isRegistration
        ? await _authRepository.verifyRegistrationOtp(
            phone: phone,
            code: state.code,
          )
        : await _authRepository.verifyOtp(phone: phone, code: state.code);
    final failure = result.fold(
      onSuccess: (_) => null,
      onFailure: (value) => value,
    );
    if (failure == null) {
      _isBusy = false;
      emit(
        state.copyWith(
          status: OtpStatus.verified,
          identity: result is Success<AuthIdentity> ? result.value : null,
        ),
      );
      return;
    }
    if (failure is AuthFailure && failure.code == AuthFailureCode.wrongOtp) {
      final nextAttempt = OtpStateMachine.recordWrongCode(
        state.attempt,
        _clock,
      );
      _isBusy = false;
      emit(
        state.copyWith(
          attempt: nextAttempt,
          code: '',
          status: OtpStatus.idle,
          failure: failure,
          shakeToken: state.shakeToken + 1,
        ),
      );
      return;
    }
    _finishWithFailure(failure);
  }

  Future<void> resend() async {
    if (_isBusy || !state.attempt.canResend(_clock)) return;
    _isBusy = true;
    emit(state.copyWith(status: OtpStatus.resending, clearFailure: true));
    final result = await _authRepository.requestOtp(phone);
    final failure = result.fold(
      onSuccess: (_) => null,
      onFailure: (value) => value,
    );
    if (failure != null) {
      _finishWithFailure(failure);
      return;
    }
    _isBusy = false;
    final attempt = OtpStateMachine.resend(state.attempt, _clock);
    emit(
      state.copyWith(
        attempt: attempt,
        code: '',
        status: OtpStatus.idle,
        remaining: attempt.remaining(_clock),
      ),
    );
  }

  @override
  Future<void> close() {
    _timer.cancel();
    _autofillTimer?.cancel();
    return super.close();
  }

  void _tick() {
    if (isClosed) return;
    emit(state.copyWith(remaining: state.attempt.remaining(_clock)));
  }

  void _finishWithFailure(Failure failure) {
    _isBusy = false;
    emit(state.copyWith(status: OtpStatus.idle, failure: failure));
  }

  Future<void> _prepareAutofill() async {
    final result = await _authRepository.pendingOtp(phone);
    if (isClosed) return;
    final code = result.fold(
      onSuccess: (value) => value,
      onFailure: (failure) {
        emit(state.copyWith(failure: failure));
        return null;
      },
    );
    if (code == null || isClosed) return;
    _autofillTimer = Timer(const Duration(milliseconds: 300), () {
      if (isClosed || state.status != OtpStatus.idle || state.code.isNotEmpty) {
        return;
      }
      updateCode(code);
      unawaited(verify());
    });
  }
}
