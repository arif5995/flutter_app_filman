part of 'data_people_bloc.dart';

abstract class DataPeopleState extends Equatable {
  const DataPeopleState();
}

class DataPeopleInitial extends DataPeopleState {
  @override
  List<Object> get props => [];
}

class DataPeopleLoaded extends DataPeopleState {
  final List<People> people;

  DataPeopleLoaded({required this.people});
  @override
  List<Object> get props => [people];
}

class DataPeopleDetailIndex extends DataPeopleState {
  final People people;

  DataPeopleDetailIndex({required this.people});

  @override
  List<Object?> get props => [people];

}

class DataPeopleFailure extends DataPeopleState {
  final String error;
  DataPeopleFailure({required this.error});
  @override
  List<Object> get props => [error];
}

class DataPeopleSukses extends DataPeopleState {
  final String sukses;
  DataPeopleSukses({required this.sukses});
  @override
  List<Object> get props => [sukses];
}
