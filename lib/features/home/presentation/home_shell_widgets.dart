import 'package:flutter/material.dart';

import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/core/images/app_cached_image.dart';
import 'package:j_dounts_app/core/member/domain/member.dart';
import 'package:j_dounts_app/core/utils/formatters.dart';
import 'package:j_dounts_app/features/home/domain/home_data.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class HomeMemberHeader extends StatelessWidget {
  const HomeMemberHeader({required this.member, this.onSettings, super.key});

  final Member? member;
  final VoidCallback? onSettings;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Container(
      color: AppColors.surfaceHome,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: AppSpacing.avatarSize / 2,
                backgroundColor: AppColors.surfaceCard,
                backgroundImage: member?.photo == null
                    ? const AssetImage('assets/images/members/demo_avatar.jpg')
                    : null,
                child: member?.photo == null
                    ? null
                    : ClipOval(
                        child: AppCachedImage(
                          source: member!.photo!,
                          width: AppSpacing.avatarSize,
                          height: AppSpacing.avatarSize,
                        ),
                      ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member?.fullName ?? localizations.homeTab,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      formatMmk(member?.totalPoints ?? 0),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onSettings,
                icon: Badge(
                  isLabelVisible: (member?.notificationCount ?? 0) > 0,
                  label: Text('${member?.notificationCount ?? 0}'),
                  child: const Icon(
                    Icons.notifications_none_outlined,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.surfaceCard,
              borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.stars_outlined,
                  size: AppSpacing.md,
                  color: AppColors.brandPink,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    formatMmk(member?.totalPoints ?? 0),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeShopSection extends StatelessWidget {
  const HomeShopSection({required this.shops, required this.title, super.key});

  final List<HomeShop> shops;
  final String title;

  @override
  Widget build(BuildContext context) {
    if (shops.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.ringBlueLight,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(AppLocalizations.of(context).exploreNow),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              for (final shop in shops)
                Card(
                  margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 2.2,
                        child: AppCachedImage(source: shop.photo),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                shop.name,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context).orderOnline,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.brandPink),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
