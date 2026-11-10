import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:j_dounts_app/app/router/app_routes.dart';
import 'package:j_dounts_app/app/di/injection.dart';
import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/app/theme/app_typography.dart';
import 'package:j_dounts_app/core/time/clock.dart';
import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/core/widgets/app_text_field.dart';
import 'package:j_dounts_app/features/auth/presentation/flow/auth_flow_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/phone/phone_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: context.read<AuthFlowCubit>().state.draft.phone,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<PhoneCubit, PhoneState>(
    listener: (context, state) {
      if (state.status != PhoneStatus.submitted) return;
      final flow = context.read<AuthFlowCubit>();
      // WIRE: hand the canonical phone and OTP deadline ownership to auth flow.
      flow.updateCanonicalPhone(state.phone);
      flow.beginOtp(state.phone, getIt<Clock>());
      context.read<AuthFlowCubit>().setStep(AuthFlowStep.otp);
      context.go(AppRoutes.otp);
    },
    builder: (context, state) {
      final localizations = AppLocalizations.of(context);
      final flow = context.read<AuthFlowCubit>().state.flow;
      final VoidCallback? submit =
          flow != null &&
              state.isValid &&
              state.status != PhoneStatus.submitting
          ? () => context.read<PhoneCubit>().submit(flow)
          : null;
      return AuthScaffold(
        title: localizations.phoneTitle,
        progressStep: 1,
        progressLabel: localizations.phoneTitle,
        onBack: () {
          context.read<AuthFlowCubit>().reset();
          context.go(AppRoutes.onboarding);
        },
        onContinue: submit,
        isLoading: state.status == PhoneStatus.submitting,
        child: _PhoneField(
          controller: _controller,
          onSubmitted: () {
            final current = context.read<PhoneCubit>().state;
            if (flow != null &&
                current.isValid &&
                current.status != PhoneStatus.submitting) {
              context.read<PhoneCubit>().submit(flow);
            }
          },
          errorText: _errorText(localizations, state),
          onChanged: (value) {
            context.read<PhoneCubit>().updatePhone(value);
            context.read<AuthFlowCubit>().updatePhone(value);
          },
          onFocusChanged: (hasFocus) {
            if (!hasFocus) context.read<PhoneCubit>().markBlurred();
          },
        ),
      );
    },
  );

  String? _errorText(AppLocalizations localizations, PhoneState state) {
    if (!state.hasBlurred && state.failure == null) return null;
    return switch (state.failure) {
      AuthFailure(code: AuthFailureCode.notRegistered) =>
        localizations.phoneNotRegistered,
      ConflictFailure(code: ConflictFailureCode.duplicatePhone) =>
        localizations.phoneAlreadyRegistered,
      _ when !state.isValid => localizations.phoneInvalid,
      _ => null,
    };
  }
}

class _PhoneField extends StatelessWidget {
  const _PhoneField({
    required this.controller,
    required this.errorText,
    required this.onChanged,
    required this.onFocusChanged,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final String? errorText;
  final ValueChanged<String> onChanged;
  final ValueChanged<bool> onFocusChanged;
  final VoidCallback? onSubmitted;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: AppSpacing.fieldHeight,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(AppSpacing.fieldRadius),
        ),
        alignment: Alignment.center,
        child: Text('+95', style: AppTypography.fieldHint),
      ),
      const SizedBox(width: AppSpacing.sm),
      Expanded(
        child: AppTextField(
          controller: controller,
          hintText: AppLocalizations.of(context).phoneHint,
          errorText: errorText,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
          onChanged: onChanged,
          onFocusChanged: onFocusChanged,
          onSubmitted: onSubmitted,
        ),
      ),
    ],
  );
}
