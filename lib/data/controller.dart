import 'package:get/get.dart';
import 'package:get_data_using_drift/data/db_helper.dart';
import 'package:get_data_using_drift/employee_ui_state.dart';

class EmployeeController extends GetxController {
  final DBHelper dbHelper = DBHelper();
  Rx<EmployeeUiState> employeeUiState = Rx(
    EmployeeUiState(
      isLoading: false,
      employeeTableDataList: [],
    ),
  );

  Future<void> getAllEmployees() async {
    employeeUiState.value = employeeUiState.value.copyWith(isLoading: true);

    final List<EmployeeTableData> employeeList =
        await dbHelper.getAllEmployees();

    employeeUiState.value = employeeUiState.value.copyWith(
      isLoading: false,
      employeeTableDataList: employeeList,
    );

    print('this is employeeList ${employeeList.length}');
  }

  Future<void> addEmployee(
      EmployeeTableCompanion employeeTableCompanion) async {
    await dbHelper.addEmployee(employeeTableCompanion);
    getAllEmployees();
  }

  @override
  void onInit() {
    super.onInit();
    getAllEmployees();
  }
}
