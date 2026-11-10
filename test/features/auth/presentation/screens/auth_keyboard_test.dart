import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:j_dounts_app/app/router/app_routes.dart';
import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/features/auth/domain/auth_identity.dart';
import 'package:j_dounts_app/features/auth/domain/auth_repository.dart';
import 'package:j_dounts_app/features/auth/presentation/flow/auth_flow_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/name/name_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/otp/otp_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/phone/phone_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/screens/name_screen.dart';
import 'package:j_dounts_app/features/auth/presentation/screens/otp_screen.dart';
import 'package:j_dounts_app/features/auth/presentation/screens/phone_screen.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

void main() {
  testWidgets('phone Done submits only valid input and dismisses focus', (
    tester,
  ) async {
    final repository = _AuthRepository();
    final flow = AuthFlowCubit()..startRegistration();
    final cubit = PhoneCubit(repository);
    addTearDown(flow.close);
    addTearDown(cubit.close);
    await tester.pumpWidget(
      _app(
        MultiBlocProvider(
          providers: [
            BlocProvider.value(value: flow),
            BlocProvider.value(value: cubit),
          ],
          child: const PhoneScreen(),
        ),
      ),
    );
    await tester.enterText(find.byType(TextField), '09');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    expect(repository.phoneChecks, 0);
    expect(find.text('Enter a valid Myanmar phone number.'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '0912345678');
    final focus = tester.widget<TextField>(find.byType(TextField)).focusNode!;
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    expect(focus.hasFocus, isFalse);
    expect(repository.phoneChecks, 1);
  });

  testWidgets('OTP Done verifies only six digits and dismisses focus', (
    tester,
  ) async {
    final repository = _AuthRepository();
    final flow = AuthFlowCubit()..startLogin();
    final cubit = OtpCubit(repository, phone: '+95912345678');
    addTearDown(flow.close);
    addTearDown(() async {
      if (!cubit.isClosed) await cubit.close();
    });
    await tester.pumpWidget(
      _app(
        MultiBlocProvider(
          providers: [
            BlocProvider.value(value: flow),
            BlocProvider.value(value: cubit),
          ],
          child: const OtpScreen(),
        ),
      ),
    );
    await tester.enterText(find.byType(TextField), '123');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    expect(repository.otpChecks, 0);

    await tester.enterText(find.byType(TextField), '123456');
    final focus = tester.widget<TextField>(find.byType(TextField)).focusNode!;
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    expect(focus.hasFocus, isFalse);
    expect(repository.otpChecks, 1);
    await cubit.close();
  });

  testWidgets('name Done validates and navigates only for a valid name', (
    tester,
  ) async {
    final flow = AuthFlowCubit()..startRegistration();
    final cubit = NameCubit();
    addTearDown(flow.close);
    addTearDown(cubit.close);
    final router = GoRouter(
      initialLocation: AppRoutes.name,
      routes: [
        GoRoute(
          path: AppRoutes.name,
          builder: (_, _) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: flow),
              BlocProvider.value(value: cubit),
            ],
            child: const NameScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.dateOfBirth,
          builder: (_, _) => const Scaffold(body: Text('DOB destination')),
        ),
      ],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
    await tester.tap(find.byType(TextField).first);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    expect(find.text('Enter a valid first name.'), findsOneWidget);
    await tester.enterText(find.byType(TextField).first, 'Charlotte');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('DOB destination'), findsOneWidget);
    expect(flow.state.draft.firstName, 'Charlotte');
  });
}

Widget _app(Widget child) => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: child,
);

final class _AuthRepository implements AuthRepository {
  int phoneChecks = 0;
  int otpChecks = 0;

  @override
  Future<Result<bool>> isRegistered(String phone) async {
    phoneChecks++;
    return const Success(true);
  }

  @override
  Future<Result<AuthIdentity>> verifyOtp({
    required String phone,
    required String code,
  }) async {
    otpChecks++;
    return const FailureResult(StorageFailure());
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
