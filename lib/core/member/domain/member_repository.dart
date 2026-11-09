import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/core/member/domain/member.dart';

abstract interface class MemberRepository {
  Stream<Result<Member?>> watchById(int id);
}
