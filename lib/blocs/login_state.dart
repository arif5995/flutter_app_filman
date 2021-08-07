part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginGoogleLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginGoogleSuccess extends LoginState {
  @override
  List<Object> get props => [];
}


class LoginGoogleResult extends LoginState {
  // final User result;
  //
  // LoginGoogleResult({required this.result});
  @override
  List<Object> get props => [];
}

// class LogOutGoogle extends LoginGoogleState {
//   final String logout;
//
//   LogOutGoogle({required this.logout});
//   @override
//   List<Object> get props => [logout];
// }

class LoginGoogleError extends LoginState {
  final String error;

  LoginGoogleError({required this.error});
  @override
  List<Object> get props => [error];
}

