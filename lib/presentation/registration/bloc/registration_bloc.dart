import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gifts_rep/data/model/request_error.dart';
import 'package:gifts_rep/presentation/registration/model/errors.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {

  static String _avatarBuilder(String key) => 'https://api.dicebear.com/5.x/croodles/svg?seed=$key';


  RegistrationBloc() : super(RegistrationFieldsInfo(avatarLink: _avatarBuilder('asss'))) {
    on<RegistrationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
