import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:j_dounts_app/app/router/app_routes.dart';
import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/app/theme/app_typography.dart';
import 'package:j_dounts_app/core/motion/motion.dart';
import 'package:j_dounts_app/core/motion/reduce_motion.dart';
import 'package:j_dounts_app/core/widgets/shimmer_box.dart';
import 'package:j_dounts_app/features/product/presentation/product_cubit.dart';
import 'package:j_dounts_app/features/product/presentation/product_cart_button.dart';
import 'package:j_dounts_app/features/product/presentation/product_detail_widgets.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({required this.code, super.key});

  final String code;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductCubit, ProductState>(
      listenWhen: (previous, current) =>
          !previous.addedToCart && current.addedToCart,
      listener: _clearCartFeedback,
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) => switch (state.status) {
          ProductStatus.loading => const _ProductLoading(),
          ProductStatus.notFound ||
          ProductStatus.failure => _ProductNotFound(code: code),
          ProductStatus.loaded => _ProductDetails(state: state),
        },
      ),
    );
  }

  void _clearCartFeedback(BuildContext context, ProductState state) {
    final delay = ReduceMotion.resolve(context, Motion.badgePop);
    unawaited(_resetCartFeedback(context, delay));
  }

  Future<void> _resetCartFeedback(BuildContext context, Duration delay) async {
    await Future<void>.delayed(delay);
    if (!context.mounted) return;
    context.read<ProductCubit>().clearCartFeedback();
  }
}

class _ProductLoading extends StatelessWidget {
  const _ProductLoading();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceHome,
      appBar: _ProductAppBar(onBack: () => _pop(context)),
      body: const Padding(
        padding: EdgeInsets.all(AppSpacing.screenHorizontalMargin),
        child: ShimmerBox(height: ProductHeroCard.imageHeight + AppSpacing.xxl),
      ),
    );
  }
}

class _ProductNotFound extends StatelessWidget {
  const _ProductNotFound({required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.surfaceHome,
      appBar: _ProductAppBar(onBack: () => _pop(context)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Text(
            '${localizations.productNotFound}: $code',
            textAlign: TextAlign.center,
            style: AppTypography.body,
          ),
        ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  const _ProductDetails({required this.state});

  final ProductState state;

  @override
  Widget build(BuildContext context) {
    final product = state.product!;
    final cubit = context.read<ProductCubit>();
    return Scaffold(
      backgroundColor: AppColors.surfaceHome,
      appBar: _ProductAppBar(onBack: () => _pop(context)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenHorizontalMargin,
          AppSpacing.sm,
          AppSpacing.screenHorizontalMargin,
          AppSpacing.lg,
        ),
        children: [
          ProductHeroCard(
            product: product,
            quantity: state.quantity,
            onDecrease: cubit.decrement,
            onIncrease: cubit.increment,
          ),
          const SizedBox(height: AppSpacing.lg),
          ProductDescriptionBlock(description: product.description),
          const SizedBox(height: AppSpacing.xl),
          ProductCartButton(
            totalMmk: state.totalMmk,
            addedToCart: state.addedToCart,
            onPressed: cubit.addToCart,
          ),
        ],
      ),
    );
  }
}

class _ProductAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _ProductAppBar({required this.onBack});

  final VoidCallback onBack;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surfaceHome,
      elevation: 0,
      leadingWidth: AppSpacing.backButtonSize + AppSpacing.md,
      leading: Padding(
        padding: const EdgeInsets.only(left: AppSpacing.md),
        child: IconButton(
          onPressed: onBack,
          style: IconButton.styleFrom(
            backgroundColor: AppColors.surfaceCard,
            fixedSize: const Size.square(AppSpacing.backButtonSize),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.fieldRadius),
            ),
          ),
          icon: const Icon(Icons.arrow_back, color: AppColors.brandPink),
        ),
      ),
    );
  }
}

void _pop(BuildContext context) {
  if (context.canPop()) {
    context.pop();
    return;
  }
  context.go(AppRoutes.home);
}
