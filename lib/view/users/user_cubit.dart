import 'dart:convert';

import 'package:awladsanaad_2/view/users/user_state.dart';
import 'package:bloc/bloc.dart';

import '../../model/user_model.dart';
import '../../services.dart';


class UserCubit extends Cubit<UserState> {
  final _UsersService = UsersService();
  UserCubit() : super(UserInitial());

  Future<void> fetchUsers() async {
    emit(UserLoading());
    try {
      final response = await _UsersService.getAll();

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final users = jsonResponse.map((data) => UserModel.fromJson(data)).toList();

        emit(UserSuccess(users));
      } else {
        emit(UserFailure("فشل في جلب المجموعات، الحالة: ${response.statusCode}"));
      }
    } catch (e) {
      emit(const UserFailure("هناك خطأ في عرض البيانات"));
    }
  }
  Future<void> addUser(String username,String name,String password,String role) async {
    emit(UserLoading());
    try {
      final response = await _UsersService.addUser(username,name,password,role);

      if (response.statusCode == 200) {
        final res = await _UsersService.getAll();
        final List<dynamic> jsonResponse = json.decode(res.body);
        final users = jsonResponse.map((data) => UserModel.fromJson(data)).toList();
        emit(UserSuccess(users));
      } else {
        emit(const UserFailure("فشل في إضافة مستخدم"));
      }
    } catch (e) {
      emit(const UserFailure("هناك خطأ في عرض البيانات"));
    }
  }


  Future<void> deleteUser(String name) async {
    emit(UserLoading());
    try {
      final response = await _UsersService.deleteUser(name);

      if (response.statusCode == 200) {
        final res = await _UsersService.getAll();
        final List<dynamic> jsonResponse = json.decode(res.body);
        final groups = jsonResponse.map((data) => UserModel.fromJson(data)).toList();
        emit(UserSuccess(groups));
      } else {
        emit(UserFailure("هناك خطأ في حذف مستخدم"));
      }
    } catch (e) {
      emit(UserFailure("هناك خطأ في عرض البيانات"));
    }
  }
}
