import 'dart:developer' as developer;

import 'package:flutter/widgets.dart';

import 'package:j_dounts_app/app/app.dart';
import 'package:j_dounts_app/app/di/injection.dart';
import 'package:j_dounts_app/core/database/seed/seed_service.dart';
import 'package:j_dounts_app/core/widgets/error_state.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  final seedService = getIt<SeedService>();
  try {
    await seedService.seedIfNeeded();
  } on Exception catch (error, stackTrace) {
    developer.log(
      'Initial database seeding failed.',
      name: 'bootstrap',
      error: error,
      stackTrace: stackTrace,
    );
    runApp(App(home: ErrorState(onRetry: () => _retryAndRunApp(seedService))));
    return;
  }
  runApp(const App());
}

Future<void> _retryAndRunApp(SeedService seedService) async {
  await seedService.seedIfNeeded();
  runApp(const App());
}
