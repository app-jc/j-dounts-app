abstract final class SeedJsonReader {
  static final RegExp _datePattern = RegExp(r'^\d{4}-\d{2}-\d{2}$');

  static Map<String, Object?> object(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is Map<String, Object?>) return value;
    throw FormatException('$key must be an object.');
  }

  static List<T> list<T>(
    Map<String, Object?> json,
    String key,
    T Function(Map<String, Object?>) parse,
  ) {
    final value = json[key];
    if (value is! List<Object?>) throw FormatException('$key must be a list.');
    return List<T>.unmodifiable(
      value.map((item) => _itemObject(item, key)).map(parse),
    );
  }

  static String string(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is String && value.isNotEmpty) return value;
    throw FormatException('$key must be a non-empty string.');
  }

  static String? nullableString(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value == null) return null;
    if (value is String) return value;
    throw FormatException('$key must be a string or null.');
  }

  static int integer(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is int) return value;
    throw FormatException('$key must be an integer.');
  }

  static bool boolean(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is bool) return value;
    throw FormatException('$key must be a boolean.');
  }

  static DateTime date(Map<String, Object?> json, String key) {
    final value = string(json, key);
    if (value.length != 10 || !_datePattern.hasMatch(value)) {
      throw FormatException('$key must be a valid YYYY-MM-DD date.');
    }
    final date = DateTime.tryParse(value);
    if (date == null || date.toIso8601String().substring(0, 10) != value) {
      throw FormatException('$key must be a valid YYYY-MM-DD date.');
    }
    return date;
  }

  static Map<String, Object?> _itemObject(Object? value, String listKey) {
    if (value is Map<String, Object?>) return value;
    throw FormatException('Items in $listKey must be objects.');
  }
}
