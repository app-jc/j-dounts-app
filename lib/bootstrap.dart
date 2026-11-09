import 'dart:developer' as developer;

import 'package:flutter/widgets.dart';

import 'package:j_dounts_app/app/app.dart';
import 'package:j_dounts_app/app/di/injection.dart';
import 'package:j_dounts_app/app/router/app_router.dart';
import 'package:j_dounts_app/core/database/seed/seed_service.dart';
import 'package:j_dounts_app/core/widgets/error_state.dart';
import 'package:j_dounts_app/features/auth/presentation/flow/auth_flow_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/session/session_notifier.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  final seedService = getIt<SeedService>();
  final sessionNotifier = getIt<SessionNotifier>();
  final authFlowCubit = getIt<AuthFlowCubit>();
  try {
    await sessionNotifier.prepareForInstall();
    await _initializeApp(seedService, sessionNotifier);
  } on Exception catch (error, stackTrace) {
    developer.log(
      'Initial app initialization failed.',
      name: 'bootstrap',
      error: error,
      stackTrace: stackTrace,
    );
    runApp(
      App(
        home: ErrorState(
          onRetry: () =>
              _retryAndRunApp(seedService, sessionNotifier, authFlowCubit),
        ),
      ),
    );
    return;
  }
  _runApp(sessionNotifier, authFlowCubit);
}

Future<void> _initializeApp(
  SeedService seedService,
  SessionNotifier sessionNotifier,
) async {
  await seedService.seedIfNeeded();
  await sessionNotifier.restore();
}

Future<void> _retryAndRunApp(
  SeedService seedService,
  SessionNotifier sessionNotifier,
  AuthFlowCubit authFlowCubit,
) async {
  await _initializeApp(seedService, sessionNotifier);
  _runApp(sessionNotifier, authFlowCubit);
}

void _runApp(SessionNotifier sessionNotifier, AuthFlowCubit authFlowCubit) {
  runApp(
    App(
      router: createAppRouter(
        sessionNotifier: sessionNotifier,
        authFlowCubit: authFlowCubit,
      ),
    ),
  );
}
