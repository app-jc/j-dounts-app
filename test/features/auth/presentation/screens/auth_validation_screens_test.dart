import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:j_dounts_app/core/database/app_database.dart';
import 'package:j_dounts_app/core/time/clock.dart';
import 'package:j_dounts_app/core/widgets/primary_button.dart';
import 'package:j_dounts_app/features/auth/data/fake_auth_repository.dart';
import 'package:j_dounts_app/features/auth/data/local_user_source.dart';
import 'package:j_dounts_app/features/auth/presentation/dob/dob_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/flow/auth_flow_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/name/name_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/otp/otp_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/screens/dob_screen.dart';
import 'package:j_dounts_app/features/auth/presentation/screens/name_screen.dart';
import 'package:j_dounts_app/features/auth/presentation/screens/otp_screen.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

void main() {
  testWidgets('OTP Continue stays disabled until six digits are entered', (
    tester,
  ) async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    final flow = AuthFlowCubit()
      ..startLogin()
      ..updatePhone('+95912345678');
    final cubit = OtpCubit(
      FakeAuthRepository(LocalUserSource(database), latency: Duration.zero),
      phone: '+95912345678',
    );
    await tester.pumpWidget(
      _localized(
        MultiBlocProvider(
          providers: [
            BlocProvider.value(value: flow),
            BlocProvider.value(value: cubit),
          ],
          child: const OtpScreen(),
        ),
      ),
    );

    expect(_buttonFor(tester).onPressed, isNull);
    await tester.enterText(find.byType(TextField), '123456');
    await tester.pump();
    expect(_buttonFor(tester).onPressed, isNotNull);
    await cubit.close();
    await flow.close();
    await database.close();
  });

  testWidgets('Name Continue shows validation for an empty first name', (
    tester,
  ) async {
    final flow = AuthFlowCubit()..startRegistration();
    final cubit = NameCubit();
    addTearDown(flow.close);
    addTearDown(cubit.close);

    await tester.pumpWidget(
      _localized(
        MultiBlocProvider(
          providers: [
            BlocProvider.value(value: flow),
            BlocProvider.value(value: cubit),
          ],
          child: const NameScreen(),
        ),
      ),
    );

    await tester.tap(find.byType(PrimaryButton));
    await tester.pump();

    expect(find.text('Enter a valid first name.'), findsOneWidget);
  });

  testWidgets('DOB Continue shows validation until a valid date is selected', (
    tester,
  ) async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    final flow = AuthFlowCubit()..startRegistration();
    final cubit = DobCubit(
      FakeAuthRepository(LocalUserSource(database), latency: Duration.zero),
      phone: '+95912345678',
      firstName: 'Test',
      lastName: null,
      clock: const _TestClock(),
    );
    addTearDown(() async {
      await cubit.close();
      await flow.close();
      await database.close();
    });

    await tester.pumpWidget(
      _localized(
        MultiBlocProvider(
          providers: [
            BlocProvider.value(value: flow),
            BlocProvider.value(value: cubit),
          ],
          child: const DobScreen(),
        ),
      ),
    );

    await tester.tap(find.byType(PrimaryButton));
    await tester.pump();

    expect(find.text('Enter a valid date of birth.'), findsOneWidget);
  });
}

PrimaryButton _buttonFor(WidgetTester tester) =>
    tester.widget<PrimaryButton>(find.byType(PrimaryButton));

Widget _localized(Widget child) => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: child,
);

final class _TestClock implements Clock {
  const _TestClock();

  @override
  DateTime now() => DateTime(2026, 1, 1);
}
