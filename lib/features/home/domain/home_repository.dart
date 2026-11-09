import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/features/home/domain/home_data.dart';

abstract interface class HomeRepository {
  Stream<Result<HomeData>> watchHome(int memberId);
}
