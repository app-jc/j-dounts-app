import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:j_dounts_app/app/di/injection.dart';
import 'package:j_dounts_app/app/router/app_routes.dart';
import 'package:j_dounts_app/app/router/step_page.dart';
import 'package:j_dounts_app/features/auth/presentation/flow/auth_flow_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:j_dounts_app/features/auth/presentation/screens/phone_screen.dart';
import 'package:j_dounts_app/features/auth/presentation/screens/otp_screen.dart';
import 'package:j_dounts_app/features/auth/presentation/otp/otp_cubit.dart';
import 'package:j_dounts_app/features/auth/domain/otp_state_machine.dart';
import 'package:j_dounts_app/features/auth/presentation/screens/name_screen.dart';
import 'package:j_dounts_app/features/auth/presentation/screens/dob_screen.dart';
import 'package:j_dounts_app/features/auth/presentation/name/name_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/dob/dob_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/screens/welcome_screen.dart';
import 'package:j_dounts_app/features/auth/presentation/phone/phone_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/session/session_notifier.dart';
import 'package:j_dounts_app/features/settings/presentation/settings_screen.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

GoRouter createAppRouter({
  required SessionNotifier sessionNotifier,
  required AuthFlowCubit authFlowCubit,
  PhoneCubit Function()? phoneCubitFactory,
  OtpCubit Function(String phone, bool isRegistration)? otpCubitFactory,
  DobCubit Function(String phone, String firstName, String? lastName)?
  dobCubitFactory,
  String initialLocation = AppRoutes.onboarding,
}) {
  final createPhoneCubit = phoneCubitFactory ?? (() => getIt<PhoneCubit>());
  return GoRouter(
    initialLocation: initialLocation,
    refreshListenable: sessionNotifier,
    redirect: (context, state) => appRedirect(
      location: state.uri.path,
      isAuthenticated: sessionNotifier.isAuthenticated,
      isRegistrationFlow: authFlowCubit.state.flow == AuthFlowType.registration,
      authFlowStep: authFlowCubit.state.step,
    ),
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        pageBuilder: (context, state) => stepPage(
          key: state.pageKey,
          child: BlocProvider.value(
            value: authFlowCubit,
            child: const OnboardingScreen(),
          ),
        ),
      ),
      ShellRoute(
        // WIRE: scope AuthFlowCubit to the authentication route stack.
        builder: (context, state, child) =>
            BlocProvider.value(value: authFlowCubit, child: child),
        routes: [
          GoRoute(
            path: AppRoutes.phone,
            pageBuilder: (context, state) => stepPage(
              key: state.pageKey,
              child: BlocProvider(
                create: (_) => createPhoneCubit(),
                child: const PhoneScreen(),
              ),
            ),
          ),
          GoRoute(
            path: AppRoutes.otp,
            pageBuilder: (context, state) {
              final phone = authFlowCubit.state.draft.phone;
              final createCubit =
                  otpCubitFactory ??
                  ((value, isRegistration) => getIt<OtpCubit>(
                    // WIRE: restore OTP session metadata when returning to OTP.
                    param1: (
                      phone: value,
                      isRegistration: isRegistration,
                      authFlowCubit: authFlowCubit,
                      initialAttempt: authFlowCubit.state.otpSession == null
                          ? null
                          : OtpAttemptState.restore(
                              wrongAttempts:
                                  authFlowCubit.state.otpSession!.wrongAttempts,
                              resendDeadline: authFlowCubit
                                  .state
                                  .otpSession!
                                  .resendDeadline,
                            ),
                    ),
                  ));
              final isRegistration =
                  authFlowCubit.state.flow == AuthFlowType.registration;
              return stepPage(
                key: state.pageKey,
                child: BlocProvider(
                  create: (_) => createCubit(phone, isRegistration),
                  child: const OtpScreen(),
                ),
              );
            },
          ),
          GoRoute(
            path: AppRoutes.name,
            pageBuilder: (context, state) => stepPage(
              key: state.pageKey,
              child: BlocProvider(
                create: (_) => NameCubit(),
                child: const NameScreen(),
              ),
            ),
          ),
          GoRoute(
            path: AppRoutes.dateOfBirth,
            pageBuilder: (context, state) {
              final draft = authFlowCubit.state.draft;
              final createCubit =
                  dobCubitFactory ??
                  (phone, firstName, lastName) => getIt<DobCubit>(
                    param1: (
                      phone: phone,
                      firstName: firstName,
                      lastName: lastName,
                    ),
                  );
              return stepPage(
                key: state.pageKey,
                child: BlocProvider(
                  create: (_) =>
                      createCubit(draft.phone, draft.firstName, draft.lastName),
                  child: const DobScreen(),
                ),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.welcome,
        pageBuilder: (context, state) => stepPage(
          key: state.pageKey,
          child: WelcomeScreen(
            memberId: state.extra is int ? state.extra! as int : null,
            authFlowCubit: authFlowCubit,
          ),
        ),
      ),
      _route(AppRoutes.home),
      GoRoute(
        path: AppRoutes.settings,
        pageBuilder: (context, state) => stepPage(
          key: state.pageKey,
          child: SettingsScreen(sessionNotifier: sessionNotifier),
        ),
      ),
      GoRoute(
        path: AppRoutes.product,
        pageBuilder: (context, state) =>
            stepPage(key: state.pageKey, child: _placeholder(state.uri.path)),
      ),
    ],
  );
}

String? appRedirect({
  required String location,
  required bool isAuthenticated,
  required bool isRegistrationFlow,
  required AuthFlowStep authFlowStep,
}) {
  final isAuthRoute = location.startsWith('/auth/');
  if (isRegistrationFlow && location == AppRoutes.name) {
    return authFlowStep == AuthFlowStep.name ? null : AppRoutes.otp;
  }
  if (isRegistrationFlow && location == AppRoutes.dateOfBirth) {
    return authFlowStep == AuthFlowStep.dateOfBirth ? null : AppRoutes.name;
  }
  if (location == AppRoutes.welcome) {
    if (isAuthenticated) return AppRoutes.home;
    return isRegistrationFlow ? null : AppRoutes.onboarding;
  }
  if (isAuthenticated) {
    return location == AppRoutes.onboarding || isAuthRoute
        ? AppRoutes.home
        : null;
  }
  if (location == AppRoutes.onboarding || isAuthRoute) return null;
  return AppRoutes.onboarding;
}

GoRoute _route(String path) => GoRoute(
  path: path,
  pageBuilder: (context, state) =>
      stepPage(key: state.pageKey, child: _placeholder(path)),
);

Widget _placeholder(String route) => Builder(
  builder: (context) => Scaffold(
    key: ValueKey<String>('route:$route'),
    body: route == AppRoutes.home
        ? Center(
            child: ElevatedButton(
              onPressed: () => context.go(AppRoutes.settings),
              child: Text(AppLocalizations.of(context).settings),
            ),
          )
        : null,
  ),
);
