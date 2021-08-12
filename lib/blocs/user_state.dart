part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class ResultUser extends UserState {
  final String name;
  final String email;
  final String photo;

  ResultUser({required this.name, required this.email, required this.photo});

  @override
  List<Object?> get props => [name, email, photo];


}

class ResultLogOut extends UserState {
  final String respond;

  ResultLogOut({required this.respond});

  @override
  List<Object?> get props => [respond];

}

class ResultFailure extends UserState {
  final String respond;

  ResultFailure({required this.respond});

  @override
  List<Object?> get props => [respond];

}
