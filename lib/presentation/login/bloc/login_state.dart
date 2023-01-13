part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String email;
  final EmailError emailError;
  final String password;
  final PasswordError passwordError;
  final bool emailValid;
  final bool passwordValid;
  final bool authentication;
  final RequestError requestError;

  const LoginState({
    required this.email,
    required this.emailError,
    required this.password,
    required this.passwordError,
    required this.emailValid,
    required this.passwordValid,
    required this.authentication,
    required this.requestError,
  });

  bool get allFieldsValid => emailValid && passwordValid;

  // начальное состояние, когда на экране пустые поля ввода
  factory LoginState.initial() => const LoginState(
        email: '',
        emailError: EmailError.noError,
        password: '',
        passwordError: PasswordError.noError,
        emailValid: false,
        passwordValid: false,
        authentication: false,
        requestError: RequestError.noError,
      );

  LoginState copyWith({
    final String? email,
    final EmailError? emailError,
    final String? password,
    final PasswordError? passwordError,
    final bool? emailValid,
    final bool? passwordValid,
    final bool? authentication,
    final RequestError? requestError,
  }) {
    return LoginState(
      email: email ?? this.email,
      emailError: emailError ?? this.emailError,
      password: password ?? this.password,
      passwordError: passwordError ?? this.passwordError,
      emailValid: emailValid ?? this.emailValid,
      passwordValid: passwordValid ?? this.passwordValid,
      authentication: authentication ?? this.authentication,
      requestError: requestError ?? this.requestError,
    );
  }

  @override
  List<Object?> get props => [
        email,
        emailError,
        password,
        passwordError,
        emailValid,
        passwordValid,
        authentication,
        requestError,
      ];
}
