import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/features/auth/data/secure_session_store.dart';

void main() {
  late Map<String, String> storedValues;
  late SecureSessionStore store;

  setUp(() {
    storedValues = {'unrelated.key': 'preserved'};
    FlutterSecureStorage.setMockInitialValues(storedValues);
    store = SecureSessionStore();
  });

  test('reads and writes a positive member ID', () async {
    expect(await store.readMemberId(), isNull);

    await store.writeMemberId(42);

    expect(await store.readMemberId(), 42);
  });

  test('clears only the session member ID', () async {
    await store.writeMemberId(42);

    await store.clear();

    expect(await store.readMemberId(), isNull);
    expect(storedValues, {'unrelated.key': 'preserved'});
  });

  test('rejects invalid stored member IDs', () async {
    FlutterSecureStorage.setMockInitialValues({
      'j_dounts.member_id': 'invalid',
    });

    await expectLater(store.readMemberId(), throwsFormatException);
  });

  test('rejects non-positive member IDs', () async {
    await expectLater(store.writeMemberId(0), throwsArgumentError);
  });

  test(
    'clears secure session once when the install marker is missing',
    () async {
      final directory = await Directory.systemTemp.createTemp('j_dounts_test_');
      addTearDown(() => directory.delete(recursive: true));
      await store.writeMemberId(42);

      await store.resetIfNewInstall(appSupportDirectory: directory);

      expect(await store.readMemberId(), isNull);
      await store.writeMemberId(42);
      await store.resetIfNewInstall(appSupportDirectory: directory);
      expect(await store.readMemberId(), 42);
    },
  );
}
