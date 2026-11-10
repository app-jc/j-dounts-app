import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:j_dounts_app/app/di/injection.dart';
import 'package:j_dounts_app/app/router/app_routes.dart';
import 'package:j_dounts_app/app/router/app_redirect.dart';
import 'package:j_dounts_app/app/router/rewards_route.dart';
import 'package:j_dounts_app/app/router/step_page.dart';
import 'package:j_dounts_app/app/theme/app_colors.dart';
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
import 'package:j_dounts_app/features/home/presentation/home_screen.dart';
import 'package:j_dounts_app/features/home/presentation/home_bloc.dart';
import 'package:j_dounts_app/features/home/domain/home_repository.dart';
import 'package:j_dounts_app/features/product/domain/product_repository.dart';
import 'package:j_dounts_app/features/product/presentation/product_cubit.dart';
import 'package:j_dounts_app/features/product/presentation/product_screen.dart';
import 'package:j_dounts_app/core/network/connectivity_service.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';
import 'package:j_dounts_app/app/shell/main_shell.dart';
import 'package:j_dounts_app/app/shell/placeholder_screen.dart';

export 'package:j_dounts_app/app/router/app_redirect.dart';

GoRouter createAppRouter({
  required SessionNotifier sessionNotifier,
  required AuthFlowCubit authFlowCubit,
  PhoneCubit Function()? phoneCubitFactory,
  OtpCubit Function(String phone, bool isRegistration)? otpCubitFactory,
  DobCubit Function(String phone, String firstName, String? lastName)?
  dobCubitFactory,
  HomeRepository? homeRepository,
  ProductRepository? productRepository,
  ProductCubit Function(String code)? productCubitFactory,
  ConnectivityService? connectivityService,
  String initialLocation = AppRoutes.onboarding,
}) {
  final createPhoneCubit = phoneCubitFactory ?? (() => getIt<PhoneCubit>());
  final resolvedHomeRepository =
      homeRepository ??
      (getIt.isRegistered<HomeRepository>() ? getIt<HomeRepository>() : null);
  final resolvedProductRepository =
      productRepository ??
      (getIt.isRegistered<ProductRepository>()
          ? getIt<ProductRepository>()
          : null);
  final resolvedConnectivityService =
      connectivityService ??
      (getIt.isRegistered<ConnectivityService>()
          ? getIt<ConnectivityService>()
          : null);
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
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => MainShell(
          navigationShell: navigationShell,
          connectivityService: resolvedConnectivityService,
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                pageBuilder: (context, state) => stepPage(
                  key: state.pageKey,
                  child: resolvedHomeRepository == null
                      ? PlaceholderScreen(
                          key: const ValueKey<String>('route:/home'),
                          title: AppLocalizations.of(context).homeTab,
                          actionLabel: AppLocalizations.of(context).settings,
                          onAction: () => context.go(AppRoutes.settings),
                        )
                      : BlocProvider(
                          create: (_) =>
                              (homeRepository == null &&
                                        getIt.isRegistered<HomeBloc>()
                                    ? getIt<HomeBloc>(
                                        param1: sessionNotifier.memberId!,
                                      )
                                    : HomeBloc(
                                        resolvedHomeRepository,
                                        memberId: sessionNotifier.memberId!,
                                      ))
                                ..add(const HomeStarted()),
                          child: HomeScreen(
                            key: const ValueKey<String>('route:/home'),
                            onSettings: () => context.go(AppRoutes.settings),
                            onProductTap: (code) => context.go(
                              AppRoutes.product.replaceFirst(
                                ':productId',
                                code,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.rewards,
                pageBuilder: (context, state) => stepPage(
                  key: state.pageKey,
                  child: rewardsRoute(context, sessionNotifier.memberId!),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.menu,
                pageBuilder: (context, state) => stepPage(
                  key: state.pageKey,
                  child: FeaturePlaceholderScreen(
                    title: AppLocalizations.of(context).menuTab,
                    headline: AppLocalizations.of(context).menuPlaceholderTitle,
                    message: AppLocalizations.of(context)
                        .menuPlaceholderMessage,
                    icon: Icons.donut_large_rounded,
                    accentColor: AppColors.brandPink,
                  ),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.wallet,
                pageBuilder: (context, state) => stepPage(
                  key: state.pageKey,
                  child: FeaturePlaceholderScreen(
                    title: AppLocalizations.of(context).walletTab,
                    headline: AppLocalizations.of(context)
                        .walletPlaceholderTitle,
                    message: AppLocalizations.of(context)
                        .walletPlaceholderMessage,
                    icon: Icons.account_balance_wallet_rounded,
                    accentColor: AppColors.bannerPurple,
                  ),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                pageBuilder: (context, state) => stepPage(
                  key: state.pageKey,
                  child: SettingsScreen(sessionNotifier: sessionNotifier),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.product,
        pageBuilder: (context, state) => stepPage(
          key: state.pageKey,
          child: resolvedProductRepository == null
              ? PlaceholderScreen(
                  key: ValueKey<String>('route:${state.uri.path}'),
                  title: state.uri.path,
                )
              : BlocProvider(
                  create: (_) {
                    final code = state.pathParameters['productId']!;
                    return productCubitFactory?.call(code) ??
                        ProductCubit(resolvedProductRepository, code: code);
                  },
                  child: ProductScreen(
                    key: ValueKey<String>('route:${state.uri.path}'),
                    code: state.pathParameters['productId']!,
                  ),
                ),
        ),
      ),
    ],
  );
}
