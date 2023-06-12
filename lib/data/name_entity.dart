import 'package:drift/drift.dart';

class EmployeeTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userName => text()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
}

 