import 'package:drift/drift.dart';

import 'package:j_dounts_app/core/database/app_database.dart';
import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/core/error/stream_result.dart';
import 'package:j_dounts_app/core/member/domain/member_repository.dart';
import 'package:j_dounts_app/core/utils/combine_latest.dart';
import 'package:j_dounts_app/features/rewards/data/rewards_mapper.dart';
import 'package:j_dounts_app/features/rewards/domain/rewards_data.dart';
import 'package:j_dounts_app/features/rewards/domain/rewards_repository.dart';

final class RewardsRepositoryImpl implements RewardsRepository {
  RewardsRepositoryImpl(this._database, this._members);

  final AppDatabase _database;
  final MemberRepository _members;

  @override
  Stream<Result<RewardsData>> watchRewards(int memberId) {
    final memberStream = _members.watchById(memberId);
    final tiersStream = _watchRows<Tier>(_database.select(_database.tiers));
    final challengesStream = _watchRows<Challenge>(
      _database.select(_database.challenges),
    );
    final progressQuery = _database.select(_database.memberChallengeProgress)
      ..where((row) => row.memberId.equals(memberId));
    final progressStream = _watchRows<MemberChallengeProgressData>(
      progressQuery,
    );
    final giftsStream = _watchRows<Gift>(_database.select(_database.gifts));

    final memberAndTiers = combineLatest2(
      memberStream,
      tiersStream,
      (member, tiers) => member.combineWith(
        tiers,
        (memberValue, tierValues) => (member: memberValue, tiers: tierValues),
      ),
    );
    final challengesAndProgress = combineLatest2(
      challengesStream,
      progressStream,
      (challenges, progress) => challenges.combineWith(
        progress,
        (challengeValues, progressValues) =>
            (challenges: challengeValues, progress: progressValues),
      ),
    );
    final memberCatalog = combineLatest2(
      memberAndTiers,
      challengesAndProgress,
      (member, catalog) => member.combineWith(
        catalog,
        (memberValues, catalogValues) =>
            (member: memberValues, catalog: catalogValues),
      ),
    );

    return combineLatest2(
      memberCatalog,
      giftsStream,
      (memberAndCatalog, gifts) => memberAndCatalog.combineWith(
        gifts,
        (values, giftValues) => RewardsMapper.map(
          member: values.member.member,
          tiers: values.member.tiers,
          challenges: values.catalog.challenges,
          progress: values.catalog.progress,
          gifts: giftValues,
        ),
      ),
    );
  }

  Stream<Result<List<T>>> _watchRows<T>(Selectable<T> query) =>
      toResultStream(query.watch());
}
