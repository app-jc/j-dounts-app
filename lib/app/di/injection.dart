import 'package:get_it/get_it.dart';

import 'package:j_dounts_app/core/database/app_database.dart';
import 'package:j_dounts_app/core/database/seed/seed_service.dart';
import 'package:j_dounts_app/core/member/data/member_repository_impl.dart';
import 'package:j_dounts_app/core/member/domain/member_repository.dart';
import 'package:j_dounts_app/core/time/clock.dart';
import 'package:j_dounts_app/features/home/data/home_repository_impl.dart';
import 'package:j_dounts_app/features/home/domain/home_repository.dart';
import 'package:j_dounts_app/features/product/data/product_repository_impl.dart';
import 'package:j_dounts_app/features/product/domain/product_repository.dart';
import 'package:j_dounts_app/features/rewards/data/rewards_repository_impl.dart';
import 'package:j_dounts_app/features/rewards/domain/rewards_repository.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerLazySingleton<Clock>(SystemClock.new);
  getIt.registerLazySingleton<AppDatabase>(AppDatabase.new);
  getIt.registerLazySingleton<SeedService>(
    () => SeedService(db: getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<MemberRepository>(
    () => MemberRepositoryImpl(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(getIt<AppDatabase>(), getIt<MemberRepository>()),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<RewardsRepository>(
    () =>
        RewardsRepositoryImpl(getIt<AppDatabase>(), getIt<MemberRepository>()),
  );
}
