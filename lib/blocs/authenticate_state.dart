part of 'authenticate_bloc.dart';

abstract class AuthenticateState extends Equatable {
  const AuthenticateState();
}

class AuthenticateInitial extends AuthenticateState {
  @override
  List<Object> get props => [];
}

class AuthenticateLoading extends AuthenticateState {
  @override
  List<Object?> get props => throw UnimplementedError();

}

class AuthtenticateLoaded extends AuthenticateState {
  final User user;

  AuthtenticateLoaded({required this.user});
  @override
  List<Object> get props => [user];
}

class AuthtenticateNotLoaded extends AuthenticateState {
  @override
  List<Object> get props => [];
}

class AuthtenticateFailure extends AuthenticateState {
  final String error;

  AuthtenticateFailure({required this.error});
  @override
  List<Object> get props => [error];
}

class LogOutGoogle extends AuthenticateState {
  final String logout;

  LogOutGoogle({required this.logout});
  @override
  List<Object> get props => [logout];
}
