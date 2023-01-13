import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:gifts_rep/data/model/request_error.dart';

import 'package:gifts_rep/presentation/login/model/model.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  // regularExp password
  final passwordRegexp =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  LoginBloc() : super(LoginState.initial()) {
    on<LoginLoginButtonClicked>(_loginButtonClicked);
    on<LoginEmailChanged>(_emailChanged);
    on<LoginPasswordChanged>(_passwordChanged);
    on<LoginRequestErrorShowed>(_requestErrorShow);
  }

  // клик по кнопке войти
  FutureOr<void> _loginButtonClicked(
      LoginLoginButtonClicked event, Emitter<LoginState> emit) async {
    if (state.allFieldsValid) {
      final response =
          await _login(email: state.email, password: state.password);
      if (response == null) {
        emit(state.copyWith(authentication: true));
      } else {
        switch (response) {
          case LoginError.emailNotExist:
            emit(state.copyWith(emailError: EmailError.notExist));
            break;
          case LoginError.wrongPassword:
            emit(state.copyWith(passwordError: PasswordError.wrongPassword));
            break;
          case LoginError.other:
            emit(state.copyWith(requestError: RequestError.unknown));
            break;
        }
      }
    }
  }

  // имитируем работу сервера при логине
  Future<LoginError?> _login({
    required final String email,
    required final String password,
  }) async {
    final successfulResponse = Random().nextBool();
    if (successfulResponse) {
      return null;
    }
    return LoginError.values[Random().nextInt(LoginError.values.length)];
  }

  // валидация почты
  FutureOr<void> _emailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final newEmail = event.email;
    // validation
    final emailValid = _emailValid(newEmail);
    emit(state.copyWith(
      email: newEmail,
      emailValid: emailValid,
      emailError: EmailError.noError,
      authentication: false,
    ));
  }
  bool _emailValid(final String email) {
    return EmailValidator.validate(email);
  }

  // валидация пароля
  FutureOr<void> _passwordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final newPassword = event.password;
    // validation
    final passwordValid = _passwordValid(newPassword);
    emit(state.copyWith(
      password: newPassword,
      passwordValid: passwordValid,
      passwordError: PasswordError.noError,
      authentication: false,
    ));
  }

  bool _passwordValid(final String password) {
    return passwordRegexp.hasMatch(password);
  }

  // сброс всех прочих ошибок other
  FutureOr<void> _requestErrorShow(
      LoginRequestErrorShowed event,
      Emitter<LoginState> emit,
      ) {
    emit(
      state.copyWith(requestError: RequestError.noError),
    );
  }

}

// имитируем сервер для авторизации
enum LoginError { emailNotExist, wrongPassword, other }
