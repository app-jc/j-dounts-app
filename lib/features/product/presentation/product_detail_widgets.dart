import 'package:flutter/material.dart';

import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/app/theme/app_typography.dart';
import 'package:j_dounts_app/core/images/app_cached_image.dart';
import 'package:j_dounts_app/core/motion/motion.dart';
import 'package:j_dounts_app/core/motion/reduce_motion.dart';
import 'package:j_dounts_app/core/utils/formatters.dart';
import 'package:j_dounts_app/features/product/domain/product.dart';
import 'package:j_dounts_app/features/product/domain/product_quantity.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class ProductHeroCard extends StatelessWidget {
  const ProductHeroCard({
    required this.product,
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
    super.key,
  });

  static const double imageHeight = 220;

  final Product product;
  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.stepperButtonSize),
          child: _ProductCardBody(product: product),
        ),
        ProductQuantityStepper(
          quantity: quantity,
          onDecrease: onDecrease,
          onIncrease: onIncrease,
        ),
      ],
    );
  }
}

class _ProductCardBody extends StatelessWidget {
  const _ProductCardBody({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Text(
                  product.code,
                  style: AppTypography.legal.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  product.name,
                  textAlign: TextAlign.center,
                  style: AppTypography.sectionTitle,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  formatMmk(product.priceMmk),
                  style: AppTypography.numberLarge,
                ),
                const SizedBox(height: AppSpacing.md),
                Hero(
                  tag: 'product:${product.code}',
                  child: AppCachedImage(
                    source: product.image,
                    width: double.infinity,
                    height: ProductHeroCard.imageHeight,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            if (product.isNew)
              Align(
                alignment: Alignment.topRight,
                child: _NewBadge(label: localizations.newBadge),
              ),
          ],
        ),
      ),
    );
  }
}

class _NewBadge extends StatelessWidget {
  const _NewBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.badgeOrange,
        borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Text(
          label,
          style: AppTypography.button.copyWith(color: AppColors.surfaceCard),
        ),
      ),
    );
  }
}

class ProductQuantityStepper extends StatelessWidget {
  const ProductQuantityStepper({
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
    super.key,
  });

  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(
              alpha: AppSpacing.shadowOpacity,
            ),
            offset: const Offset(0, AppSpacing.shadowOffsetY),
            blurRadius: AppSpacing.shadowBlurRadius,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _StepperButton(
              icon: Icons.remove,
              onPressed: quantity <= ProductQuantity.min ? null : onDecrease,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: AnimatedSwitcher(
                duration: ReduceMotion.resolve(context, Motion.quantityChange),
                child: Text(
                  '$quantity',
                  key: ValueKey(quantity),
                  style: AppTypography.numberLarge,
                ),
              ),
            ),
            _StepperButton(
              icon: Icons.add,
              onPressed: quantity >= ProductQuantity.max ? null : onIncrease,
            ),
          ],
        ),
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: AppSpacing.stepperButtonSize,
      child: IconButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: AppSpacing.md),
        color: AppColors.surfaceCard,
        style: IconButton.styleFrom(
          backgroundColor: AppColors.actionBlue,
          disabledBackgroundColor: AppColors.disabledFill,
        ),
      ),
    );
  }
}

class ProductDescriptionBlock extends StatelessWidget {
  const ProductDescriptionBlock({required this.description, super.key});

  final String description;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              const Icon(Icons.eco, color: AppColors.successGreen),
              const SizedBox(height: AppSpacing.xs),
              Text(
                localizations.whatsThis,
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: VerticalDivider(
              width: 1,
              thickness: 1,
              color: AppColors.trackGrey,
            ),
          ),
          Expanded(
            child: ShaderMask(
              blendMode: BlendMode.dstIn,
              shaderCallback: (bounds) => LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.textPrimary,
                  AppColors.textPrimary.withValues(alpha: 0),
                ],
              ).createShader(bounds),
              child: Text(description, style: AppTypography.body),
            ),
          ),
        ],
      ),
    );
  }
}
