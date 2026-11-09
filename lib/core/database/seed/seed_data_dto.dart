import 'dart:convert';

import 'package:j_dounts_app/core/database/seed/seed_catalog_dtos.dart';
import 'package:j_dounts_app/core/database/seed/seed_json_reader.dart';

final class SeedDataDto {
  const SeedDataDto({
    required this.member,
    required this.tiers,
    required this.products,
    required this.sections,
    required this.sectionProducts,
    required this.banners,
    required this.shops,
    required this.challenges,
    required this.challengeProgress,
    required this.gifts,
  });

  final SeedMemberDto member;
  final List<SeedTierDto> tiers;
  final List<SeedProductDto> products;
  final List<SeedSectionDto> sections;
  final List<SeedSectionProductDto> sectionProducts;
  final List<SeedBannerDto> banners;
  final List<SeedShopDto> shops;
  final List<SeedChallengeDto> challenges;
  final List<SeedChallengeProgressDto> challengeProgress;
  final List<SeedGiftDto> gifts;

  factory SeedDataDto.decode(String source) {
    final Object? decoded = jsonDecode(source);
    if (decoded is! Map<String, Object?>) {
      throw const FormatException('Seed data must be a JSON object.');
    }
    return SeedDataDto.fromJson(decoded);
  }

  factory SeedDataDto.fromJson(Map<String, Object?> json) => SeedDataDto(
    member: SeedMemberDto.fromJson(SeedJsonReader.object(json, 'member')),
    tiers: SeedJsonReader.list(json, 'tiers', SeedTierDto.fromJson),
    products: SeedJsonReader.list(json, 'products', SeedProductDto.fromJson),
    sections: SeedJsonReader.list(json, 'sections', SeedSectionDto.fromJson),
    sectionProducts: SeedJsonReader.list(
      json,
      'section_products',
      SeedSectionProductDto.fromJson,
    ),
    banners: SeedJsonReader.list(json, 'banners', SeedBannerDto.fromJson),
    shops: SeedJsonReader.list(json, 'shops', SeedShopDto.fromJson),
    challenges: SeedJsonReader.list(
      json,
      'challenges',
      SeedChallengeDto.fromJson,
    ),
    challengeProgress: SeedJsonReader.list(
      json,
      'challenge_progress',
      SeedChallengeProgressDto.fromJson,
    ),
    gifts: SeedJsonReader.list(json, 'gifts', SeedGiftDto.fromJson),
  );
}

final class SeedMemberDto {
  const SeedMemberDto({
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.photo,
    required this.totalPoints,
    required this.notificationCount,
  });

  final String phone;
  final String firstName;
  final String? lastName;
  final DateTime dateOfBirth;
  final String? photo;
  final int totalPoints;
  final int notificationCount;

  factory SeedMemberDto.fromJson(Map<String, Object?> json) => SeedMemberDto(
    phone: SeedJsonReader.string(json, 'phone'),
    firstName: SeedJsonReader.string(json, 'first_name'),
    lastName: SeedJsonReader.nullableString(json, 'last_name'),
    dateOfBirth: SeedJsonReader.date(json, 'date_of_birth'),
    photo: SeedJsonReader.nullableString(json, 'photo'),
    totalPoints: SeedJsonReader.integer(json, 'total_points'),
    notificationCount: SeedJsonReader.integer(json, 'notification_count'),
  );
}
