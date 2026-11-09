import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:j_dounts_app/app/router/app_routes.dart';
import 'package:j_dounts_app/core/database/app_database.dart';
import 'package:j_dounts_app/core/widgets/primary_button.dart';
import 'package:j_dounts_app/features/auth/data/fake_auth_repository.dart';
import 'package:j_dounts_app/features/auth/data/local_user_source.dart';
import 'package:j_dounts_app/features/auth/presentation/flow/auth_flow_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/phone/phone_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:j_dounts_app/features/auth/presentation/screens/phone_screen.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

void main() {
  late AppDatabase database;
  late AuthFlowCubit flow;
  late PhoneCubit phone;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    flow = AuthFlowCubit()..startRegistration();
    phone = PhoneCubit(
      FakeAuthRepository(LocalUserSource(database), latency: Duration.zero),
    );
  });

  tearDown(() async {
    await phone.close();
    await flow.close();
    await database.close();
  });

  testWidgets('shows phone field and disables Continue until valid', (
    tester,
  ) async {
    await tester.pumpWidget(_buildApp(flow, phone));

    expect(find.text('Enter your phone number'), findsOneWidget);
    expect(find.text('+95'), findsOneWidget);
    expect(find.text('CONTINUE'), findsOneWidget);
    expect(_buttonFor(tester).onPressed, isNull);

    await tester.enterText(find.byType(TextField), '09 12345678');
    await tester.pump();

    expect(_buttonFor(tester).onPressed, isNotNull);
  });

  testWidgets('shows inline validation after the field loses focus', (
    tester,
  ) async {
    await tester.pumpWidget(_buildApp(flow, phone));
    await tester.tap(find.byType(TextField));
    await tester.enterText(find.byType(TextField), '09 123');
    tester.binding.focusManager.primaryFocus?.unfocus();
    await tester.pumpAndSettle();

    expect(find.text('Enter a valid Myanmar phone number.'), findsOneWidget);
  });

  testWidgets('back arrow pops to onboarding when the route has a stack', (
    tester,
  ) async {
    final router = _router(
      flow: flow,
      phone: phone,
      initialLocation: AppRoutes.onboarding,
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(_routerApp(router));
    await tester.pumpAndSettle();

    await tester.tap(find.text("LET'S GET STARTED"));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(
      router.routeInformationProvider.value.uri.path,
      AppRoutes.onboarding,
    );
  });

  testWidgets('back arrow falls back to onboarding without a stack', (
    tester,
  ) async {
    final router = _router(
      flow: flow,
      phone: phone,
      initialLocation: AppRoutes.phone,
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(_routerApp(router));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(
      router.routeInformationProvider.value.uri.path,
      AppRoutes.onboarding,
    );
  });
}

PrimaryButton _buttonFor(WidgetTester tester) =>
    tester.widget<PrimaryButton>(find.byType(PrimaryButton));

Widget _buildApp(AuthFlowCubit flow, PhoneCubit phone) => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: BlocProvider.value(
    value: flow,
    child: BlocProvider.value(value: phone, child: const PhoneScreen()),
  ),
);

GoRouter _router({
  required AuthFlowCubit flow,
  required PhoneCubit phone,
  required String initialLocation,
}) => GoRouter(
  initialLocation: initialLocation,
  routes: [
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) =>
          BlocProvider.value(value: flow, child: const OnboardingScreen()),
    ),
    GoRoute(
      path: AppRoutes.phone,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: flow),
          BlocProvider.value(value: phone),
        ],
        child: const PhoneScreen(),
      ),
    ),
  ],
);

Widget _routerApp(GoRouter router) => MaterialApp.router(
  routerConfig: router,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
);
