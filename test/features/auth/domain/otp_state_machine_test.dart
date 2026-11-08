import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/core/time/clock.dart';
import 'package:j_dounts_app/features/auth/domain/otp_state_machine.dart';

final class _MutableClock implements Clock {
  _MutableClock(this.value);

  DateTime value;

  @override
  DateTime now() => value;
}

void main() {
  group('OtpStateMachine', () {
    late _MutableClock clock;

    setUp(() {
      clock = _MutableClock(DateTime(2026, 1, 1));
    });

    test('starts with three attempts and a five-minute deadline', () {
      final state = OtpStateMachine.start(clock);

      expect(state.wrongAttempts, 0);
      expect(state.attemptsRemaining, 3);
      expect(state.isLocked, isFalse);
      expect(state.canVerify(clock), isTrue);
      expect(state.canResend(clock), isFalse);
      expect(state.remaining(clock), otpResendInterval);
    });

    test('locks verification after three wrong codes', () {
      var state = OtpStateMachine.start(clock);
      state = OtpStateMachine.recordWrongCode(state, clock);
      expect(state.attemptsRemaining, 2);
      state = OtpStateMachine.recordWrongCode(state, clock);
      expect(state.attemptsRemaining, 1);
      state = OtpStateMachine.recordWrongCode(state, clock);

      expect(state.attemptsRemaining, 0);
      expect(state.isLocked, isTrue);
      expect(state.canVerify(clock), isFalse);
      expect(
        () => OtpStateMachine.recordWrongCode(state, clock),
        throwsStateError,
      );
    });

    test('derives remaining time from deadline and enables resend at zero', () {
      final state = OtpStateMachine.start(clock);
      clock.value = clock.value.add(const Duration(minutes: 4, seconds: 59));

      expect(state.remaining(clock), const Duration(seconds: 1));
      expect(state.canResend(clock), isFalse);
      expect(state.canVerify(clock), isTrue);

      clock.value = clock.value.add(const Duration(seconds: 1));
      expect(state.remaining(clock), Duration.zero);
      expect(state.canResend(clock), isTrue);
      expect(state.canVerify(clock), isFalse);
    });

    test('resend resets attempts and starts a fresh deadline', () {
      var state = OtpStateMachine.start(clock);
      state = OtpStateMachine.recordWrongCode(state, clock);
      clock.value = clock.value.add(otpResendInterval);

      state = OtpStateMachine.resend(state, clock);

      expect(state.wrongAttempts, 0);
      expect(state.attemptsRemaining, 3);
      expect(state.isLocked, isFalse);
      expect(state.canVerify(clock), isTrue);
      expect(state.canResend(clock), isFalse);
      expect(state.remaining(clock), otpResendInterval);
    });

    test('does not allow resend before the deadline', () {
      final state = OtpStateMachine.start(clock);

      expect(() => OtpStateMachine.resend(state, clock), throwsStateError);
    });
  });
}
