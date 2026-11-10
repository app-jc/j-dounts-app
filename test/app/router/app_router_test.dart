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
import 'package:j_dounts_app/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:j_dounts_app/features/auth/presentation/screens/welcome_screen.dart';
import 'package:j_dounts_app/features/auth/presentation/session/session_notifier.dart';
import 'package:j_dounts_app/features/settings/presentation/settings_screen.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

void main() {
  late AppDatabase database;
  late SessionNotifier session;
  late AuthFlowCubit authFlow;
  late GoRouterTestHarness harness;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    FlutterSecureStorage.setMockInitialValues({});
    session = SessionNotifier(SecureSessionStore(), LocalUserSource(database));
    authFlow = AuthFlowCubit();
    harness = GoRouterTestHarness(session, authFlow, database);
  });

  tearDown(() async {
    harness.dispose();
    await authFlow.close();
    session.dispose();
    await database.close();
  });

  testWidgets('logged-out navigation to Home redirects to onboarding', (
    tester,
  ) async {
    await _expectRoute(tester, harness, AppRoutes.home, AppRoutes.onboarding);
  });

  testWidgets('logged-in navigation to onboarding redirects to Home', (
    tester,
  ) async {
    await session.startSession(42);

    await _expectRoute(tester, harness, AppRoutes.onboarding, AppRoutes.home);
  });

  testWidgets('welcome is denied unless registration flow is active', (
    tester,
  ) async {
    await _expectRoute(
      tester,
      harness,
      AppRoutes.welcome,
      AppRoutes.onboarding,
    );
    harness.dispose();
    authFlow.startRegistration();
    harness.createRouter(initialLocation: AppRoutes.welcome);
    await tester.pumpWidget(_localizedApp(harness.router));
    await tester.pumpAndSettle();
    expect(find.byType(WelcomeScreen), findsOneWidget);
  });

  testWidgets('logged-in navigation to a product remains on that route', (
    tester,
  ) async {
    await session.startSession(42);

    await _expectRoute(tester, harness, '/product/7', '/product/7');
  });

  testWidgets('authenticated settings logout returns to onboarding', (
    tester,
  ) async {
    await session.startSession(42);
    harness.createRouter(initialLocation: AppRoutes.settings);
    await tester.pumpWidget(_localizedApp(harness.router));
    await tester.pumpAndSettle();

    expect(find.byType(SettingsScreen), findsOneWidget);
    expect(
      find.descendant(of: find.byType(AppBar), matching: find.text('Log out')),
      findsOneWidget,
    );
    expect(find.text('Make the app yours'), findsOneWidget);
    await tester.tap(find.text('Log out'));
    await tester.pumpAndSettle();

    expect(find.byType(OnboardingScreen), findsOneWidget);
    expect(session.isAuthenticated, isFalse);
  });

  testWidgets('authenticated Menu shows its coming-soon placeholder', (
    tester,
  ) async {
    await session.startSession(42);
    harness.createRouter(initialLocation: AppRoutes.menu);
    await tester.pumpWidget(_localizedApp(harness.router));
    await tester.pumpAndSettle();

    expect(find.text('Something delicious is on the way'), findsOneWidget);
    expect(find.text('Coming soon'), findsOneWidget);
  });

  testWidgets('authenticated Wallet shows its coming-soon placeholder', (
    tester,
  ) async {
    await session.startSession(42);
    harness.createRouter(initialLocation: AppRoutes.wallet);
    await tester.pumpWidget(_localizedApp(harness.router));
    await tester.pumpAndSettle();

    expect(find.text('Your wallet is getting ready'), findsOneWidget);
    expect(find.text('Coming soon'), findsOneWidget);
  });

  testWidgets('authenticated Home exposes Settings navigation', (tester) async {
    await session.startSession(42);
    harness.createRouter(initialLocation: AppRoutes.home);
    await tester.pumpWidget(_localizedApp(harness.router));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(find.byType(SettingsScreen), findsOneWidget);
  });
}

Future<void> _expectRoute(
  WidgetTester tester,
  GoRouterTestHarness harness,
  String initialLocation,
  String expectedLocation,
) async {
  harness.createRouter(initialLocation: initialLocation);
  await tester.pumpWidget(_localizedApp(harness.router));
  await tester.pumpAndSettle();
  final finder = expectedLocation == AppRoutes.onboarding
      ? find.byType(OnboardingScreen)
      : find.byKey(ValueKey<String>('route:$expectedLocation'));
  expect(finder, findsOneWidget);
}

Widget _localizedApp(GoRouter router) => MaterialApp.router(
  routerConfig: router,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
);

final class GoRouterTestHarness {
  GoRouterTestHarness(this.session, this.authFlow, this.database);

  final SessionNotifier session;
  final AuthFlowCubit authFlow;
  final AppDatabase database;
  GoRouter? _router;

  GoRouter get router => _router!;

  void createRouter({required String initialLocation}) {
    _router = createAppRouter(
      sessionNotifier: session,
      authFlowCubit: authFlow,
      phoneCubitFactory: () => PhoneCubit(
        FakeAuthRepository(LocalUserSource(database), latency: Duration.zero),
      ),
      initialLocation: initialLocation,
    );
  }

  void dispose() => _router?.dispose();
}
