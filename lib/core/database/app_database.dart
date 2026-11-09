import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'package:j_dounts_app/core/database/tables/banners.dart';
import 'package:j_dounts_app/core/database/tables/challenges.dart';
import 'package:j_dounts_app/core/database/tables/gifts.dart';
import 'package:j_dounts_app/core/database/tables/members.dart';
import 'package:j_dounts_app/core/database/tables/member_challenge_progress.dart';
import 'package:j_dounts_app/core/database/tables/products.dart';
import 'package:j_dounts_app/core/database/tables/section_products.dart';
import 'package:j_dounts_app/core/database/tables/sections.dart';
import 'package:j_dounts_app/core/database/tables/seed_state.dart';
import 'package:j_dounts_app/core/database/tables/shops.dart';
import 'package:j_dounts_app/core/database/tables/tiers.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Members,
    Tiers,
    Products,
    Sections,
    SectionProducts,
    Banners,
    Shops,
    Challenges,
    MemberChallengeProgress,
    Gifts,
    SeedStates,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'j_dounts_app'));

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async => migrator.createAll(),
    beforeOpen: (_) async => customStatement('PRAGMA foreign_keys = ON'),
  );

  Future<bool> get hasSeeded async {
    final state = await (select(
      seedStates,
    )..where((row) => row.id.equals(1))).getSingleOrNull();
    return state?.isSeeded ?? false;
  }

  Future<void> markSeeded() => into(seedStates).insertOnConflictUpdate(
    SeedStatesCompanion.insert(id: const Value(1), isSeeded: const Value(true)),
  );
}
