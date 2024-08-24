import 'package:awladsanaad_2/model/user_model.dart';

abstract class UserState {
  const UserState();
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final List<UserModel> users;
  const UserSuccess(this.users);
}

class UserFailure extends UserState {
  final String error;
  const UserFailure(this.error);
}
