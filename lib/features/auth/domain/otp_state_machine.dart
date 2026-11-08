import 'package:equatable/equatable.dart';

import 'package:j_dounts_app/core/time/clock.dart';

const int maximumOtpAttempts = 3;
const Duration otpResendInterval = Duration(minutes: 5);

final class OtpAttemptState extends Equatable {
  const OtpAttemptState._({
    required this.wrongAttempts,
    required this.resendDeadline,
  });

  final int wrongAttempts;
  final DateTime resendDeadline;

  int get attemptsRemaining => maximumOtpAttempts - wrongAttempts;
  bool get isLocked => wrongAttempts >= maximumOtpAttempts;

  Duration remaining(Clock clock) {
    final timeLeft = resendDeadline.difference(clock.now());
    return timeLeft.isNegative ? Duration.zero : timeLeft;
  }

  bool canResend(Clock clock) => remaining(clock) == Duration.zero;

  bool canVerify(Clock clock) => !isLocked && !canResend(clock);

  @override
  List<Object?> get props => [wrongAttempts, resendDeadline];
}

abstract final class OtpStateMachine {
  static OtpAttemptState start(Clock clock) => OtpAttemptState._(
    wrongAttempts: 0,
    resendDeadline: clock.now().add(otpResendInterval),
  );

  static OtpAttemptState recordWrongCode(OtpAttemptState state, Clock clock) {
    if (!state.canVerify(clock)) {
      throw StateError('OTP verification is not currently allowed.');
    }
    return OtpAttemptState._(
      wrongAttempts: state.wrongAttempts + 1,
      resendDeadline: state.resendDeadline,
    );
  }

  static OtpAttemptState resend(OtpAttemptState state, Clock clock) {
    if (!state.canResend(clock)) {
      throw StateError('OTP resend is not currently allowed.');
    }
    return OtpAttemptState._(
      wrongAttempts: 0,
      resendDeadline: clock.now().add(otpResendInterval),
    );
  }
}
