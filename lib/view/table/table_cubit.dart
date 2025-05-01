import 'dart:convert';
import 'package:awladsanaad_2/model/attendance_model.dart';
import 'package:awladsanaad_2/model/student_model.dart';
import 'package:awladsanaad_2/services.dart';
import 'package:awladsanaad_2/view/table/table_state.dart';
import 'package:bloc/bloc.dart';

class TableCubit extends Cubit<TableState> {
  TableCubit() : super(TableInitial());
  final  _attendanceService = AttendanceService();
  Future<void> fetchAttendance(int groupId,String date,int numberOfDays) async {
    emit(TableLoading());
    try {
      final response = await _attendanceService.getAllAttendance(date);
      final response2 = await StudentService().getStudentsByGroup(groupId);
      if (response.statusCode == 200 && response2.statusCode==200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final attends = jsonResponse.map((data) => AttendanceModel.fromJson(data)).toList();
        final List<dynamic> jsonResponse2 = json.decode(response2.body);
        final students = jsonResponse2.map((data) => StudentModel.fromJson(data)).toList();

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
        emit(TableSuccess(cellValues,students,attends));
      } else {
        emit(TableFailure("فشل في جلب المجموعات، الحالة: ${response.statusCode}"));
      }
    } catch (e) {
      emit(const TableFailure("هناك خطأ في عرض البيانات"));
    }
  }

  Future<void> addStudent(String name ,int groupId,String date,int numberOfDays,String phone) async {
    emit(TableLoading());
    try {
      final addResponse = await StudentService().addStudent(name,groupId,phone);

      if (addResponse.statusCode == 200) {

        final response = await _attendanceService.getAllAttendance(date);
        final response2 = await StudentService().getStudentsByGroup(groupId);
        if (response.statusCode == 200 && response2.statusCode==200) {
          final List<dynamic> jsonResponse = json.decode(response.body);
          final attends = jsonResponse.map((data) => AttendanceModel.fromJson(data)).toList();
          final List<dynamic> jsonResponse2 = json.decode(response2.body);
          final students = jsonResponse2.map((data) => StudentModel.fromJson(data)).toList();

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
          emit(TableSuccess(cellValues,students,attends));
        }
      } else {
        emit(const TableFailure("فشل في إضافة المجموعة"));
      }
    } catch (e) {
      emit(const TableFailure("هناك خطأ في عرض البيانات"));
    }
  }
  Future<void> updateStudent(String name ,int groupId,int? selectedGroupId,String date,int numberOfDays,String phone,int stdId) async {
    emit(TableLoading());
    try {
      final addResponse = await StudentService().updateStudent(name,selectedGroupId??groupId,stdId,phone);


      if (addResponse.statusCode == 200) {

        final response = await _attendanceService.getAllAttendance(date);
        final response2 = await StudentService().getStudentsByGroup(groupId);
        if (response.statusCode == 200 && response2.statusCode==200) {
          final List<dynamic> jsonResponse = json.decode(response.body);
          final attends = jsonResponse.map((data) => AttendanceModel.fromJson(data)).toList();
          final List<dynamic> jsonResponse2 = json.decode(response2.body);
          final students = jsonResponse2.map((data) => StudentModel.fromJson(data)).toList();

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
          emit(TableSuccess(cellValues,students,attends));
        }
      } else {
        emit(const TableFailure("فشل في تعديل الطالب"));
      }
    } catch (e) {
      emit(const TableFailure("هناك خطأ في عرض البيانات"));
    }
  }
  Future<void> deactivate(int id ,int groupId,String date,int numberOfDays) async {
    emit(TableLoading());
    try {
      final archiveResponse = await StudentService().deactivateStudent(id);

      if (archiveResponse.statusCode == 200) {
        print(archiveResponse);
        final response = await _attendanceService.getAllAttendance(date);
        final response2 = await StudentService().getStudentsByGroup(groupId);
        if (response.statusCode == 200 && response2.statusCode==200) {
          final List<dynamic> jsonResponse = json.decode(response.body);
          final attends = jsonResponse.map((data) => AttendanceModel.fromJson(data)).toList();
          final List<dynamic> jsonResponse2 = json.decode(response2.body);
          final students = jsonResponse2.map((data) => StudentModel.fromJson(data)).toList();

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
          emit(TableSuccess(cellValues,students,attends));
        }
      } else {
        emit(const TableFailure("فشل في ارشفة الطالب"));
      }
    } catch (e) {
      emit(const TableFailure("هناك خطأ في عرض البيانات"));
    }
  }

  Future<void> updateAttendance(int groupId,String dateMonth,List<List<MapEntry>> cellsValues,List<List<MapEntry>> stateCellsValues,int numberOfDays) async {
    emit(TableLoading());
    try {
      final response2 = await StudentService().getStudentsByGroup(groupId);
      final List<dynamic> jsonResponse2 = json.decode(response2.body);
      final students = jsonResponse2.map((data) => StudentModel.fromJson(data)).toList();

      for(int a=0;a<cellsValues.length;a++) {
        for(int i=0;i<cellsValues[a].length;i++){
          String day;
          if(i<9)
            day = dateMonth.split("-").reversed.join("-")+"-0${i+1}";
          else{
            day= dateMonth.split("-").reversed.join("-")+"-${i+1}";
          }
            if(cellsValues[a][i].key == stateCellsValues[a][i].key&&cellsValues[a][i].key!=0){
             _attendanceService.updateAttendance(cellsValues[a][i].value,cellsValues[a][i].key,day);
            }
            else if(cellsValues[a][i].key==0&&cellsValues[a][i].value!=0){
              print(day);
              await _attendanceService.addAttendance("desc", day, students[a].id, cellsValues[a][i].value);
            }
        }
      }
        final response = await _attendanceService.getAllAttendance(dateMonth);

        if (response.statusCode == 200 && response2.statusCode==200) {
          final List<dynamic> jsonResponse = json.decode(response.body);
          final attends = jsonResponse.map((data) => AttendanceModel.fromJson(data)).toList();


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

          emit(TableSuccess(cellValues,students,attends));
        }
       else {
        emit(const TableFailure("فشل في تعديل الغياب"));
      }
    } catch (e) {
      emit(const TableFailure("هناك خطأ في عرض البيانات"));
    }
  }
  Future<void> updateDesc(int groupId,String dateMonth,int numberOfDays,int attendId,String desc) async {
    emit(TableLoading());
    try {
      final update=await AttendanceService().updateDesc(attendId, desc);


      final response2 = await StudentService().getStudentsByGroup(groupId);
      final List<dynamic> jsonResponse2 = json.decode(response2.body);
      final students = jsonResponse2.map((data) => StudentModel.fromJson(data)).toList();
      final response = await _attendanceService.getAllAttendance(dateMonth);

      if (response.statusCode == 200 && response2.statusCode==200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final attends = jsonResponse.map((data) => AttendanceModel.fromJson(data)).toList();


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

        emit(TableSuccess(cellValues,students,attends));
      }
      else {
        emit(const TableFailure("فشل في تعديل الغياب"));
      }
    } catch (e) {
      emit(const TableFailure("هناك خطأ في عرض البيانات"));
    }
  }


}
