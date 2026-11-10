import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:j_dounts_app/app/di/injection.dart';
import 'package:j_dounts_app/app/shell/placeholder_screen.dart';
import 'package:j_dounts_app/features/rewards/domain/rewards_repository.dart';
import 'package:j_dounts_app/features/rewards/presentation/rewards_cubit.dart';
import 'package:j_dounts_app/features/rewards/presentation/rewards_screen.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

Widget rewardsRoute(BuildContext context, int memberId) {
  if (!getIt.isRegistered<RewardsRepository>()) {
    return PlaceholderScreen(title: AppLocalizations.of(context).rewards);
  }
  return BlocProvider(
    create: (_) => getIt<RewardsCubit>(param1: memberId),
    child: const RewardsScreen(),
  );
}
