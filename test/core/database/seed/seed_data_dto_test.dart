import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/core/database/seed/seed_data_dto.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('parses the approved bundled seed data', () async {
    final source = await rootBundle.loadString('assets/seed/seed_data.json');
    final data = SeedDataDto.decode(source);

    expect(data.member.phone, '+95912345678');
    expect(data.member.dateOfBirth, DateTime(2010, 6, 6));
    expect(data.tiers.map((tier) => tier.name), [
      'Bronze',
      'Silver',
      'Gold',
      'Platinum',
    ]);
    expect(data.products, hasLength(7));
    expect(data.sections, hasLength(3));
    expect(data.sections.last.seeAll, isFalse);
    expect(data.sectionProducts, hasLength(9));
    expect(data.banners, hasLength(2));
    expect(data.shops, hasLength(4));
    expect(data.challenges, hasLength(3));
    expect(data.challengeProgress.map((row) => row.current), [4, 1, 9]);
    expect(data.gifts, hasLength(2));
  });

  test('rejects an invalid seed date', () async {
    final source = await rootBundle.loadString('assets/seed/seed_data.json');

    expect(
      () => SeedDataDto.decode(source.replaceFirst('2010-06-06', '2010-06-31')),
      throwsA(isA<FormatException>()),
    );
  });
}
