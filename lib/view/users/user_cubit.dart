import 'dart:convert';

import 'package:awladsanaad_2/view/users/user_state.dart';
import 'package:bloc/bloc.dart';

import '../../model/user_model.dart';
import '../../services.dart';


class UserCubit extends Cubit<UserState> {
  final UsersService _UsersService = UsersService();
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
}
