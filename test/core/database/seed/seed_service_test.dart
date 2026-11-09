import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/app/app.dart';
import 'package:j_dounts_app/core/database/app_database.dart';
import 'package:j_dounts_app/core/database/seed/seed_service.dart';
import 'package:j_dounts_app/core/widgets/error_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase database;
  late String seedJson;

  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    seedJson = await rootBundle.loadString('assets/seed/seed_data.json');
  });

  tearDown(() async {
    await database.close();
  });

  test('seeds all records and persists the completion flag', () async {
    final service = SeedService(db: database, loadAsset: () async => seedJson);

    await service.seedIfNeeded();

    expect(await database.hasSeeded, isTrue);
    expect(await database.select(database.members).get(), hasLength(1));
    expect(await database.select(database.tiers).get(), hasLength(4));
    expect(await database.select(database.products).get(), hasLength(7));
    expect(await database.select(database.sections).get(), hasLength(3));
    expect(await database.select(database.sectionProducts).get(), isNotEmpty);
    expect(await database.select(database.banners).get(), isNotEmpty);
    expect(await database.select(database.shops).get(), isNotEmpty);
    expect(await database.select(database.challenges).get(), isNotEmpty);
    expect(
      await database.select(database.memberChallengeProgress).get(),
      isNotEmpty,
    );
    expect(await database.select(database.gifts).get(), isNotEmpty);

    final member = (await database.select(database.members).get()).single;
    final progress = await database
        .select(database.memberChallengeProgress)
        .get();
    expect(progress.every((row) => row.memberId == member.id), isTrue);
  });

  test(
    'rolls back all seed inserts when a record violates a foreign key',
    () async {
      final invalidJson = _withUnknownChallenge(seedJson);
      final service = SeedService(
        db: database,
        loadAsset: () async => invalidJson,
      );

      await expectLater(service.seedIfNeeded(), throwsA(isA<Exception>()));

      expect(await database.hasSeeded, isFalse);
      expect(await database.select(database.members).get(), isEmpty);
      expect(await database.select(database.tiers).get(), isEmpty);
      expect(await database.select(database.products).get(), isEmpty);
      expect(await database.select(database.sections).get(), isEmpty);
      expect(await database.select(database.sectionProducts).get(), isEmpty);
      expect(await database.select(database.banners).get(), isEmpty);
      expect(await database.select(database.shops).get(), isEmpty);
      expect(await database.select(database.challenges).get(), isEmpty);
      expect(
        await database.select(database.memberChallengeProgress).get(),
        isEmpty,
      );
      expect(await database.select(database.gifts).get(), isEmpty);
    },
  );

  test('does not load or insert duplicate rows on a second run', () async {
    var loadCount = 0;
    final service = SeedService(
      db: database,
      loadAsset: () async {
        loadCount++;
        return seedJson;
      },
    );

    await service.seedIfNeeded();
    await service.seedIfNeeded();

    expect(loadCount, 1);
    expect(await database.select(database.members).get(), hasLength(1));
    expect(await database.select(database.products).get(), hasLength(7));
    expect(await database.select(database.tiers).get(), hasLength(4));
  });

  testWidgets(
    'retry seeds successfully and starts the app at 1.3x text scale',
    (tester) async {
      var loadCount = 0;
      final service = SeedService(
        db: database,
        loadAsset: () async {
          loadCount++;
          return loadCount == 1 ? _withUnknownChallenge(seedJson) : seedJson;
        },
      );
      await expectLater(service.seedIfNeeded(), throwsA(isA<Exception>()));

      tester.view.physicalSize = const Size(320, 480);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        App(
          home: MediaQuery(
            data: const MediaQueryData(
              size: Size(320, 480),
              textScaler: TextScaler.linear(1.3),
            ),
            child: ErrorState(
              onRetry: () async {
                await service.seedIfNeeded();
                runApp(const App());
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      await tester.tap(find.text('Try again'));
      await tester.pumpAndSettle();

      expect(await database.hasSeeded, isTrue);
      expect(find.byType(ErrorState), findsNothing);
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}

String _withUnknownChallenge(String source) {
  final data = jsonDecode(source) as Map<String, dynamic>;
  final progress = data['challenge_progress'] as List<dynamic>;
  (progress.first as Map<String, dynamic>)['challenge_id'] = 'missing';
  return jsonEncode(data);
}
