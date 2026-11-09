import 'package:flutter/material.dart';
import 'package:drift/native.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:j_dounts_app/app/di/injection.dart';
import 'package:j_dounts_app/core/database/app_database.dart';
import 'package:j_dounts_app/features/auth/data/local_user_source.dart';
import 'package:j_dounts_app/features/auth/data/secure_session_store.dart';
import 'package:j_dounts_app/features/auth/presentation/session/session_notifier.dart';
import 'package:j_dounts_app/features/auth/presentation/screens/welcome_screen.dart';
import 'package:j_dounts_app/l10n/app_localizations.dart';

void main() {
  testWidgets('disables system back navigation', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: WelcomeScreen(memberId: null),
      ),
    );

    expect(tester.widget<PopScope>(find.byType(PopScope)).canPop, isFalse);
  });

  testWidgets('starts the session and navigates home from Explore', (
    tester,
  ) async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    FlutterSecureStorage.setMockInitialValues({});
    final store = SecureSessionStore();
    final notifier = SessionNotifier(store, LocalUserSource(database));
    getIt.registerSingleton<SessionNotifier>(notifier);
    addTearDown(() async {
      await notifier.logout();
      notifier.dispose();
      getIt.unregister<SessionNotifier>();
      await database.close();
    });

    final router = GoRouter(
      initialLocation: '/welcome',
      routes: [
        GoRoute(
          path: '/welcome',
          builder: (context, state) => WelcomeScreen(memberId: 42),
        ),
        GoRoute(path: '/home', builder: (context, state) => const Text('Home')),
      ],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    );
    await tester.tap(find.text("LET'S EXPLORE"));
    await tester.pumpAndSettle();

    expect(notifier.memberId, 42);
  });
}
