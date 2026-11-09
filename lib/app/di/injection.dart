import 'package:get_it/get_it.dart';

import 'package:j_dounts_app/core/database/app_database.dart';
import 'package:j_dounts_app/core/database/seed/seed_service.dart';
import 'package:j_dounts_app/core/member/data/member_repository_impl.dart';
import 'package:j_dounts_app/core/member/domain/member_repository.dart';
import 'package:j_dounts_app/core/time/clock.dart';
import 'package:j_dounts_app/features/auth/data/fake_auth_repository.dart';
import 'package:j_dounts_app/features/auth/data/local_user_source.dart';
import 'package:j_dounts_app/features/auth/data/secure_session_store.dart';
import 'package:j_dounts_app/features/auth/domain/auth_repository.dart';
import 'package:j_dounts_app/features/auth/presentation/flow/auth_flow_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/phone/phone_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/otp/otp_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/dob/dob_cubit.dart';
import 'package:j_dounts_app/features/auth/presentation/session/session_notifier.dart';
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
  getIt.registerLazySingleton<LocalUserSource>(
    () => LocalUserSource(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => FakeAuthRepository(getIt<LocalUserSource>(), clock: getIt<Clock>()),
  );
  getIt.registerLazySingleton<SecureSessionStore>(SecureSessionStore.new);
  getIt.registerLazySingleton<SessionNotifier>(
    () =>
        SessionNotifier(getIt<SecureSessionStore>(), getIt<LocalUserSource>()),
  );
  getIt.registerFactory<AuthFlowCubit>(AuthFlowCubit.new);
  getIt.registerFactory<PhoneCubit>(() => PhoneCubit(getIt<AuthRepository>()));
  getIt.registerFactoryParam<
    OtpCubit,
    ({String phone, bool isRegistration}),
    void
  >(
    (params, _) => OtpCubit(
      getIt<AuthRepository>(),
      phone: params.phone,
      isRegistration: params.isRegistration,
    ),
  );
  getIt.registerFactoryParam<
    DobCubit,
    ({String phone, String firstName, String? lastName}),
    void
  >(
    (draft, _) => DobCubit(
      getIt<AuthRepository>(),
      phone: draft.phone,
      firstName: draft.firstName,
      lastName: draft.lastName,
      clock: getIt<Clock>(),
    ),
  );
}
