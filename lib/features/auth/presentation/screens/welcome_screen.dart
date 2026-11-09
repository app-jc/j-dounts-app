import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:j_dounts_app/app/di/injection.dart';
import 'package:j_dounts_app/app/router/app_routes.dart';
import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/app/theme/app_typography.dart';
import 'package:j_dounts_app/core/widgets/primary_button.dart';
import 'package:j_dounts_app/features/auth/presentation/session/session_notifier.dart';
import 'package:j_dounts_app/features/auth/presentation/flow/auth_flow_cubit.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({required this.memberId, this.authFlowCubit, super.key});

  final int? memberId;
  final AuthFlowCubit? authFlowCubit;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isStarting = false;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.brandPinkSoft,
        body: SafeArea(
          child: Column(
            children: [
              const Expanded(child: _WelcomeTileCollage()),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontalMargin,
                  AppSpacing.md,
                  AppSpacing.screenHorizontalMargin,
                  AppSpacing.md,
                ),
                child: Text(
                  localizations.welcomeTitle,
                  textAlign: TextAlign.center,
                  style: AppTypography.displayTitle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontalMargin,
                  0,
                  AppSpacing.screenHorizontalMargin,
                  AppSpacing.xl,
                ),
                child: PrimaryButton(
                  label: localizations.letsExplore,
                  onPressed: widget.memberId == null || _isStarting
                      ? null
                      : _startSession,
                  isLoading: _isStarting,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _startSession() async {
    final memberId = widget.memberId;
    if (memberId == null || _isStarting) return;
    setState(() => _isStarting = true);
    await getIt<SessionNotifier>().startSession(memberId);
    // WIRE: clear in-memory registration state before entering Home.
    widget.authFlowCubit?.reset();
    if (!mounted) return;
    context.go(AppRoutes.home);
  }
}

class _WelcomeTileCollage extends StatelessWidget {
  const _WelcomeTileCollage();

  static const _tiles = [
    ('assets/images/products/purple_glazed_donut.jpg', 1.15),
    ('assets/images/products/strawberry_chocolate_donut.jpg', 0.8),
    ('assets/images/products/assorted_donut_box.jpg', 1.0),
    ('assets/images/products/coconut_flake_donut.jpg', 0.9),
    ('assets/images/products/seasonal_mixed_box.jpg', 1.2),
  ];

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
    child: Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: [
          for (final tile in _tiles)
            _WelcomeTile(assetPath: tile.$1, sizeFactor: tile.$2),
        ],
      ),
    ),
  );
}

class _WelcomeTile extends StatelessWidget {
  const _WelcomeTile({required this.assetPath, required this.sizeFactor});

  final String assetPath;
  final double sizeFactor;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
    child: SizedBox(
      width: 108 * sizeFactor,
      height: 108 * sizeFactor,
      child: Image.asset(assetPath, fit: BoxFit.cover),
    ),
  );
}
