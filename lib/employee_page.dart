import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drift/drift.dart' as drift;
import 'package:get_data_using_drift/data/controller.dart';
import 'package:get_data_using_drift/data/db_helper.dart';
import 'package:get_data_using_drift/employee_ui_state.dart';

class EmployeePase extends StatelessWidget {
  EmployeePase({super.key});

  final EmployeeController employeeController = Get.put(EmployeeController());

  @override
  Widget build(BuildContext context) {
    return GetX(
      init: employeeController,
      initState: (_) {},
      builder: (controller) {
        final EmployeeUiState uiState = controller.employeeUiState.value;
        final employee = uiState.employeeTableDataList;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Employee List'),
          ),
          body: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    employeeController.addEmployee(
                      const EmployeeTableCompanion(
                        firstName: drift.Value('Hello'),
                        lastName: drift.Value('20'),
                        userName: drift.Value('20000'),
                      ),
                    );
                  },
                  child: const Text('Add Employee')),
              ListView.builder(
                shrinkWrap: true,
                itemCount: employee.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Text(employee[index].firstName),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
