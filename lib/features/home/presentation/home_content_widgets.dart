import 'dart:async';

import 'package:flutter/material.dart';

import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/core/images/app_cached_image.dart';
import 'package:j_dounts_app/core/motion/motion.dart';
import 'package:j_dounts_app/core/motion/reduce_motion.dart';
import 'package:j_dounts_app/core/utils/formatters.dart';
import 'package:j_dounts_app/features/home/domain/discount_resolver.dart';
import 'package:j_dounts_app/features/home/domain/home_data.dart';
import 'package:j_dounts_app/features/home/presentation/home_state.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class HomeBannerCarousel extends StatefulWidget {
  const HomeBannerCarousel({required this.banners, super.key});

  final List<HomeBanner> banners;

  @override
  State<HomeBannerCarousel> createState() => _HomeBannerCarouselState();
}

class _HomeBannerCarouselState extends State<HomeBannerCarousel> {
  late final PageController _controller;
  Timer? _timer;
  bool _motionConfigured = false;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.88);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_motionConfigured) {
      _configureAutoPlay();
      return;
    }
    _motionConfigured = true;
    _configureAutoPlay();
  }

  void _configureAutoPlay() {
    _timer?.cancel();
    if (ReduceMotion.isReduced(context) || widget.banners.length < 2) return;
    _timer = Timer.periodic(Motion.carouselInterval, (_) {
      if (!_controller.hasClients) return;
      final nextPage = (_controller.page?.round() ?? 0) + 1;
      _controller.animateToPage(
        nextPage % widget.banners.length,
        duration: Motion.standard,
        curve: Motion.standardCurve,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 156,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.banners.length,
        itemBuilder: (context, index) {
          final banner = widget.banners[index];
          return Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.md,
              top: AppSpacing.md,
              bottom: AppSpacing.sm,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppCachedImage(source: banner.image),
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.all(AppSpacing.md),
                    color: AppColors.scrim,
                    child: Text(
                      banner.title,
                      style: Theme.of(context).textTheme.titleLarge
                          ?.copyWith(color: AppColors.surfaceCard),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class HomeProductSection extends StatelessWidget {
  const HomeProductSection({
    required this.section,
    this.state,
    this.onProductTap,
    super.key,
  });

  final HomeSection section;
  final HomeSectionState? state;
  final ValueChanged<String>? onProductTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        0,
        AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  section.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              if (section.seeAll)
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.chevron_right),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.ringBlueLight,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (state is HomeSectionError)
            _SectionMessage(
              message: AppLocalizations.of(context).homeSectionError,
            )
          else if (section.products.isEmpty)
            _SectionMessage(
              message: AppLocalizations.of(context).homeSectionEmpty,
            )
          else
            SizedBox(
              height: section.layoutStyle == 'wide_card' ? 208 : 232,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: section.products.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(width: AppSpacing.sm),
                itemBuilder: (context, index) => _HomeProductCard(
                  product: section.products[index],
                  onTap: onProductTap,
                  wide: section.layoutStyle == 'wide_card',
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SectionMessage extends StatelessWidget {
  const _SectionMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpacing.md),
    child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
  );
}

class _HomeProductCard extends StatelessWidget {
  const _HomeProductCard({
    required this.product,
    this.onTap,
    this.wide = false,
  });

  final HomeProduct product;
  final ValueChanged<String>? onTap;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final label = resolveDiscountLabel(
      productDiscount: product.discountLabel,
      sectionOverride: product.discountOverride,
    );
    return SizedBox(
      width: wide ? 164 : 152,
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        child: InkWell(
          onTap: onTap == null ? null : () => onTap!(product.code),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Hero(
                  tag: 'product:${product.code}',
                  child: AppCachedImage(source: product.image),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (!wide)
                      Text(
                        formatMmk(product.priceMmk),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.actionBlue,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    if (label != null)
                      Text(
                        label,
                        style: const TextStyle(color: AppColors.badgeOrange),
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
