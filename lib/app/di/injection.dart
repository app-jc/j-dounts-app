import 'package:get_it/get_it.dart';

import 'package:j_dounts_app/core/time/clock.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerLazySingleton<Clock>(SystemClock.new);
}
