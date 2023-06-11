import 'dart:developer';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:get_data_using_drift/data/name_entity.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
part 'db_helper.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final dbPath = path.join(documentsDirectory.path, 'employee.db');

    // Check if the database file exists in the documents directory
    final file = File(dbPath);

    if (!await file.exists()) {
      // Copy the database file from assets to the documents directory
      log('already exits');
      final data = await rootBundle.load(path.join('assets', 'employee.db'));
      final bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
    }

    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [EmployeeTable])
class DBHelper extends _$DBHelper {
  DBHelper() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> addEmployee(EmployeeTableCompanion employeeTableCompanion) async {
    return into(employeeTable).insert(employeeTableCompanion);
  }

  Future<List<EmployeeTableData>> getAllEmployees() async {
    return select(employeeTable).get();
  }
}
