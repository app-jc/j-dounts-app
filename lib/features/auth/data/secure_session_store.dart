import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';

final class SecureSessionStore {
  SecureSessionStore({this._storage = const FlutterSecureStorage()});

  static const _memberIdKey = 'j_dounts.member_id';
  static const _installMarkerFile = '.j_dounts_install';

  final FlutterSecureStorage _storage;

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

  Future<void> writeMemberId(int memberId) async {
    if (memberId <= 0) {
      throw ArgumentError.value(memberId, 'memberId', 'Must be positive.');
    }
    await _storage.write(key: _memberIdKey, value: memberId.toString());
  }

  Future<void> clear() => _storage.delete(key: _memberIdKey);

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
