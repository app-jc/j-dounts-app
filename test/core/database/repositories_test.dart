import 'dart:async';

import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/core/database/app_database.dart' hide Member;
import 'package:j_dounts_app/core/database/seed/seed_service.dart';
import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/core/member/data/member_repository_impl.dart';
import 'package:j_dounts_app/core/member/domain/member.dart';
import 'package:j_dounts_app/features/home/data/home_repository_impl.dart';
import 'package:j_dounts_app/features/product/data/product_repository_impl.dart';
import 'package:j_dounts_app/features/rewards/data/rewards_repository_impl.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase database;
  late int memberId;

  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    await SeedService(
      db: database,
      loadAsset: () => rootBundle.loadString('assets/seed/seed_data.json'),
    ).seedIfNeeded();
    memberId = (await database.select(database.members).get()).single.id;
  });

  tearDown(() async {
    await database.close();
  });

  test(
    'member watch emits mapped values after the database row changes',
    () async {
      final repository = MemberRepositoryImpl(database);
      final updates = StreamIterator(repository.watchById(memberId));

      expect(await updates.moveNext(), isTrue);
      final member = _value(updates.current);

      expect(member, isA<Member>());
      expect(member?.fullName, 'Charlotte Bennett');
      expect(member?.totalPoints, 680000);

      await (database.update(database.members)
            ..where((row) => row.id.equals(memberId)))
          .write(const MembersCompanion(totalPoints: Value(680001)));

      expect(await updates.moveNext(), isTrue);
      expect(_value(updates.current)?.totalPoints, 680001);
      await updates.cancel();
    },
  );

  test(
    'home repository composes ordered sections and watches related tables',
    () async {
      final members = MemberRepositoryImpl(database);
      final repository = HomeRepositoryImpl(database, members);
      final updates = StreamIterator(repository.watchHome(memberId));

      expect(await updates.moveNext(), isTrue);
      final first = _value(updates.current);
      expect(first.member?.fullName, 'Charlotte Bennett');
      expect(first.banners.map((banner) => banner.sortOrder), [0, 1]);
      expect(first.sections.map((section) => section.id), [
        'seasonal',
        'popular',
        'order_again',
      ]);
      expect(first.shops, hasLength(4));
      final seasonalOverride =
          first.sections.first.products.last.discountOverride;
      expect(seasonalOverride, '20% OFF');

      await (database.update(database.banners)
            ..where((row) => row.id.equals('seasonal_promo')))
          .write(const BannersCompanion(title: Value('Updated banner')));

      expect(await updates.moveNext(), isTrue);
      final updated = _value(updates.current);
      expect(updated.banners.first.title, 'Updated banner');
      await updates.cancel();
    },
  );

  test('product watch emits updates and null for a missing product', () async {
    final repository = ProductRepositoryImpl(database);
    final updates = StreamIterator(repository.watchByCode('JD022123'));

    expect(await updates.moveNext(), isTrue);
    final product = _value(updates.current);
    expect(product?.name, 'Coconut Donut');
    expect(product?.priceMmk, 3200);

    await (database.update(database.products)
          ..where((row) => row.code.equals('JD022123')))
        .write(const ProductsCompanion(name: Value('Updated donut')));

    expect(await updates.moveNext(), isTrue);
    expect(_value(updates.current)?.name, 'Updated donut');
    await updates.cancel();

    final missing = _value(await repository.watchByCode('missing').first);

    expect(missing, isNull);
  });

  test('rewards watch emits updated member challenge progress', () async {
    final members = MemberRepositoryImpl(database);
    final repository = RewardsRepositoryImpl(database, members);
    final updates = StreamIterator(repository.watchRewards(memberId));

    expect(await updates.moveNext(), isTrue);
    final rewards = _value(updates.current);

    expect(rewards.member?.fullName, 'Charlotte Bennett');
    expect(rewards.tiers.map((tier) => tier.name), [
      'Bronze',
      'Silver',
      'Gold',
      'Platinum',
    ]);
    expect(rewards.challenges.map((challenge) => challenge.current), [4, 1, 9]);
    expect(rewards.gifts, hasLength(2));

    await (database.update(database.memberChallengeProgress)..where(
          (row) =>
              row.memberId.equals(memberId) &
              row.challengeId.equals('enjoy_4_donuts'),
        ))
        .write(const MemberChallengeProgressCompanion(current: Value(3)));

    expect(await updates.moveNext(), isTrue);
    final updatedRewards = _value(updates.current);
    expect(updatedRewards.challenges.first.current, 3);
    await updates.cancel();
  });
}

T _value<T>(Result<T> result) => switch (result) {
  Success<T>(value: final value) => value,
  FailureResult<T>(failure: final failure) => throw StateError(
    'Repository emitted ${failure.type}.',
  ),
};
