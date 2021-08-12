import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app_filman/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required this.servicesData}) : super(UserInitial());
  final ServicesData servicesData;

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    if (event is UserCurrent) {
        final name = _pref.getString('name');
        final email = _pref.getString('email');
        final photo = _pref.getString('photo');
        print('user $name and $email and $photo');

        if (name != null) {
          yield ResultUser(email: email!, name: name!, photo: photo!);
        } else {
          yield ResultFailure(respond: 'No Data');
        }

    }

    if (event is UserLogOut) {
        await servicesData.signOut();
        _pref.clear();
        yield ResultLogOut(respond: 'LogOut');
    }
  }
}
