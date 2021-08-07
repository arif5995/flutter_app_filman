import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app_filman/blocs/authenticate_bloc.dart';
import 'package:flutter_app_filman/services/services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.servicesData, required this.authenticateBloc}) : super(LoginInitial());
  final ServicesData servicesData;
  final AuthenticateBloc authenticateBloc;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
      if (event is LoginLoaded) {
          yield LoginGoogleLoading();
          try {
            var data = await servicesData.signInWithGoogle();
            if (data != null) {
                authenticateBloc.add(Authkredential(user: data));
                yield LoginGoogleSuccess();
                yield LoginInitial();
            } else {
              yield LoginGoogleError(error: 'Something Wrong! check again');
            }
          } catch (e) {
            yield LoginGoogleError(error: e.toString());
          }
      }
  }
}
