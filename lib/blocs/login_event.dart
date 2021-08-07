part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginLoaded extends LoginEvent {
  @override
  List<Object?> get props => [];

}