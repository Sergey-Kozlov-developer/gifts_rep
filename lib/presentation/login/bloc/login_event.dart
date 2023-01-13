part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}
// ввод почты
class LoginEmailChanged extends LoginEvent {
  final String email;

  const LoginEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}
// ввод пароля
class LoginPasswordChanged extends LoginEvent {
  final String password;

  const LoginPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}
// нажатие на кнопку войти
class LoginLoginButtonClicked extends LoginEvent {

  const LoginLoginButtonClicked();

  @override
  List<Object?> get props => [];
}
// другая ошибка
class LoginRequestErrorShowed extends LoginEvent {
  const LoginRequestErrorShowed();
  @override
  // TODO: implement props
  List<Object?> get props => [];

}