import 'package:drift/native.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:j_dounts_app/features/auth/presentation/screens/dob_screen.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

void main() {
  late AppDatabase database;
  late DobCubit dob;
  late AuthFlowCubit flow;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    flow = AuthFlowCubit()..startRegistration();
    dob = DobCubit(
      FakeAuthRepository(LocalUserSource(database), latency: Duration.zero),
      phone: '+95912345678',
      firstName: 'Test',
      lastName: null,
      clock: const _Clock(),
    );
  });

  tearDown(() async {
    await dob.close();
    await flow.close();
    await database.close();
  });

  testWidgets(
    'each field opens one complete picker and cancel changes nothing',
    (tester) async {
      await tester.pumpWidget(_app(dob, flow));
      for (final field in ['Month', 'Day', 'Year']) {
        await tester.tap(find.text(field));
        await tester.pumpAndSettle();
        expect(find.byType(CupertinoDatePicker), findsOneWidget);
        expect(find.byType(CupertinoPicker), findsNWidgets(3));
        await tester.tap(find.text('Cancel'));
        await tester.pumpAndSettle();
        expect(dob.state.date, isNull);
      }
      expect(flow.state.draft.rawDobYear, isEmpty);
    },
  );

  testWidgets('scrolling stays open; OK updates all fields and retains date', (
    tester,
  ) async {
    await tester.pumpWidget(_app(dob, flow));
    await tester.tap(find.text('Month'));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(CupertinoPicker).at(1), const Offset(0, -40));
    await tester.pumpAndSettle();
    expect(find.byType(CupertinoDatePicker), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(dob.state.year, 2013);
    expect(dob.state.month, 1);
    expect(dob.state.day, 2);
    expect(flow.state.draft.rawDobYear, '2013');
    expect(flow.state.draft.rawDobMonth, '1');
    expect(flow.state.draft.rawDobDay, '2');
    await tester.tap(find.text('January'));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<CupertinoDatePicker>(find.byType(CupertinoDatePicker))
          .initialDateTime,
      DateTime(2013, 1, 2),
    );
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(dob.state.date, DateTime(2013, 1, 2));
  });

  testWidgets('a selected underage date still fails validation', (
    tester,
  ) async {
    dob.select(year: 2020, month: 5, day: 2);
    await tester.pumpWidget(_app(dob, flow));
    await tester.tap(find.text('May'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(PrimaryButton));
    await tester.pump();
    expect(find.text('Enter a valid date of birth.'), findsOneWidget);
  });
}

Widget _app(DobCubit dob, AuthFlowCubit flow) => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: MultiBlocProvider(
    providers: [
      BlocProvider.value(value: dob),
      BlocProvider.value(value: flow),
    ],
    child: const DobScreen(),
  ),
);

final class _Clock implements Clock {
  const _Clock();

  @override
  DateTime now() => DateTime(2026, 6, 15);
}
