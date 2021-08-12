import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app_filman/blocs/authenticate_bloc.dart';
import 'package:flutter_app_filman/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.servicesData}) : super(LoginInitial());
  final ServicesData servicesData;
  // final AuthenticateBloc authenticateBloc = AuthenticateBloc(servicesData: ServicesData());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    SharedPreferences _pref = await SharedPreferences.getInstance();
      if (event is LoginLoaded) {
          yield LoginGoogleLoading();
          try {
            var data = await servicesData.signInWithGoogle();
            if (data != null) {
                print('disini');
                _pref.setString('uid', data.uid);
                _pref.setString('name', data.displayName!);
                _pref.setString('email', data.email!);
                _pref.setString('photo', data.photoURL!);
                // authenticateBloc.add(Authkredential(user: data));
                yield LoginGoogleSuccess();
                // yield LoginInitial();
            } else {
              yield LoginGoogleError(error: 'Something Wrong! check again');
            }
          } catch (e) {
            yield LoginGoogleError(error: e.toString());
          }
      }
  }
}
