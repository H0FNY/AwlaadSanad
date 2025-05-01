import 'package:awladsanaad_2/model/attendance_model.dart';
import 'package:awladsanaad_2/model/student_model.dart';

abstract class TableState {
  const TableState();
}

class TableInitial extends TableState {}

class TableLoading extends TableState {}

class TableSuccess extends TableState {
  final List<List<MapEntry>> cellValues;
  final List<AttendanceModel> attendance;
  final List<StudentModel> students;
  TableSuccess(this.cellValues, this.students, this.attendance);
}

class TableFailure extends TableState {
  final String error;
  const TableFailure(this.error);
}
