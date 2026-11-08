import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/core/time/clock.dart';
import 'package:j_dounts_app/features/auth/domain/validators/auth_validators.dart';

final class _FixedClock implements Clock {
  const _FixedClock(this.value);

  final DateTime value;

  @override
  DateTime now() => value;
}

String _repeat(String value, int count) => List.filled(count, value).join();

void main() {
  group('normalizePhone', () {
    test('normalizes local and international Myanmar mobile numbers', () {
      expect(normalizePhone('09 123 45678'), '+95912345678');
      expect(normalizePhone('0912345678'), '+95912345678');
      expect(normalizePhone('+95912345678'), '+95912345678');
      expect(normalizePhone('95912345678'), '+95912345678');
      expect(normalizePhone(' +95-9-123-45678 '), '+95912345678');
    });

    test('rejects invalid Myanmar mobile numbers', () {
      expect(normalizePhone('0712345678'), isNull);
      expect(normalizePhone('09123456'), isNull);
      expect(normalizePhone('091234567890'), isNull);
      expect(normalizePhone('+44123456789'), isNull);
      expect(normalizePhone('+0912345678'), isNull);
      expect(normalizePhone('၀၉၁၂၃၄၅၆၇၈'), isNull);
    });
  });

  group('OTP format', () {
    test('accepts exactly six ASCII digits', () {
      expect(isValidOtp('123456'), isTrue);
    });

    test('rejects wrong length and non-ASCII digits', () {
      expect(isValidOtp('12345'), isFalse);
      expect(isValidOtp('1234567'), isFalse);
      expect(isValidOtp('12 456'), isFalse);
      expect(isValidOtp('၁၂၃၄၅၆'), isFalse);
    });
  });

  group('name validation', () {
    test('requires a first name and allows an empty optional last name', () {
      expect(isValidFirstName('  '), isFalse);
      expect(isValidLastName('  '), isTrue);
      expect(isValidFirstName('  Alice Smith  '), isTrue);
      expect(isValidLastName('Smith Jones'), isTrue);
    });

    test(
      'accepts Latin graphemes and rejects Myanmar text and punctuation',
      () {
        expect(isValidFirstName('José'), isTrue);
        expect(isValidFirstName('e\u0301'), isTrue);
        expect(isValidFirstName('\u0301e'), isFalse);
        expect(isValidFirstName('Aung Min'), isTrue);
        expect(isValidFirstName('မောင်'), isFalse);
        expect(isValidFirstName('Aung2'), isFalse);
        expect(isValidFirstName('Aung၁'), isFalse);
        expect(isValidLastName('Smith-Win'), isFalse);
        expect(isValidLastName('Doe!'), isFalse);
      },
    );

    test('enforces the trimmed 50-grapheme boundary', () {
      expect(isValidFirstName(_repeat('A', maximumNameGraphemes)), isTrue);
      expect(isValidFirstName(_repeat('A', maximumNameGraphemes + 1)), isFalse);
      expect(isValidFirstName(' ${_repeat('e\u0301', 50)} '), isTrue);
      expect(isValidFirstName(_repeat('e\u0301', 51)), isFalse);
    });
  });

  group('date of birth validation', () {
    final clock = _FixedClock(DateTime(2026, 6, 15));

    test('requires a real calendar date', () {
      expect(
        isValidDateOfBirth(year: 2000, month: 4, day: 31, clock: clock),
        isFalse,
      );
      expect(
        isValidDateOfBirth(year: 2000, month: 13, day: 1, clock: clock),
        isFalse,
      );
      expect(
        isValidDateOfBirth(year: 2000, month: 2, day: 29, clock: clock),
        isTrue,
      );
      expect(
        isValidDateOfBirth(year: 2001, month: 2, day: 29, clock: clock),
        isFalse,
      );
    });

    test('rejects future dates and enforces the age-13 boundary', () {
      expect(
        isValidDateOfBirth(year: 2013, month: 6, day: 16, clock: clock),
        isFalse,
      );
      expect(
        isValidDateOfBirth(year: 2013, month: 6, day: 15, clock: clock),
        isTrue,
      );
      expect(
        isValidDateOfBirth(year: 2013, month: 6, day: 16, clock: clock),
        isFalse,
      );
      expect(
        isValidDateOfBirth(year: 2026, month: 6, day: 16, clock: clock),
        isFalse,
      );
    });

    test('uses February 28 for leap-day birthdays in common years', () {
      final february28Clock = _FixedClock(DateTime(2025, 2, 28));
      final february27Clock = _FixedClock(DateTime(2025, 2, 27));

      expect(
        isValidDateOfBirth(
          year: 2012,
          month: 2,
          day: 29,
          clock: february28Clock,
        ),
        isTrue,
      );
      expect(
        isValidDateOfBirth(
          year: 2012,
          month: 2,
          day: 29,
          clock: february27Clock,
        ),
        isFalse,
      );
    });
  });
}
