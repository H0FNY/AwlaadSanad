abstract class Loginstate {}

class LoginInitial extends Loginstate {}
class LoginLoading extends Loginstate {}
class LoginSuccess extends Loginstate {}
class LoginFailure extends Loginstate {
  final String error;
  LoginFailure(this.error);
}