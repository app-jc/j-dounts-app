import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/core/member/domain/member.dart';
import 'package:j_dounts_app/core/widgets/press_scale.dart';
import 'package:j_dounts_app/features/home/presentation/home_shell_widgets.dart';
import 'package:j_dounts_app/features/rewards/domain/rewards_data.dart';
import 'package:j_dounts_app/features/rewards/domain/rewards_repository.dart';
import 'package:j_dounts_app/features/rewards/domain/tier_calculator.dart';
import 'package:j_dounts_app/features/rewards/presentation/rewards_cubit.dart';
import 'package:j_dounts_app/features/rewards/presentation/rewards_screen.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

const _tiers = [
  TierDefinition(name: 'Bronze', threshold: 0),
  TierDefinition(name: 'Silver', threshold: 679000),
  TierDefinition(name: 'Gold', threshold: 680500),
  TierDefinition(name: 'Platinum', threshold: 700000),
];

Member _member(int points) => Member(
  id: 1,
  phone: '+95912345678',
  firstName: 'Demo',
  lastName: null,
  dateOfBirth: DateTime(1990),
  photo: null,
  totalPoints: points,
  notificationCount: 0,
);

RewardChallenge _challenge(int current) => RewardChallenge(
  id: 'one',
  title: 'Donut challenge',
  goal: 4,
  pointsReward: 100,
  artworkType: 'donut',
  sortOrder: 0,
  current: current,
);

RewardsData _data(int points, int current) => RewardsData(
  member: _member(points),
  tiers: _tiers,
  challenges: [_challenge(current)],
  gifts: const [
    RewardGift(
      id: 'gift',
      title: 'Gift box',
      pointsCost: 25000,
      image: 'asset:assets/images/placeholders/image_fallback.png',
      sortOrder: 0,
    ),
  ],
);

void main() {
  testWidgets('zero-point ladder and Home share points-to-next text', (
    tester,
  ) async {
    final controller = StreamController<Result<RewardsData>>();
    final cubit = RewardsCubit(_Repository(controller.stream), memberId: 1);
    addTearDown(() async {
      await cubit.close();
      await controller.close();
    });

    await tester.pumpWidget(_app(cubit));
    controller.add(Success(_data(0, 0)));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Bronze'), findsOneWidget);
    expect(find.text('Silver'), findsOneWidget);
    expect(find.text('Gold'), findsOneWidget);
    expect(find.text('Platinum'), findsOneWidget);
    expect(find.text('679,000 pts Remaining to become Silver'), findsOneWidget);

    final progress = TierCalculator(_tiers).calculate(0);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: HomeMemberHeader(member: _member(0), progress: progress),
        ),
      ),
    );
    expect(find.text('679,000 pts Remaining to become Silver'), findsOneWidget);
  });

  testWidgets('Earn enables at target, clamps display and tabs switch', (
    tester,
  ) async {
    final controller = StreamController<Result<RewardsData>>();
    final cubit = RewardsCubit(_Repository(controller.stream), memberId: 1);
    addTearDown(() async {
      await cubit.close();
      await controller.close();
    });
    await tester.pumpWidget(_app(cubit));
    controller.add(Success(_data(680000, 3)));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('3/4'), findsOneWidget);
    expect(
      tester.widget<PressScale>(find.byType(PressScale)).onPressed,
      isNull,
    );

    controller.add(Success(_data(680000, 4)));
    await tester.pump();
    await tester.pump();
    expect(find.text('4/4'), findsOneWidget);
    expect(
      tester.widget<PressScale>(find.byType(PressScale)).onPressed,
      isNotNull,
    );

    controller.add(Success(_data(680000, 8)));
    await tester.pump();
    await tester.pump();
    expect(find.text('4/4'), findsOneWidget);
    await tester.tap(find.text('Gift'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Gift box'), findsOneWidget);
    expect(find.text('Donut challenge'), findsNothing);
  });

  testWidgets('top-tier ladder is readable at 1.3 text scale', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 700));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final controller = StreamController<Result<RewardsData>>();
    final cubit = RewardsCubit(_Repository(controller.stream), memberId: 1);
    addTearDown(() async {
      await cubit.close();
      await controller.close();
    });
    await tester.pumpWidget(_app(cubit, scale: 1.3));
    controller.add(Success(_data(700000, 4)));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Bronze'), findsNothing);
    expect(find.text('Silver'), findsOneWidget);
    expect(find.text('Gold'), findsOneWidget);
    expect(find.text('Platinum'), findsOneWidget);
    expect(find.text("You're here now"), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

Widget _app(RewardsCubit cubit, {double scale = 1}) => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  builder: (context, child) => MediaQuery(
    data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(scale)),
    child: child!,
  ),
  home: BlocProvider.value(value: cubit, child: const RewardsScreen()),
);

final class _Repository implements RewardsRepository {
  _Repository(this.stream);
  final Stream<Result<RewardsData>> stream;

  @override
  Stream<Result<RewardsData>> watchRewards(int memberId) => stream;
}
