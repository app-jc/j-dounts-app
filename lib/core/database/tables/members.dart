import 'package:drift/drift.dart';

class Members extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get phone => text().unique()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text().nullable()();
  DateTimeColumn get dateOfBirth => dateTime()();
  TextColumn get photo => text().nullable()();
  IntColumn get totalPoints => integer().withDefault(const Constant(0))();
  IntColumn get notificationCount => integer().withDefault(const Constant(0))();
}
