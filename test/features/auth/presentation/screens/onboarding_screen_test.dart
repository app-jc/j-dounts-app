import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:j_dounts_app/app/router/app_router.dart';
import 'package:j_dounts_app/app/router/app_routes.dart';
import 'package:j_dounts_app/core/database/app_database.dart';
import 'package:j_dounts_app/features/auth/data/fake_auth_repository.dart';
import 'package:j_dounts_app/features/auth/data/local_user_source.dart';
import 'package:j_dounts_app/features/auth/data/secure_session_store.dart';
import 'package:j_dounts_app/features/auth/presentation/flow/auth_flow_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/phone/phone_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/session/session_notifier.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

void main() {
  late AppDatabase database;
  late SessionNotifier session;
  late AuthFlowCubit authFlow;
  late GoRouter router;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    FlutterSecureStorage.setMockInitialValues({});
    session = SessionNotifier(SecureSessionStore(), LocalUserSource(database));
    authFlow = AuthFlowCubit();
    router = createAppRouter(
      sessionNotifier: session,
      authFlowCubit: authFlow,
      phoneCubitFactory: () => PhoneCubit(
        FakeAuthRepository(LocalUserSource(database), latency: Duration.zero),
      ),
      initialLocation: AppRoutes.onboarding,
    );
  });

  tearDown(() async {
    router.dispose();
    await authFlow.close();
    session.dispose();
    await database.close();
  });

  testWidgets('shows localized onboarding actions and social controls', (
    tester,
  ) async {
    await _pumpOnboarding(tester, router);

    expect(find.text('Round food for every mood'), findsOneWidget);
    expect(find.text("LET'S GET STARTED"), findsOneWidget);
    expect(find.text('Already have an account?'), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);
    expect(find.byTooltip('Continue with Google'), findsOneWidget);
    expect(find.byTooltip('Continue with Apple'), findsOneWidget);
    expect(find.byTooltip('Continue with Facebook'), findsOneWidget);
    expect(find.text('Terms of Use'), findsOneWidget);
    expect(find.text('Privacy Policy'), findsOneWidget);
  });

  testWidgets('start and login callbacks set the matching flow', (
    tester,
  ) async {
    await _pumpOnboarding(tester, router);
    await tester.tap(find.text("LET'S GET STARTED"));
    await tester.pumpAndSettle();

    expect(authFlow.state.flow, AuthFlowType.registration);
    expect(authFlow.state.draft, const AuthDraft());
    expect(router.state.uri.path, AppRoutes.phone);

    router.go(AppRoutes.onboarding);
    await tester.pumpAndSettle();
    authFlow.updatePhone('+95912345678');
    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();

    expect(authFlow.state.flow, AuthFlowType.login);
    expect(authFlow.state.draft, const AuthDraft());
    expect(router.state.uri.path, AppRoutes.phone);
  });

  testWidgets('social and legal callbacks show the localized placeholder', (
    tester,
  ) async {
    await _pumpOnboarding(tester, router);
    await tester.tap(find.byTooltip('Continue with Google'));
    await tester.pump();

    expect(find.text("This option isn't available yet."), findsOneWidget);

    tester
        .state<ScaffoldMessengerState>(find.byType(ScaffoldMessenger))
        .hideCurrentSnackBar();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Terms of Use'));
    await tester.pump();

    expect(find.text("This option isn't available yet."), findsOneWidget);

    tester
        .state<ScaffoldMessengerState>(find.byType(ScaffoldMessenger))
        .hideCurrentSnackBar();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Privacy Policy'));
    await tester.pump();

    expect(find.text("This option isn't available yet."), findsOneWidget);
  });

  testWidgets('disableAnimations displays every entrance immediately', (
    tester,
  ) async {
    await _pumpOnboarding(tester, router, disableAnimations: true);

    final transitions = tester.widgetList<FadeTransition>(
      find.byType(FadeTransition),
    );
    expect(transitions, hasLength(9));
    expect(
      transitions.every((transition) => transition.opacity.value == 1),
      isTrue,
    );
  });
}

Future<void> _pumpOnboarding(
  WidgetTester tester,
  GoRouter router, {
  bool disableAnimations = false,
}) async {
  await tester.pumpWidget(
    MaterialApp.router(
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: disableAnimations
          ? (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(disableAnimations: true),
              child: child!,
            )
          : null,
    ),
  );
  await tester.pumpAndSettle();
}
