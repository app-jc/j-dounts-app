import 'package:flutter/material.dart';

import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/core/images/app_cached_image.dart';
import 'package:j_dounts_app/core/motion/motion.dart';
import 'package:j_dounts_app/core/utils/formatters.dart';
import 'package:j_dounts_app/features/product/domain/product.dart';
import 'package:j_dounts_app/features/product/domain/product_repository.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({
    required this.repository,
    required this.code,
    super.key,
  });

  final ProductRepository repository;
  final String code;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Result<Product?>>(
      stream: repository.watchByCode(code),
      builder: (context, snapshot) {
        final result = snapshot.data;
        if (result == null) return const _ProductLoading();
        return result.fold(
          onFailure: (_) => _ProductNotFound(code: code),
          onSuccess: (product) => product == null
              ? _ProductNotFound(code: code)
              : _ProductDetails(product: product),
        );
      },
    );
  }
}

class _ProductLoading extends StatelessWidget {
  const _ProductLoading();

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: CircularProgressIndicator()));
}

class _ProductNotFound extends StatelessWidget {
  const _ProductNotFound({required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          '${AppLocalizations.of(context).productNotFound}: $code',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _ProductDetails extends StatefulWidget {
  const _ProductDetails({required this.product});

  final Product product;

  @override
  State<_ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<_ProductDetails> {
  int _quantity = 1;

  void _changeQuantity(int delta) {
    setState(() => _quantity = (_quantity + delta).clamp(1, 99));
  }

  void _addToCart() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).addedToCart)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.surfaceHome,
      appBar: AppBar(title: Text(product.name)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Hero(
            tag: 'product:${product.code}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              child: AppCachedImage(
                source: product.image,
                width: double.infinity,
                height: 280,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  product.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              if (product.isNew) Chip(label: Text(localizations.newBadge)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            product.description,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            formatMmk(product.priceMmk * _quantity),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          _QuantityStepper(
            quantity: _quantity,
            onDecrease: () => _changeQuantity(-1),
            onIncrease: () => _changeQuantity(1),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: AppSpacing.primaryButtonHeight,
            child: FilledButton(
              onPressed: _addToCart,
              child: Text(localizations.addToCart),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantityStepper extends StatelessWidget {
  const _QuantityStepper({
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
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
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _StepperButton(icon: Icons.remove, onPressed: onDecrease),
          AnimatedSwitcher(
            duration: Motion.quantityChange,
            child: Text(
              '$quantity',
              key: ValueKey(quantity),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          _StepperButton(icon: Icons.add, onPressed: onIncrease),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onPressed,
    icon: Icon(icon),
    color: AppColors.surfaceCard,
    style: IconButton.styleFrom(backgroundColor: AppColors.actionBlue),
  );
}
