import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get_data_using_drift/data/name_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
part 'db_helper.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(
    () async {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final dbPath = File(path.join(documentsDirectory.path, 'employee.db'));

      if (!await dbPath.exists()) {
        try {
          final data = await rootBundle.load('assets/employee.db');
          final bytes =
              data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
          await dbPath.writeAsBytes(bytes, flush: true);
          await dbPath.create(recursive: true);
        } catch (e) {
          debugPrint('Error: $e');
        }
      }

      return NativeDatabase(dbPath);
    },
  );
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
    select(employeeTable).get().then((value) => print('this is sagol $value'));

    return select(employeeTable).get();
  }
}
