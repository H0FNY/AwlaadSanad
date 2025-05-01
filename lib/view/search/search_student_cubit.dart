import 'dart:convert';
import 'package:awladsanaad_2/model/student_model.dart';
import 'package:bloc/bloc.dart';
import '../../model/attendance_model.dart';
import '../../services.dart';
part 'search_student_state.dart';

class SearchStudentCubit extends Cubit<SearchStudentState> {
  SearchStudentCubit() : super(SearchStudentInitial());
  final  _attendanceService = AttendanceService();
  final _studentService =StudentService();
  Future<void> fetchAllAttendance(String date,int numberOfDays) async {
    emit(SearchStudentLoading());
    try {
      final response = await _attendanceService.getAllAttendance(date);
      final response2 = await _studentService.getAllStudents();
      if (response.statusCode == 200 && response2.statusCode==200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final attends =  jsonResponse.map((data) => AttendanceModel.fromJson(data)).toList();
        final List<dynamic> jsonResponse2 = json.decode(response2.body);
        final students = jsonResponse2.map((data) => SearchStudentModel.fromJson(data)).toList();


        List<List<MapEntry>> cellValues =  List.generate(
          students.length,
              (index) => List.filled(numberOfDays, const MapEntry(0,0)),
        );

        for(int i=0;i<students.length;i++){
          for(int j=0;j<attends.length;j++){
            if(students[i].id == attends[j].studentId){
              int day =int.parse(attends[j].date.substring(8,10));
              cellValues[i][day-1]=MapEntry(attends[j].id, attends[j].attendId);
            }
          }
        }
        emit(SearchStudentSuccess(cellValues,students,attends));
      } else {
        emit(SearchStudentFailure("فشل في جلب المجموعات، الحالة: ${response.statusCode}"));
      }
    } catch (e) {
      emit(const SearchStudentFailure("هناك خطأ في عرض البيانات"));
    }
  }
  Future<void> fetchDeactivatedStudents(String date,int numberOfDays) async {
    emit(SearchStudentLoading());
    try {
      final response = await _attendanceService.getAllAttendance(date);
      final response2 = await _studentService.getDeactivatedStudents();
      if (response.statusCode == 200 && response2.statusCode==200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final attends =  jsonResponse.map((data) => AttendanceModel.fromJson(data)).toList();
        final List<dynamic> jsonResponse2 = json.decode(response2.body);
        final students = jsonResponse2.map((data) => SearchStudentModel.fromJson(data)).toList();
        print("done");


        List<List<MapEntry>> cellValues =  List.generate(
          students.length,
              (index) => List.filled(numberOfDays, const MapEntry(0,0)),
        );

        for(int i=0;i<students.length;i++){
          for(int j=0;j<attends.length;j++){
            if(students[i].id == attends[j].studentId){
              int day =int.parse(attends[j].date.substring(8,10));
              cellValues[i][day-1]=MapEntry(attends[j].id, attends[j].attendId);
            }
          }
        }
        emit(SearchStudentSuccess(cellValues,students,attends));
      } else {
        emit(SearchStudentFailure("فشل في جلب المجموعات، الحالة: ${response.statusCode}"));
      }
    } catch (e) {
      emit(const SearchStudentFailure("هناك خطأ في عرض البيانات"));
    }
  }
  Future<void> deactivate(int id ,String date,int numberOfDays) async {
    emit(SearchStudentLoading());
    try {
      final archiveResponse = await StudentService().deactivateStudent(id);

      if (archiveResponse.statusCode == 200) {
        print(archiveResponse);
        final response = await _attendanceService.getAllAttendance(date);
        final response2 = await StudentService().getAllStudents();
        if (response.statusCode == 200 && response2.statusCode==200) {
          final List<dynamic> jsonResponse = json.decode(response.body);
          final attends = jsonResponse.map((data) => AttendanceModel.fromJson(data)).toList();
          final List<dynamic> jsonResponse2 = json.decode(response2.body);
          final students = jsonResponse2.map((data) => SearchStudentModel.fromJson(data)).toList();

          List<List<MapEntry>> cellValues =  List.generate(
            students.length,
                (index) => List.filled(numberOfDays, const MapEntry(0,0)),
          );

          for(int i=0;i<students.length;i++){
            for(int j=0;j<attends.length;j++){

              if(students[i].id == attends[j].studentId){
                int day =int.parse(attends[j].date.substring(8,10));
                cellValues[i][day-1]=MapEntry(attends[j].id, attends[j].attendId);
              }
            }
          }
          emit(SearchStudentSuccess(cellValues,students,attends));
        }
      } else {
        emit(const SearchStudentFailure("فشل في ارشفة الطالب"));
      }
    } catch (e) {
      emit(const SearchStudentFailure("هناك خطأ في عرض البيانات"));
    }
  }
  Future<void> fetchStudentsByName(String name,String date,int numberOfDays) async {
    emit(SearchStudentLoading());
    try {
      final response = await _attendanceService.getAllAttendance(date);
      final response2 = await _studentService.searchStudent(name);
      if (response.statusCode == 200 && response2.statusCode==200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final attends = jsonResponse.map((data) => AttendanceModel.fromJson(data)).toList();
        final List<dynamic> jsonResponse2 = json.decode(response2.body);
        final students = jsonResponse2.map((data) => SearchStudentModel.fromJson(data)).toList();
        print(students);

        List<List<MapEntry>> cellValues =  List.generate(
          students.length,
              (index) => List.filled(numberOfDays, const MapEntry(0,0)),
        );

        for(int i=0;i<students.length;i++){
          for(int j=0;j<attends.length;j++){
            if(students[i].id == attends[j].studentId){
              int day =int.parse(attends[j].date.substring(8,10));
              cellValues[i][day-1]=MapEntry(attends[j].id, attends[j].attendId);
            }
          }
        }
        emit(SearchStudentSuccess(cellValues,students,attends));
      } else {
        emit(SearchStudentFailure("فشل في جلب الطلاب، الحالة: ${response.statusCode}"));
      }
    } catch (e) {
      emit(const SearchStudentFailure("هناك خطأ في عرض البيانات"));
    }
  }
  Future<void> deleteStudent(int id ,String date,int numberOfDays) async {
    emit(SearchStudentLoading());
    try {
      final delete= await _studentService.deleteStudent(id);
      if(delete.statusCode==200) {
        final response = await _attendanceService.getAllAttendance(date);
        final response2 = await _studentService.getDeactivatedStudents();
        if (response.statusCode == 200 && response2.statusCode == 200) {
          final List<dynamic> jsonResponse = json.decode(response.body);
          final attends = jsonResponse.map((data) =>
              AttendanceModel.fromJson(data)).toList();
          final List<dynamic> jsonResponse2 = json.decode(response2.body);
          final students = jsonResponse2.map((data) =>
              SearchStudentModel.fromJson(data)).toList();


          List<List<MapEntry>> cellValues = List.generate(
            students.length,
                (index) => List.filled(numberOfDays, const MapEntry(0, 0)),
          );

          for (int i = 0; i < students.length; i++) {
            for (int j = 0; j < attends.length; j++) {
              if (students[i].id == attends[j].studentId) {
                int day = int.parse(attends[j].date.substring(8, 10));
                cellValues[i][day - 1] =
                    MapEntry(attends[j].id, attends[j].attendId);
              }
            }
          }
          emit(SearchStudentSuccess(cellValues, students, attends));
        } else {
          emit(SearchStudentFailure(
              "فشل في جلب المجموعات، الحالة: ${response.statusCode}"));
        }
      }
    } catch (e) {
      emit(const SearchStudentFailure("هناك خطأ في عرض البيانات"));
    }
  }
}
