import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';

final class SecureSessionStore {
  SecureSessionStore({this._storage = const FlutterSecureStorage()});

  static const _memberIdKey = 'j_dounts.member_id';
  static const _installMarkerFile = '.j_dounts_install';

  final FlutterSecureStorage _storage;

  /// MEMBER ID
  /// Reads the member ID from secure storage.
  /// Returns `null` if no member ID is stored.
  /// Throws a [FormatException] if the stored member ID is not a valid positive integer.
  Future<int?> readMemberId() async {
    final storedMemberId = await _storage.read(key: _memberIdKey);
    if (storedMemberId == null) return null;

    final memberId = int.tryParse(storedMemberId);
    if (memberId == null ||
        memberId <= 0 ||
        memberId.toString() != storedMemberId) {
      throw FormatException('Stored member ID is invalid.', storedMemberId);
    }

    return memberId;
  }

  /// Writes the member ID to secure storage.
  /// Throws an [ArgumentError] if the member ID is not positive.
  Future<void> writeMemberId(int memberId) async {
    if (memberId <= 0) {
      throw ArgumentError.value(memberId, 'memberId', 'Must be positive.');
    }

    await _storage.write(key: _memberIdKey, value: memberId.toString());
  }

  /// Deletes the member ID from secure storage.
  Future<void> clear() => _storage.delete(key: _memberIdKey);

  /// NEW INSTALL MARKER
  /// Resets the secure session store if this is a new install.
  Future<void> resetIfNewInstall({Directory? appSupportDirectory}) async {
    final directory =
        appSupportDirectory ?? await getApplicationSupportDirectory();
    final marker = File('${directory.path}/$_installMarkerFile');
    if (await marker.exists()) return;

    await clear();
    await directory.create(recursive: true);
    await marker.writeAsString('installed', flush: true);
  }
}
