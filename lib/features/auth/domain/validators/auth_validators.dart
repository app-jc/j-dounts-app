import 'package:characters/characters.dart';

import 'package:j_dounts_app/core/time/clock.dart';

const int minimumAge = 13;
const int maximumNameGraphemes = 50;
const int otpLength = 6;
const int _maximumDayOfMonth = 31;

const String _myanmarCountryCode = '95';
const String _myanmarInternationalPrefix = '+95';
const String _myanmarMobilePrefix = '9';
const int _minimumNationalNumberLength = 8;
const int _maximumNationalNumberLength = 10;

final RegExp _phoneFormatting = RegExp(r'[\s-]');
final RegExp _englishName = RegExp(
  r'^(?:[A-Za-z\u00C0-\u024F][\u0300-\u036F]*| )+$',
);
final RegExp _asciiDigits = RegExp(r'^[0-9]+$');

String? normalizePhone(String input) {
  var value = input.replaceAll(_phoneFormatting, '');
  if (value.startsWith('+')) {
    if (!value.startsWith(_myanmarInternationalPrefix)) return null;
    value = value.substring(_myanmarInternationalPrefix.length);
  } else if (value.startsWith(_myanmarCountryCode)) {
    value = value.substring(_myanmarCountryCode.length);
  } else if (value.startsWith('0')) {
    value = value.substring(1);
  }

  if (!_isMyanmarMobileNationalNumber(value)) return null;
  return '+$_myanmarCountryCode$value';
}

bool _isMyanmarMobileNationalNumber(String value) {
  return value.startsWith(_myanmarMobilePrefix) &&
      value.length >= _minimumNationalNumberLength &&
      value.length <= _maximumNationalNumberLength &&
      _asciiDigits.hasMatch(value);
}

bool isValidOtp(String value) =>
    value.length == otpLength && _asciiDigits.hasMatch(value);

bool isValidFirstName(String value) => _isValidName(value, isRequired: true);

bool isValidLastName(String value) => _isValidName(value, isRequired: false);

bool _isValidName(String value, {required bool isRequired}) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) return !isRequired;
  return trimmed.characters.length <= maximumNameGraphemes &&
      _englishName.hasMatch(trimmed);
}

bool isValidDateOfBirth({
  required int year,
  required int month,
  required int day,
  required Clock clock,
}) {
  final today = clock.now();
  if (year < 1 || year > today.year) return false;
  final birthDate = _createValidDate(year, month, day);
  if (birthDate == null) return false;
  if (birthDate.isAfter(DateTime(today.year, today.month, today.day))) {
    return false;
  }
  return _ageOnDate(birthDate, today) >= minimumAge;
}

DateTime? _createValidDate(int year, int month, int day) {
  if (month < 1 ||
      month > DateTime.monthsPerYear ||
      day < 1 ||
      day > _maximumDayOfMonth) {
    return null;
  }
  final date = DateTime(year, month, day);
  if (date.year != year || date.month != month || date.day != day) {
    return null;
  }
  return date;
}

int _ageOnDate(DateTime birthDate, DateTime today) {
  var age = today.year - birthDate.year;
  final anniversaryDay = _anniversaryDay(birthDate, today.year);
  if (today.month < birthDate.month ||
      (today.month == birthDate.month && today.day < anniversaryDay)) {
    age--;
  }
  return age;
}

int _anniversaryDay(DateTime birthDate, int year) {
  final isLeapBirthdayInCommonYear =
      birthDate.month == DateTime.february &&
      birthDate.day == 29 &&
      !_isLeapYear(year);
  return isLeapBirthdayInCommonYear ? 28 : birthDate.day;
}

bool _isLeapYear(int year) =>
    year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
