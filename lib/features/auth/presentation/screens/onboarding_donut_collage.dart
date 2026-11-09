import 'package:flutter/material.dart';

import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/core/images/app_cached_image.dart';
import 'package:j_dounts_app/core/widgets/staggered_entrance.dart';

class OnboardingDonutCollage extends StatelessWidget {
  const OnboardingDonutCollage({required this.entrances, super.key});

  static const _sources = [
    'asset:assets/images/products/assorted_donut_box.jpg',
    'asset:assets/images/products/purple_glazed_donut.jpg',
    'asset:assets/images/products/strawberry_chocolate_donut.jpg',
    'asset:assets/images/products/seasonal_mixed_box.jpg',
  ];
  static const _sizes = [0.78, 0.44, 0.40, 0.32];
  static const _leftPositions = [0.24, 0.04, 0.62, 0.65];
  static const _topPositions = [0.02, 0.42, 0.30, 0.04];

  final List<Animation<double>> entrances;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => ExcludeSemantics(
      child: Stack(
        children: List.generate(_sources.length, (index) {
          final size = constraints.maxHeight * _sizes[index];
          return Positioned(
            left: constraints.maxWidth * _leftPositions[index],
            top: constraints.maxHeight * _topPositions[index],
            width: size,
            height: size,
            child: StaggeredEntrance(
              entrance: entrances[index],
              child: _DonutImage(source: _sources[index]),
            ),
          );
        }),
      ),
    ),
  );
}

class _DonutImage extends StatelessWidget {
  const _DonutImage({required this.source});

  final String source;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpacing.xs),
    decoration: const BoxDecoration(
      color: AppColors.surfaceCard,
      shape: BoxShape.circle,
    ),
    child: ClipOval(child: AppCachedImage(source: source)),
  );
}
