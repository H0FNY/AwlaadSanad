import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services.dart';
import '_login_state.dart';

class LoginCubit extends Cubit<Loginstate> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String username, String password) async {

    emit(LoginLoading());

    try {
      //usersService().login(username,password);
      usersService().login("Admin","Admin123@#");
      await Future.delayed(Duration(seconds: 2));
      // Simulate successful login
      emit(LoginSuccess());

      // If login fails, you can emit the failure state with an error message
      // emit(LoginFailure("Invalid credentials"));
    } catch (e) {
      emit(LoginFailure("An error occurred while logging in"));
    }
  }
}