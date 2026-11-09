import 'package:flutter/material.dart';

import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/core/widgets/shimmer_box.dart';
import 'package:j_dounts_app/features/home/domain/home_data.dart';
import 'package:j_dounts_app/features/home/domain/home_repository.dart';
import 'package:j_dounts_app/features/home/presentation/home_content_widgets.dart';
import 'package:j_dounts_app/features/home/presentation/home_shell_widgets.dart';
import 'package:j_dounts_app/features/home/presentation/home_state.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    required this.repository,
    required this.memberId,
    this.onSettings,
    this.onProductTap,
    this.sectionStates = const {},
    super.key,
  });

  final HomeRepository repository;
  final int memberId;
  final VoidCallback? onSettings;
  final ValueChanged<String>? onProductTap;
  final Map<String, HomeSectionState> sectionStates;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Result<HomeData>>(
      stream: repository.watchHome(memberId),
      builder: (context, snapshot) {
        final result = snapshot.data;
        if (result == null) return const _HomeLoading();
        return result.fold(
          onFailure: (_) => _HomeFailure(onRetry: () async {}),
          onSuccess: (data) => _HomeContent(
            data: data,
            onSettings: onSettings,
            onProductTap: onProductTap,
            sectionStates: sectionStates,
          ),
        );
      },
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({
    required this.data,
    this.onSettings,
    this.onProductTap,
    this.sectionStates = const {},
  });

  final HomeData data;
  final VoidCallback? onSettings;
  final ValueChanged<String>? onProductTap;
  final Map<String, HomeSectionState> sectionStates;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.surfaceHome,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {},
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: HomeMemberHeader(
                  member: data.member,
                  onSettings: onSettings,
                ),
              ),
              SliverToBoxAdapter(
                child: HomeBannerCarousel(banners: data.banners),
              ),
              ...data.sections.map(
                (section) => SliverToBoxAdapter(
                  child: HomeProductSection(
                    section: section,
                    state: sectionStates[section.id],
                    onProductTap: onProductTap,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: HomeShopSection(
                  shops: data.shops,
                  title: localizations.nearbyShops(data.shops.length),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeLoading extends StatelessWidget {
  const _HomeLoading();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              ShimmerBox(height: 88, width: double.infinity),
              SizedBox(height: AppSpacing.md),
              ShimmerBox(height: 156, width: double.infinity),
              SizedBox(height: AppSpacing.md),
              ShimmerBox(height: 216, width: double.infinity),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeFailure extends StatelessWidget {
  const _HomeFailure({required this.onRetry});

  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: onRetry,
          child: Text(AppLocalizations.of(context).retry),
        ),
      ),
    );
  }
}
