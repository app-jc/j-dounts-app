import 'package:drift/native.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/core/database/app_database.dart';
import 'package:j_dounts_app/features/auth/data/local_user_source.dart';
import 'package:j_dounts_app/features/auth/data/secure_session_store.dart';
import 'package:j_dounts_app/features/auth/presentation/session/session_notifier.dart';

void main() {
  late AppDatabase database;
  late SecureSessionStore store;
  late SessionNotifier notifier;

  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    FlutterSecureStorage.setMockInitialValues({});
    store = SecureSessionStore();
    notifier = SessionNotifier(store, LocalUserSource(database));
  });

  tearDown(() async {
    notifier.dispose();
    await database.close();
  });

  test(
    'restores a persisted session before exposing authenticated state',
    () async {
      final memberId = await _createMember(database);
      await store.writeMemberId(memberId);

      expect(notifier.isAuthenticated, isFalse);

      await notifier.restore();

      expect(notifier.memberId, memberId);
      expect(notifier.isAuthenticated, isTrue);
    },
  );

  test('clears a session whose member no longer exists', () async {
    await store.writeMemberId(42);

    await notifier.restore();

    expect(notifier.memberId, isNull);
    expect(notifier.isAuthenticated, isFalse);
    expect(await store.readMemberId(), isNull);
  });

  test('persists session changes and notifies listeners', () async {
    var notifications = 0;
    notifier.addListener(() => notifications++);

    await notifier.startSession(42);

    expect(notifier.memberId, 42);
    expect(notifier.isAuthenticated, isTrue);
    expect(notifications, 1);

    await notifier.logout();

    expect(notifier.memberId, isNull);
    expect(notifier.isAuthenticated, isFalse);
    expect(notifications, 2);
    expect(await store.readMemberId(), isNull);
  });
}

Future<int> _createMember(AppDatabase database) => database
    .into(database.members)
    .insert(
      MembersCompanion.insert(
        phone: '+95912345678',
        firstName: 'Session',
        dateOfBirth: DateTime(2000, 1, 1),
      ),
    );
