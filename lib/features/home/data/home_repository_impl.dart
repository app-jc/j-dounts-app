import 'package:drift/drift.dart';

import 'package:j_dounts_app/core/database/app_database.dart';
import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/core/error/stream_result.dart';
import 'package:j_dounts_app/core/member/domain/member_repository.dart';
import 'package:j_dounts_app/core/member/domain/tier_calculator.dart';
import 'package:j_dounts_app/core/utils/combine_latest.dart';
import 'package:j_dounts_app/features/home/data/home_mapper.dart';
import 'package:j_dounts_app/features/home/domain/home_data.dart';
import 'package:j_dounts_app/features/home/domain/home_repository.dart';

final class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._database, this._members);

  final AppDatabase _database;
  final MemberRepository _members;

  @override
  Stream<Result<HomeData>> watchHome(int memberId) {
    final memberStream = _members.watchById(memberId);
    final bannerStream = toResultStream(
      (_database.select(_database.banners)
            ..orderBy([(row) => OrderingTerm.asc(row.sortOrder)]))
          .watch()
          .map((rows) => rows.map(HomeMapper.banner).toList()),
    );
    final sectionQuery =
        _database.select(_database.sections).join([
          leftOuterJoin(
            _database.sectionProducts,
            _database.sectionProducts.sectionId.equalsExp(
              _database.sections.id,
            ),
          ),
          leftOuterJoin(
            _database.products,
            _database.products.code.equalsExp(
              _database.sectionProducts.productCode,
            ),
          ),
        ])..orderBy([
          OrderingTerm.asc(_database.sections.sortOrder),
          OrderingTerm.asc(_database.sectionProducts.sortOrder),
        ]);
    final sectionStream = toResultStream(
      sectionQuery.watch().map((rows) => HomeMapper.sections(_database, rows)),
    );
    final shopStream = toResultStream(
      (_database.select(_database.shops)
            ..orderBy([(row) => OrderingTerm.asc(row.sortOrder)]))
          .watch()
          .map((rows) => rows.map(HomeMapper.shop).toList()),
    );
    final tiersStream = toResultStream(
      (_database.select(
        _database.tiers,
      )..orderBy([(row) => OrderingTerm.asc(row.sortOrder)])).watch().map(
        (rows) => rows
            .map(
              (row) => TierDefinition(name: row.name, threshold: row.threshold),
            )
            .toList(),
      ),
    );

    final memberAndBanners = combineLatest2(
      memberStream,
      bannerStream,
      (member, banners) => member.combineWith(
        banners,
        (memberValue, bannerValues) =>
            (member: memberValue, banners: bannerValues),
      ),
    );
    final sectionsAndShops = combineLatest2(
      sectionStream,
      shopStream,
      (sections, shops) => sections.combineWith(
        shops,
        (sectionValues, shopValues) =>
            (sections: sectionValues, shops: shopValues),
      ),
    );

    final homeStream = combineLatest2(
      memberAndBanners,
      sectionsAndShops,
      (first, second) => first.combineWith(
        second,
        (memberContent, catalogContent) => HomeData(
          member: memberContent.member,
          banners: memberContent.banners,
          sections: catalogContent.sections,
          shops: catalogContent.shops,
        ),
      ),
    );
    return combineLatest2(
      homeStream,
      tiersStream,
      (home, tiers) => home.combineWith(
        tiers,
        (data, values) => HomeData(
          member: data.member,
          banners: data.banners,
          sections: data.sections,
          shops: data.shops,
          tiers: values,
        ),
      ),
    );
  }
}
