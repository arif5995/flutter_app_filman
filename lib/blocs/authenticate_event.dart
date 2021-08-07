part of 'authenticate_bloc.dart';

abstract class AuthenticateEvent extends Equatable {
  const AuthenticateEvent();
}

class AuthEventAppStarted extends AuthenticateEvent {
  @override
  List<Object?> get props => throw UnimplementedError();

}

class Authkredential extends AuthenticateEvent{
  final User user;

  Authkredential({required this.user});
  @override
  List<Object?> get props => [user];

}

class SignOutLoaded extends AuthenticateEvent {
  @override
  List<Object?> get props => throw UnimplementedError();

}
