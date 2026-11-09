import 'package:j_dounts_app/core/database/app_database.dart';
import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/core/error/stream_result.dart';
import 'package:j_dounts_app/core/member/data/member_mapper.dart';
import 'package:j_dounts_app/core/member/domain/member.dart' as domain;
import 'package:j_dounts_app/core/member/domain/member_repository.dart';

final class MemberRepositoryImpl implements MemberRepository {
  MemberRepositoryImpl(this._database);

  final AppDatabase _database;

  @override
  Stream<Result<domain.Member?>> watchById(int id) {
    final query = _database.select(_database.members)
      ..where((member) => member.id.equals(id));
    return toResultStream(
      query.watchSingleOrNull().map(
        (row) => row == null ? null : MemberMapper.fromRow(row),
      ),
    );
  }
}
