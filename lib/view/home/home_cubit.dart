import 'dart:convert';
import 'package:awladsanaad_2/model/user_model.dart';
import 'package:bloc/bloc.dart';
import '../../model/group_model.dart';
import '../../services.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GroupService _groupService = GroupService();
  HomeCubit() : super(HomeInitial());

  Future<void> fetchGroups() async {
    emit(HomeLoading());
    try {
      final response = await _groupService.getAllGroups();

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final groups = jsonResponse.map((data) => Group.fromJson(data)).toList();
        emit(HomeSuccess(groups));
      } else {
        emit(HomeFailure("فشل في جلب المجموعات، الحالة: ${response.statusCode}"));
      }
    } catch (e) {
      emit(const HomeFailure("هناك خطأ في عرض البيانات"));
    }
  }

  Future<void> addGroup(String name ,UserModel teacher) async {
    emit(HomeLoading());
    try {
      final response = await _groupService.addGroup(name,teacher);

      if (response.statusCode == 200) {
        final res = await _groupService.getAllGroups();
        final List<dynamic> jsonResponse = json.decode(res.body);
        final groups = jsonResponse.map((data) => Group.fromJson(data)).toList();
        emit(HomeSuccess(groups));
      } else {
        emit(const HomeFailure("فشل في إضافة المجموعة"));
      }
    } catch (e) {
      emit(const HomeFailure("هناك خطأ في عرض البيانات"));
    }
  }

  Future<void> updateGroup(int id, String? name,UserModel? teacher) async {
    emit(HomeLoading());
    try {
      final response = await _groupService.updateGroup(id, name,teacher);

      if (response.statusCode == 200) {

        final res = await _groupService.getAllGroups();
        final List<dynamic> jsonResponse = json.decode(res.body);
        final groups = jsonResponse.map((data) => Group.fromJson(data)).toList();
        emit(HomeSuccess(groups));
      } else {
        emit(const HomeFailure("هناك خطأ في تحديث المجموعة"));
      }
    } catch (e) {
      emit(const HomeFailure("هناك خطأ في عرض البيانات"));
    }
  }

  Future<void> deleteGroup(int id) async {
    emit(HomeLoading());
    try {
      final response = await _groupService.deleteGroup(id);

      if (response.statusCode == 200) {
        final res = await _groupService.getAllGroups();
        final List<dynamic> jsonResponse = json.decode(res.body);
        final groups = jsonResponse.map((data) => Group.fromJson(data)).toList();
        emit(HomeSuccess(groups));
      } else {
        emit(HomeFailure("هناك خطأ في حذف المجموعة"));
      }
    } catch (e) {
      emit(HomeFailure("هناك خطأ في عرض البيانات"));
    }
  }
}


