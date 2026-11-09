import 'package:flutter/material.dart';

import 'package:j_dounts_app/app/router/app_routes.dart';
import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/core/motion/motion.dart';
import 'package:j_dounts_app/core/motion/reduce_motion.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class SlidingNavBar extends StatelessWidget {
  const SlidingNavBar({
    required this.currentIndex,
    required this.onDestinationSelected,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final destinations = [
      _NavDestinationData(
        icon: Icons.home_outlined,
        label: localizations.homeTab,
        route: AppRoutes.home,
      ),
      _NavDestinationData(
        icon: Icons.workspace_premium_outlined,
        label: localizations.rewardTab,
        route: AppRoutes.rewards,
      ),
      _NavDestinationData(
        icon: Icons.circle_outlined,
        label: localizations.menuTab,
        route: AppRoutes.menu,
      ),
      _NavDestinationData(
        icon: Icons.account_balance_wallet_outlined,
        label: localizations.walletTab,
        route: AppRoutes.wallet,
      ),
      _NavDestinationData(
        icon: Icons.settings_outlined,
        label: localizations.settings,
        route: AppRoutes.settings,
      ),
    ];
    final safeIndex = currentIndex < 0
        ? 0
        : currentIndex >= destinations.length
        ? destinations.length - 1
        : currentIndex;
    final reduceMotion = ReduceMotion.isReduced(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.actionBlue,
        border: Border.all(color: AppColors.surfaceCard),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSpacing.navBarTopRadius),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.scrim,
            blurRadius: AppSpacing.shadowBlurRadius,
            offset: Offset(0, -AppSpacing.shadowOffsetY),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: AppSpacing.navBarHeight,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = constraints.maxWidth / destinations.length;
              final pillWidth = AppSpacing.primaryButtonHeight * 2;
              final pillLeft =
                  itemWidth * safeIndex + (itemWidth - pillWidth) / 2;
              return Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    children: [
                      for (var index = 0; index < destinations.length; index++)
                        Expanded(
                          child: _NavItem(
                            data: destinations[index],
                            selected: index == safeIndex,
                            onTap: () => onDestinationSelected(index),
                          ),
                        ),
                    ],
                  ),
                  AnimatedPositioned(
                    duration: ReduceMotion.resolve(
                      context,
                      Motion.navPillSlide,
                    ),
                    curve: Motion.emphasizedCurve,
                    left: pillLeft,
                    width: pillWidth,
                    top: AppSpacing.sm,
                    bottom: AppSpacing.sm,
                    child: _ActivePill(
                      data: destinations[safeIndex],
                      reduceMotion: reduceMotion,
                      onTap: () => onDestinationSelected(safeIndex),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NavDestinationData {
  const _NavDestinationData({
    required this.icon,
    required this.label,
    required this.route,
  });

  final IconData icon;
  final String label;
  final String route;
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.data,
    required this.selected,
    required this.onTap,
  });

  final _NavDestinationData data;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: data.label,
      hint: data.route,
      child: InkResponse(
        onTap: onTap,
        containedInkWell: true,
        radius: AppSpacing.primaryButtonHeight / 2,
        child: SizedBox(
          height: AppSpacing.primaryButtonHeight,
          child: Center(
            child: selected
                ? const SizedBox(
                    width: AppSpacing.md + AppSpacing.sm,
                    height: AppSpacing.md + AppSpacing.sm,
                  )
                : Icon(
                    data.icon,
                    size: AppSpacing.md + AppSpacing.sm,
                    color: AppColors.surfaceCard,
                  ),
          ),
        ),
      ),
    );
  }
}

class _ActivePill extends StatelessWidget {
  const _ActivePill({
    required this.data,
    required this.reduceMotion,
    required this.onTap,
  });

  final _NavDestinationData data;
  final bool reduceMotion;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: true,
      label: data.label,
      hint: data.route,
      child: InkResponse(
        onTap: onTap,
        containedInkWell: true,
        radius: AppSpacing.primaryButtonHeight / 2,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.brandPink,
            border: Border.all(color: AppColors.surfaceCard),
            borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    data.icon,
                    size: AppSpacing.md + AppSpacing.sm,
                    color: AppColors.surfaceCard,
                  ),
                  AnimatedSwitcher(
                    duration: reduceMotion
                        ? Duration.zero
                        : Motion.navPillSlide,
                    child: Padding(
                      key: ValueKey(data.label),
                      padding: const EdgeInsets.only(left: AppSpacing.xs),
                      child: Text(
                        data.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.surfaceCard,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
