import 'package:j_dounts_app/core/database/seed/seed_json_reader.dart';

final class SeedTierDto {
  const SeedTierDto({
    required this.name,
    required this.threshold,
    required this.sortOrder,
  });

  final String name;
  final int threshold;
  final int sortOrder;

  factory SeedTierDto.fromJson(Map<String, Object?> json) => SeedTierDto(
    name: SeedJsonReader.string(json, 'name'),
    threshold: SeedJsonReader.integer(json, 'threshold'),
    sortOrder: SeedJsonReader.integer(json, 'sort_order'),
  );
}

final class SeedProductDto {
  const SeedProductDto({
    required this.code,
    required this.name,
    required this.priceMmk,
    required this.isNew,
    required this.discountLabel,
    required this.description,
    required this.image,
  });

  final String code;
  final String name;
  final int priceMmk;
  final bool isNew;
  final String? discountLabel;
  final String description;
  final String image;

  factory SeedProductDto.fromJson(Map<String, Object?> json) => SeedProductDto(
    code: SeedJsonReader.string(json, 'code'),
    name: SeedJsonReader.string(json, 'name'),
    priceMmk: SeedJsonReader.integer(json, 'price_mmk'),
    isNew: SeedJsonReader.boolean(json, 'is_new'),
    discountLabel: SeedJsonReader.nullableString(json, 'discount_label'),
    description: SeedJsonReader.string(json, 'description'),
    image: SeedJsonReader.string(json, 'image'),
  );
}

final class SeedSectionDto {
  const SeedSectionDto({
    required this.id,
    required this.title,
    required this.type,
    required this.layoutStyle,
    required this.sortOrder,
    required this.seeAll,
  });

  final String id;
  final String title;
  final String type;
  final String layoutStyle;
  final int sortOrder;
  final bool seeAll;

  factory SeedSectionDto.fromJson(Map<String, Object?> json) => SeedSectionDto(
    id: SeedJsonReader.string(json, 'id'),
    title: SeedJsonReader.string(json, 'title'),
    type: SeedJsonReader.string(json, 'type'),
    layoutStyle: SeedJsonReader.string(json, 'layout_style'),
    sortOrder: SeedJsonReader.integer(json, 'sort_order'),
    seeAll: SeedJsonReader.boolean(json, 'see_all'),
  );
}

final class SeedSectionProductDto {
  const SeedSectionProductDto({
    required this.sectionId,
    required this.productCode,
    required this.sortOrder,
    required this.discountOverride,
  });

  final String sectionId;
  final String productCode;
  final int sortOrder;
  final String? discountOverride;

  factory SeedSectionProductDto.fromJson(Map<String, Object?> json) =>
      SeedSectionProductDto(
        sectionId: SeedJsonReader.string(json, 'section_id'),
        productCode: SeedJsonReader.string(json, 'product_code'),
        sortOrder: SeedJsonReader.integer(json, 'sort_order'),
        discountOverride: SeedJsonReader.nullableString(
          json,
          'discount_override',
        ),
      );
}

final class SeedBannerDto {
  const SeedBannerDto({
    required this.id,
    required this.title,
    required this.image,
    required this.sortOrder,
    required this.target,
  });

  final String id;
  final String title;
  final String image;
  final int sortOrder;
  final String? target;

  factory SeedBannerDto.fromJson(Map<String, Object?> json) => SeedBannerDto(
    id: SeedJsonReader.string(json, 'id'),
    title: SeedJsonReader.string(json, 'title'),
    image: SeedJsonReader.string(json, 'image'),
    sortOrder: SeedJsonReader.integer(json, 'sort_order'),
    target: SeedJsonReader.nullableString(json, 'target'),
  );
}

final class SeedShopDto {
  const SeedShopDto({
    required this.id,
    required this.name,
    required this.photo,
    required this.sortOrder,
  });

  final String id;
  final String name;
  final String photo;
  final int sortOrder;

  factory SeedShopDto.fromJson(Map<String, Object?> json) => SeedShopDto(
    id: SeedJsonReader.string(json, 'id'),
    name: SeedJsonReader.string(json, 'name'),
    photo: SeedJsonReader.string(json, 'photo'),
    sortOrder: SeedJsonReader.integer(json, 'sort_order'),
  );
}

final class SeedChallengeDto {
  const SeedChallengeDto({
    required this.id,
    required this.title,
    required this.goal,
    required this.pointsReward,
    required this.artworkType,
    required this.sortOrder,
  });

  final String id;
  final String title;
  final int goal;
  final int pointsReward;
  final String artworkType;
  final int sortOrder;

  factory SeedChallengeDto.fromJson(Map<String, Object?> json) =>
      SeedChallengeDto(
        id: SeedJsonReader.string(json, 'id'),
        title: SeedJsonReader.string(json, 'title'),
        goal: SeedJsonReader.integer(json, 'goal'),
        pointsReward: SeedJsonReader.integer(json, 'points_reward'),
        artworkType: SeedJsonReader.string(json, 'artwork_type'),
        sortOrder: SeedJsonReader.integer(json, 'sort_order'),
      );
}

final class SeedChallengeProgressDto {
  const SeedChallengeProgressDto({
    required this.memberPhone,
    required this.challengeId,
    required this.current,
  });

  final String memberPhone;
  final String challengeId;
  final int current;

  factory SeedChallengeProgressDto.fromJson(Map<String, Object?> json) =>
      SeedChallengeProgressDto(
        memberPhone: SeedJsonReader.string(json, 'member_phone'),
        challengeId: SeedJsonReader.string(json, 'challenge_id'),
        current: SeedJsonReader.integer(json, 'current'),
      );
}

final class SeedGiftDto {
  const SeedGiftDto({
    required this.id,
    required this.title,
    required this.pointsCost,
    required this.image,
    required this.sortOrder,
  });

  final String id;
  final String title;
  final int pointsCost;
  final String image;
  final int sortOrder;

  factory SeedGiftDto.fromJson(Map<String, Object?> json) => SeedGiftDto(
    id: SeedJsonReader.string(json, 'id'),
    title: SeedJsonReader.string(json, 'title'),
    pointsCost: SeedJsonReader.integer(json, 'points_cost'),
    image: SeedJsonReader.string(json, 'image'),
    sortOrder: SeedJsonReader.integer(json, 'sort_order'),
  );
}
