// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:get_data_using_drift/data/db_helper.dart';

class EmployeeUiState {
  final bool isLoading;
  final List<EmployeeTableData> employeeTableDataList;
  EmployeeUiState({
    required this.isLoading,
    required this.employeeTableDataList,
  });



  EmployeeUiState copyWith({
    bool? isLoading,
    List<EmployeeTableData>? employeeTableDataList,
  }) {
    return EmployeeUiState(
      isLoading: isLoading ?? this.isLoading,
      employeeTableDataList: employeeTableDataList ?? this.employeeTableDataList,
    );
  }

 
}
