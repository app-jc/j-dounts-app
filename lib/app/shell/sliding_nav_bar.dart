import 'package:flutter/material.dart';

import 'package:j_dounts_app/app/router/app_routes.dart';
import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/core/motion/motion.dart';
import 'package:j_dounts_app/core/motion/reduce_motion.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

/// A widget that displays a sliding navigation bar with animated transitions between destinations.
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
        icon: Icons.menu_open,
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
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.actionBlue,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.navBarTopRadius),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: AppSpacing.navBarHeight,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = constraints.maxWidth / destinations.length;
              final selectedWidth = itemWidth * 1.8;
              final unselectedWidth =
                  (constraints.maxWidth - selectedWidth) /
                  (destinations.length - 1);
              return Row(
                children: [
                  for (var index = 0; index < destinations.length; index++)
                    AnimatedContainer(
                      duration: ReduceMotion.resolve(
                        context,
                        Motion.navPillSlide,
                      ),
                      curve: Motion.emphasizedCurve,
                      width: index == safeIndex
                          ? selectedWidth
                          : unselectedWidth,
                      child: _NavItem(
                        data: destinations[index],
                        selected: index == safeIndex,
                        onTap: () => onDestinationSelected(index),
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

/// A class that represents the data for a navigation destination in the sliding navigation bar.
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
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: selected ? AppColors.brandPink : null,
                border: selected
                    ? Border.all(color: AppColors.surfaceCard)
                    : null,
                borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.md,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      data.icon,
                      size: AppSpacing.md + AppSpacing.sm,
                      color: AppColors.surfaceCard,
                    ),
                    if (selected) ...[
                      const SizedBox(width: AppSpacing.xs),
                      Flexible(
                        child: Text(
                          data.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: AppColors.surfaceCard,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
