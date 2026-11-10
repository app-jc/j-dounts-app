import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/core/widgets/shimmer_box.dart';
import 'package:j_dounts_app/features/home/domain/home_data.dart';
import 'package:j_dounts_app/features/home/presentation/home_bloc.dart';
import 'package:j_dounts_app/features/home/presentation/home_content_widgets.dart';
import 'package:j_dounts_app/features/home/presentation/home_shell_widgets.dart';
import 'package:j_dounts_app/features/home/presentation/home_state.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

/// The main screen for the home feature, displaying banners, product sections, and nearby shops.
class HomeScreen extends StatelessWidget {
  const HomeScreen({this.onSettings, this.onProductTap, super.key});

  final VoidCallback? onSettings;
  final ValueChanged<String>? onProductTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final previous = switch (state) {
          HomeLoading(:final previous) => previous,
          HomeFailure(:final previous) => previous,
          _ => null,
        };
        if (state is HomeLoaded || previous != null) {
          final data = state is HomeLoaded ? state.data : previous!;
          return _HomeContent(
            data: data,
            onSettings: onSettings,
            onProductTap: onProductTap,
            sectionStates: state is HomeLoaded ? state.sectionStates : const {},
            showError: state is HomeFailure,
          );
        }
        if (state is HomeFailure) {
          return _HomeFailure(
            onRetry: () => context.read<HomeBloc>().add(const HomeStarted()),
          );
        }
        return const _HomeLoading();
      },
    );
  }
}

/// A widget that displays the content of the home screen, including banners, product sections, and nearby shops.
class _HomeContent extends StatelessWidget {
  const _HomeContent({
    required this.data,
    this.onSettings,
    this.onProductTap,
    this.sectionStates = const {},
    this.showError = false,
  });

  final HomeData data;
  final VoidCallback? onSettings;
  final ValueChanged<String>? onProductTap;
  final Map<String, HomeSectionState> sectionStates;
  final bool showError;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.surfaceHome,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<HomeBloc>().add(const HomeRefreshRequested());
          },
          child: CustomScrollView(
            slivers: [
              if (showError)
                SliverToBoxAdapter(
                  child: MaterialBanner(
                    content: Text(localizations.homeSectionError),
                    actions: [
                      TextButton(
                        onPressed: () =>
                            context.read<HomeBloc>().add(const HomeStarted()),
                        child: Text(localizations.retry),
                      ),
                    ],
                  ),
                ),
              SliverToBoxAdapter(
                child: HomeMemberHeader(
                  member: data.member,
                  progress: data.tierProgress,
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

/// A widget that displays a loading indicator while the home screen is loading.
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

/// A widget that displays an error message and a retry button when the home screen fails to load.
class _HomeFailure extends StatelessWidget {
  const _HomeFailure({required this.onRetry});

  final VoidCallback onRetry;

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
