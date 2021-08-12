import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_filman/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authenticate_event.dart';
part 'authenticate_state.dart';

class AuthenticateBloc extends Bloc<AuthenticateEvent, AuthenticateState> {
  AuthenticateBloc({required this.servicesData}) : super(AuthenticateInitial());
  final ServicesData servicesData;

  @override
  Stream<AuthenticateState> mapEventToState(
    AuthenticateEvent event,
  ) async* {

    SharedPreferences _pref = await SharedPreferences.getInstance();

    if (event is AuthEventAppStarted) {
      yield AuthenticateLoading();
      try{
        final currUser = await servicesData.authenticate();
        if (currUser != null) {
          yield AuthtenticateLoaded(user: currUser);
        } else {
          yield AuthtenticateNotLoaded();
        }
      }catch(e) {
        yield AuthtenticateFailure(error: e.toString());
      }
    }

    if (event is Authkredential){
      yield AuthenticateLoading();
      // final auth = await userRepository.authenticate(event.user.uid);
      if (event.user.uid != ''){
        // dataTaskBloc.add(DataTaskUser(uid: event.user.uid));
        _pref.setString('uid', event.user.uid);
        _pref.setString('name', event.user.displayName!);
        _pref.setString('email', event.user.email!);
        _pref.setString('photo', event.user.photoURL!);
        yield AuthtenticateLoaded(user: event.user);
      } else {
        yield AuthtenticateNotLoaded();
      }
    }

    if (event is SignOutLoaded){
      var logout = await servicesData.signOut();
      _pref.clear();
      print("logout $logout");
      yield AuthtenticateNotLoaded();
    }

  }
}
