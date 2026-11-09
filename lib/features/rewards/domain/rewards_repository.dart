import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/features/rewards/domain/rewards_data.dart';

abstract interface class RewardsRepository {
  Stream<Result<RewardsData>> watchRewards(int memberId);
}
