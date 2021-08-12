part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserCurrent extends UserEvent {
  @override
  List<Object?> get props => throw UnimplementedError();

}

class UserLogOut extends UserEvent {
  @override
  List<Object?> get props => throw UnimplementedError();

}
