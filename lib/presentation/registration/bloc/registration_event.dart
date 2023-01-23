part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}

// регистрация почты
class RegistrationEmailChanged extends RegistrationEvent {
  final String email;

  const RegistrationEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

// регистрация пароля
class RegistrationPasswordChanged extends RegistrationEvent {
  final String password;

  const RegistrationPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

// регистрация повторного ввода пароля
class RegistrationPasswordConfirmationChanged extends RegistrationEvent {
  final String passwordConfirmation;

  const RegistrationPasswordConfirmationChanged(this.passwordConfirmation);

  @override
  List<Object?> get props => [passwordConfirmation];
}

// регистрация имени
class RegistrationNameChanged extends RegistrationEvent {
  final String name;

  const RegistrationNameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

// снятие фокуса с поля почты
class RegistrationEmailFocusLost extends RegistrationEvent {
  const RegistrationEmailFocusLost();

  @override
  List<Object?> get props => [];
}

// снятие фокуса с поля password
class RegistrationPasswordFocusLost extends RegistrationEvent {
  const RegistrationPasswordFocusLost();

  @override
  List<Object?> get props => [];
}

// снятие фокуса с поля повторного password
class RegistrationPasswordConfirmationFocusLost extends RegistrationEvent {
  const RegistrationPasswordConfirmationFocusLost();

  @override
  List<Object?> get props => [];
}

// снятие фокуса с поля name
class RegistrationNameFocusLost extends RegistrationEvent {
  const RegistrationNameFocusLost();

  @override
  List<Object?> get props => [];
}

// изменение аватара
class RegistrationChangeAvatar extends RegistrationEvent {
  const RegistrationChangeAvatar();

  @override
  List<Object?> get props => [];
}

// изменение аватара (
class RegistrationCreateAccountAvatar extends RegistrationEvent {
  const RegistrationCreateAccountAvatar();

  @override
  List<Object?> get props => [];
}
