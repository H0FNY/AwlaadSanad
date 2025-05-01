part of 'search_student_cubit.dart';

abstract class SearchStudentState {
  const SearchStudentState();
}

class SearchStudentInitial extends SearchStudentState {}

class SearchStudentLoading extends SearchStudentState {}

class SearchStudentSuccess extends SearchStudentState {
  final List<List<MapEntry>> cellValues;
  final List<AttendanceModel> attendance;
  final List<SearchStudentModel> students;
  SearchStudentSuccess(this.cellValues, this.students, this.attendance);
}

class SearchStudentFailure extends SearchStudentState {
  final String error;
  const SearchStudentFailure(this.error);
}
