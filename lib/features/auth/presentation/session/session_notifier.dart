import 'package:flutter/foundation.dart';

import 'package:j_dounts_app/features/auth/data/local_user_source.dart';
import 'package:j_dounts_app/features/auth/data/secure_session_store.dart';

final class SessionNotifier extends ChangeNotifier {
  SessionNotifier(this._store, this._users);

  final SecureSessionStore _store;
  final LocalUserSource _users;

  int? _memberId;

  int? get memberId => _memberId;
  bool get isAuthenticated => _memberId != null;

  Future<void> prepareForInstall() => _store.resetIfNewInstall();

  Future<void> restore() async {
    final storedMemberId = await _store.readMemberId();
    if (storedMemberId == null) {
      _updateMemberId(null);
      return;
    }

    if (await _users.memberExists(storedMemberId)) {
      _updateMemberId(storedMemberId);
      return;
    }

    await _store.clear();
    _updateMemberId(null);
  }

  Future<void> startSession(int memberId) async {
    if (memberId <= 0) {
      throw ArgumentError.value(memberId, 'memberId', 'Must be positive.');
    }
    await _store.writeMemberId(memberId);
    _updateMemberId(memberId);
  }

  Future<void> logout() async {
    await _store.clear();
    _updateMemberId(null);
  }

  void _updateMemberId(int? memberId) {
    if (_memberId == memberId) return;
    _memberId = memberId;
    notifyListeners();
  }
}
