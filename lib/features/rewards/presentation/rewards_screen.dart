import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/core/motion/motion.dart';
import 'package:j_dounts_app/core/motion/reduce_motion.dart';
import 'package:j_dounts_app/features/rewards/presentation/rewards_cards.dart';
import 'package:j_dounts_app/features/rewards/presentation/rewards_cubit.dart';
import 'package:j_dounts_app/features/rewards/presentation/rewards_entrance.dart';
import 'package:j_dounts_app/features/rewards/presentation/rewards_state.dart';
import 'package:j_dounts_app/features/rewards/presentation/rewards_summary.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entrance;
  late final RewardsEntrance _timeline;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _entrance = AnimationController(
      vsync: this,
      duration: Motion.pointsCountUp,
    );
    _timeline = RewardsEntrance(_entrance);
    final initial = context.read<RewardsCubit>().state;
    if (initial is RewardsLoaded) _configureEntrance(initial);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _startEntrance(context, context.read<RewardsCubit>().state);
    });
  }

  void _startEntrance(BuildContext context, RewardsState state) {
    if (_started || state is! RewardsLoaded) return;
    _started = true;
    _configureEntrance(state);
    if (ReduceMotion.isReduced(context)) {
      _entrance.value = 1;
    } else {
      _entrance.forward();
    }
  }

  void _configureEntrance(RewardsLoaded state) {
    final tiers = state.data.tiers;
    final isBronze = tiers.indexOf(state.tierProgress.currentTier) == 0;
    final tierCount = tiers.length - (isBronze ? 0 : 1);
    _timeline.configure(
      tierCount: tierCount,
      challengeCount: state.data.challenges.length,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduced = ReduceMotion.isReduced(context);
    if (_started && reduced && _entrance.isAnimating) _entrance.value = 1;
  }

  @override
  void dispose() {
    _entrance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.surfaceHome,
      body: SafeArea(
        child: BlocConsumer<RewardsCubit, RewardsState>(
          listener: _startEntrance,
          builder: (context, state) {
            final loaded = switch (state) {
              final RewardsLoaded value => value,
              RewardsFailure(:final previous) => previous,
              RewardsLoading() => null,
            };
            if (loaded == null && state is RewardsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  sliver: SliverList.list(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              l10n.rewardsTitle,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          if (loaded != null)
                            RewardsBadge(
                              count: loaded.completedChallengeCount,
                              entrance: _timeline.badge,
                            ),
                        ],
                      ),
                      if (state is RewardsFailure)
                        MaterialBanner(
                          content: Text(l10n.homeSectionError),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  context.read<RewardsCubit>().retry(),
                              child: Text(l10n.retry),
                            ),
                          ],
                        ),
                      if (loaded != null) ...[
                        const SizedBox(height: AppSpacing.lg),
                        RewardsSummary(state: loaded, entrance: _timeline),
                        const SizedBox(height: AppSpacing.lg),
                        _RewardsTabs(
                          showGifts: loaded.tab == RewardsTab.gifts,
                          onSelected: (value) =>
                              context.read<RewardsCubit>().selectTab(
                                value
                                    ? RewardsTab.gifts
                                    : RewardsTab.challenges,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        AnimatedSwitcher(
                          duration: ReduceMotion.resolve(
                            context,
                            Motion.tabListSwitch,
                          ),
                          child: loaded.tab == RewardsTab.gifts
                              ? Column(
                                  key: const ValueKey('gifts'),
                                  children: [
                                    if (loaded.data.gifts.isEmpty)
                                      Text(l10n.homeSectionEmpty),
                                    for (final gift in loaded.data.gifts)
                                      RewardsGiftCard(gift: gift),
                                  ],
                                )
                              : Column(
                                  key: const ValueKey('challenges'),
                                  children: [
                                    if (loaded.data.challenges.isEmpty)
                                      Text(l10n.homeSectionEmpty),
                                    for (
                                      var index = 0;
                                      index < loaded.data.challenges.length;
                                      index++
                                    )
                                      RewardsChallengeEntrance(
                                        challenge:
                                            loaded.data.challenges[index],
                                        index: index,
                                        entrance: _timeline,
                                      ),
                                  ],
                                ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _RewardsTabs extends StatelessWidget {
  const _RewardsTabs({required this.showGifts, required this.onSelected});

  final bool showGifts;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return LayoutBuilder(
      builder: (context, constraints) => DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.disabledFill,
          borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: AnimatedAlign(
                duration: ReduceMotion.resolve(context, Motion.tabIndicator),
                curve: Motion.standardCurve,
                alignment: showGifts
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: ReduceMotion.resolve(context, Motion.tabIndicator),
                  width: constraints.maxWidth * (showGifts ? 0.4 : 0.6),
                  decoration: BoxDecoration(
                    color: AppColors.actionBlue,
                    borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _Tab(
                    title: l10n.eatMoreEarnMore,
                    selected: !showGifts,
                    onTap: () => onSelected(false),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: _Tab(
                    title: l10n.gift,
                    selected: showGifts,
                    onTap: () => onSelected(true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    selected: selected,
    button: true,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.md,
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: selected ? AppColors.surfaceCard : AppColors.textPrimary,
          ),
        ),
      ),
    ),
  );
}
