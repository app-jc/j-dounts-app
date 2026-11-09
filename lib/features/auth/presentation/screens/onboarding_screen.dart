import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:j_dounts_app/app/router/app_routes.dart';
import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/core/motion/reduce_motion.dart';
import 'package:j_dounts_app/core/motion/stagger_interval.dart';
import 'package:j_dounts_app/features/auth/presentation/flow/auth_flow_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/screens/onboarding_actions.dart';
import 'package:j_dounts_app/features/auth/presentation/screens/onboarding_donut_collage.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  static const _collageItemCount = 4;
  static const _actionsItemCount = 5;
  static const _itemCount = _collageItemCount + _actionsItemCount;

  late final AnimationController _controller;
  late final List<Animation<double>> _entrances;
  bool _hasStarted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _entrances = List.generate(
      _itemCount,
      (index) => CurvedAnimation(
        parent: _controller,
        curve: StaggerInterval.forItem(index, _itemCount),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ReduceMotion.isReduced(context)) {
      _hasStarted = true;
      _controller.value = 1;
      return;
    }
    if (_hasStarted) return;
    _hasStarted = true;
    _controller.duration = StaggerInterval.durationFor(_itemCount);
    unawaited(_controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final flow = context.read<AuthFlowCubit>();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.brandPinkSoft, AppColors.surfaceCard],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  children: [
                    SizedBox(
                      height: constraints.maxHeight * 0.46,
                      child: OnboardingDonutCollage(
                        entrances: _entrances.take(_collageItemCount).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.screenHorizontalMargin,
                      ),
                      child: OnboardingActions(
                        localizations: localizations,
                        entrances: _entrances.sublist(_collageItemCount),
                        onRegister: () {
                          flow.startRegistration();
                          context.push(AppRoutes.phone);
                        },
                        onLogin: () {
                          flow.startLogin();
                          context.push(AppRoutes.phone);
                        },
                        onPlaceholder: () => _showPlaceholder(
                          context,
                          localizations.placeholderActionMessage,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showPlaceholder(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
