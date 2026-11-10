import 'package:j_dounts_app/core/member/domain/tier_calculator.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

String pointsToNextText(
  AppLocalizations localizations,
  TierProgress progress,
) => switch (progress) {
  HasNextTier(:final remaining, :final nextTier) =>
    localizations.pointsRemainingToTier(remaining, nextTier.name),
  TopTier(:final currentTier) => localizations.tierMember(currentTier.name),
};
