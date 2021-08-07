part of 'data_people_bloc.dart';

abstract class DataPeopleEvent extends Equatable {
  const DataPeopleEvent();
}

class DataPeopleStart extends DataPeopleEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DataPeopleDetail extends DataPeopleEvent {
  final People people;

  DataPeopleDetail({required this.people});

  @override
  // TODO: implement props
  List<Object?> get props => [people];
}

class DataPeopleUpdate extends DataPeopleEvent {
  final int id;
  final String name;
  final String height;
  final String mass;
  final String skinColor;
  final String eyeColor;
  final String hairColor;
  final String birthYear;
  final String gender;

  DataPeopleUpdate(
      {required this.id,
      required this.name,
      required this.height,
      required this.mass,
      required this.skinColor,
      required this.eyeColor,
      required this.hairColor,
      required this.birthYear,
      required this.gender});

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        height,
        mass,
        skinColor,
        eyeColor,
        hairColor,
        birthYear,
        gender
      ];
}
