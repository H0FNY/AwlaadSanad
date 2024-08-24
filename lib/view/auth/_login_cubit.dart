import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../custom/data.dart';
import '../../services.dart';
import '_login_state.dart';

class LoginCubit extends Cubit<Loginstate> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String username, String password) async {
    emit(LoginLoading());
    try {
     final response = await AuthService().login(username,password);
    if(response.statusCode==200) {
      Userdata = JwtDecoder.decode(response.body);
      Userdata["token"]=response.body;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.body);
        emit(LoginSuccess());
      } else {
        emit(LoginFailure("Invalid credentials"));
      }
    } catch (e) {
      emit(LoginFailure("An error occurred while logging in"));
    }
  }

  Future<void> logout() async {
    emit(LoginLoading());
    try {
      final response = await AuthService().logout();
      if(response.statusCode==200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
        emit(LoginSuccess());
      } else {
        emit(LoginFailure("Error"));
      }
    } catch (e) {
      emit(LoginFailure("An error occurred while Logging out"));
    }
  }
}