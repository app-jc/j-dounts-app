import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import 'package:j_dounts_app/core/database/app_database.dart';
import 'package:j_dounts_app/core/database/seed/seed_catalog_dtos.dart';
import 'package:j_dounts_app/core/database/seed/seed_data_dto.dart';

typedef SeedAssetLoader = Future<String> Function();

final class SeedService {
  SeedService({required AppDatabase db, SeedAssetLoader? loadAsset})
    : _database = db,
      _loadAsset = loadAsset ?? _loadBundledSeed;

  static const String _seedAssetPath = 'assets/seed/seed_data.json';

  final AppDatabase _database;
  final SeedAssetLoader _loadAsset;

  Future<void> seedIfNeeded() async {
    if (await _database.hasSeeded) return;
    final seed = SeedDataDto.decode(await _loadAsset());

    await _database.transaction(() async {
      if (await _database.hasSeeded) return;
      final memberId = await _database
          .into(_database.members)
          .insert(_memberRow(seed.member));
      await _insertSeedRecords(seed, memberId);
      await _database.markSeeded();
    });
  }

  Future<void> _insertSeedRecords(SeedDataDto seed, int memberId) =>
      _database.batch((batch) {
        batch.insertAll(_database.tiers, seed.tiers.map(_tierRow));
        batch.insertAll(_database.products, seed.products.map(_productRow));
        batch.insertAll(_database.sections, seed.sections.map(_sectionRow));
        batch.insertAll(
          _database.sectionProducts,
          seed.sectionProducts.map(_sectionProductRow),
        );
        batch.insertAll(_database.banners, seed.banners.map(_bannerRow));
        batch.insertAll(_database.shops, seed.shops.map(_shopRow));
        batch.insertAll(
          _database.challenges,
          seed.challenges.map(_challengeRow),
        );
        batch.insertAll(
          _database.memberChallengeProgress,
          seed.challengeProgress.map(
            (row) => _progressRow(row, memberId, seed.member.phone),
          ),
        );
        batch.insertAll(_database.gifts, seed.gifts.map(_giftRow));
      });

  static Future<String> _loadBundledSeed() =>
      rootBundle.loadString(_seedAssetPath);

  static MembersCompanion _memberRow(SeedMemberDto member) =>
      MembersCompanion.insert(
        phone: member.phone,
        firstName: member.firstName,
        lastName: Value(member.lastName),
        dateOfBirth: member.dateOfBirth,
        photo: Value(member.photo),
        totalPoints: Value(member.totalPoints),
        notificationCount: Value(member.notificationCount),
      );

  static TiersCompanion _tierRow(SeedTierDto tier) => TiersCompanion.insert(
    name: tier.name,
    threshold: tier.threshold,
    sortOrder: tier.sortOrder,
  );

  static ProductsCompanion _productRow(SeedProductDto product) =>
      ProductsCompanion.insert(
        code: product.code,
        name: product.name,
        priceMmk: product.priceMmk,
        isNew: Value(product.isNew),
        discountLabel: Value(product.discountLabel),
        description: product.description,
        image: product.image,
      );

  static SectionsCompanion _sectionRow(SeedSectionDto section) =>
      SectionsCompanion.insert(
        id: section.id,
        title: section.title,
        type: section.type,
        layoutStyle: section.layoutStyle,
        sortOrder: section.sortOrder,
        seeAll: Value(section.seeAll),
      );

  static SectionProductsCompanion _sectionProductRow(
    SeedSectionProductDto item,
  ) => SectionProductsCompanion.insert(
    sectionId: item.sectionId,
    productCode: item.productCode,
    sortOrder: item.sortOrder,
    discountOverride: Value(item.discountOverride),
  );

  static BannersCompanion _bannerRow(SeedBannerDto banner) =>
      BannersCompanion.insert(
        id: banner.id,
        title: banner.title,
        image: banner.image,
        sortOrder: banner.sortOrder,
        target: Value(banner.target),
      );

  static ShopsCompanion _shopRow(SeedShopDto shop) => ShopsCompanion.insert(
    id: shop.id,
    name: shop.name,
    photo: shop.photo,
    sortOrder: shop.sortOrder,
  );

  static ChallengesCompanion _challengeRow(SeedChallengeDto challenge) =>
      ChallengesCompanion.insert(
        id: challenge.id,
        title: challenge.title,
        goal: challenge.goal,
        pointsReward: challenge.pointsReward,
        artworkType: challenge.artworkType,
        sortOrder: challenge.sortOrder,
      );

  static MemberChallengeProgressCompanion _progressRow(
    SeedChallengeProgressDto progress,
    int memberId,
    String seededMemberPhone,
  ) {
    if (progress.memberPhone != seededMemberPhone) {
      throw const FormatException(
        'Challenge progress references an unknown member.',
      );
    }
    return MemberChallengeProgressCompanion.insert(
      memberId: memberId,
      challengeId: progress.challengeId,
      current: Value(progress.current),
    );
  }

  static GiftsCompanion _giftRow(SeedGiftDto gift) => GiftsCompanion.insert(
    id: gift.id,
    title: gift.title,
    pointsCost: gift.pointsCost,
    image: gift.image,
    sortOrder: gift.sortOrder,
  );
}
