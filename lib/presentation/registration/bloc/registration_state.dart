part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();
}

// тображение ошибок полей регистрации
class RegistrationFieldsInfo extends RegistrationState {
  final String avatarLink;
  final RegistrationEmailError? emailError;
  final RegistrationPasswordError? passwordError;
  final RegistrationPasswordConfirmationError? passwordConfirmationError;
  final RegistrationNameError? nameError;

  const RegistrationFieldsInfo({
    required this.avatarLink,
    this.emailError,
    this.passwordError,
    this.passwordConfirmationError,
    this.nameError,
  });

  @override
  List<Object?> get props => [
        avatarLink,
        emailError,
        passwordError,
        passwordConfirmationError,
        nameError,
      ];
}
// request error
class RegistrationError extends RegistrationState {
  final RequestError requestError;
  const RegistrationError(this.requestError);

  @override
  List<Object?> get props => [requestError];

}
// ейчас мы логинимся
class RegistrationInProgress extends RegistrationState {
  const RegistrationInProgress();
  @override
  List<Object?> get props => [];

}