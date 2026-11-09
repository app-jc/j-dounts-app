import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:j_dounts_app/app/di/injection.dart';
import 'package:j_dounts_app/app/router/app_routes.dart';
import 'package:j_dounts_app/app/theme/app_colors.dart';
import 'package:j_dounts_app/app/theme/app_spacing.dart';
import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/features/auth/presentation/flow/auth_flow_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/otp/otp_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/session/session_notifier.dart';
import 'package:j_dounts_app/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:j_dounts_app/features/auth/presentation/widgets/otp_boxes.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<OtpCubit, OtpState>(
    listenWhen: (previous, current) =>
        previous.status != OtpStatus.verified &&
        current.status == OtpStatus.verified,
    listener: (context, state) async {
      final flow = context.read<AuthFlowCubit>().state.flow;
      if (state.status != OtpStatus.verified ||
          (flow != AuthFlowType.registration && state.identity == null)) {
        return;
      }
      if (flow == AuthFlowType.registration) {
        context.read<AuthFlowCubit>().setStep(AuthFlowStep.name);
        unawaited(context.push(AppRoutes.name));
        return;
      }
      await getIt<SessionNotifier>().startSession(state.identity!.memberId);
      if (context.mounted) context.go(AppRoutes.home);
    },
    builder: (context, state) {
      final localizations = AppLocalizations.of(context);
      final phone = context.read<AuthFlowCubit>().state.draft.phone;
      return Stack(
        children: [
          AuthScaffold(
            title: localizations.otpTitle,
            progressStep: 2,
            progressLabel: localizations.otpTitle,
            onBack: () =>
                context.canPop() ? context.pop() : context.go(AppRoutes.phone),
            onContinue: state.canSubmit
                ? context.read<OtpCubit>().verify
                : null,
            isLoading: state.status == OtpStatus.verifying,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(localizations.otpSent(phone), textAlign: TextAlign.center),
                const SizedBox(height: 24),
                OtpBoxes(
                  value: state.code,
                  shakeToken: state.shakeToken,
                  onChanged: context.read<OtpCubit>().updateCode,
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: state.remaining == Duration.zero
                      ? context.read<OtpCubit>().resend
                      : null,
                  child: Text(
                    state.remaining == Duration.zero
                        ? localizations.resend
                        : localizations.resendIn(
                            _formatDuration(state.remaining),
                          ),
                  ),
                ),
                if (state.isLocked)
                  Text(localizations.otpLocked, textAlign: TextAlign.center),
                if (state.failure != null)
                  Text(
                    _failureText(localizations, state),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
          if (state.status == OtpStatus.verifying)
            const ModalBarrier(dismissible: false, color: AppColors.scrim),
          if (state.status == OtpStatus.verifying)
            const Center(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      );
    },
  );

  String _failureText(AppLocalizations localizations, OtpState state) =>
      switch (state.failure) {
        AuthFailure(code: AuthFailureCode.wrongOtp) => localizations.otpWrong,
        AuthFailure(code: AuthFailureCode.notRegistered) =>
          localizations.phoneNotRegistered,
        _ => localizations.otpUnexpected,
      };

  String _formatDuration(Duration duration) =>
      '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
}
