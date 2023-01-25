import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:gifts_rep/data/model/request_error.dart';
import 'package:gifts_rep/presentation/registration/model/errors.dart';

part 'registration_event.dart';

part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  static const _defaultAvatarKey = 'test';

  static String _avatarBuilder(String key) =>
      'https://api.dicebear.com/5.x/croodles/svg?seed=$key';

  String _avatarKey = _defaultAvatarKey;

  // ввод данных
  String _email = '';
  bool _ighlightEmailError = false;
  RegistrationEmailError? _emailError;
  // ввод данных
  String _password = '';
  bool _ighlightPasswordError = false;
  RegistrationPasswordError? _passwordError;

  RegistrationBloc()
      : super(RegistrationFieldsInfo(
            avatarLink: _avatarBuilder(_defaultAvatarKey))) {
    on<RegistrationChangeAvatar>(_onChangeAvatar);
    on<RegistrationEmailChanged>(_onEmailChanged);
  }

  // изменение аватара при клике на Изменить
  FutureOr<void> _onChangeAvatar(
    final RegistrationChangeAvatar event,
    final Emitter<RegistrationState> emit,
  ) {
    _avatarKey = Random().nextInt(1000000).toString();
    emit(_calculateFieldsInfo());
  }

  // ввод данные email
  FutureOr<void> _onEmailChanged(
      final RegistrationEmailChanged event,
      final Emitter<RegistrationState> emit,
      ) {
    // бновление тек значения mail
    _email = event.email;
    _emailError = _validateEmail();
    emit(_calculateFieldsInfo());
  }
  // сбор инф-ии об ошибках заполнении полей email and avatar
  RegistrationFieldsInfo _calculateFieldsInfo() {
    return RegistrationFieldsInfo(
      avatarLink: _avatarBuilder(_avatarKey),
      emailError: _emailError,
    );
  }

  RegistrationEmailError? _validateEmail() {
    if (_email.isEmpty) {
      return RegistrationEmailError.empty;
    }
    if (EmailValidator.validate(_email)) {
      return RegistrationEmailError.invalid;
    }
    return null;
  }

}
