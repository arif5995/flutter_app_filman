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
  final int favorite;

  DataPeopleUpdate(
      {required this.id,
      required this.name,
      required this.height,
      required this.mass,
      required this.skinColor,
      required this.eyeColor,
      required this.hairColor,
      required this.birthYear,
      required this.gender,
      required this.favorite});

  @override
  List<Object?> get props => [
        id,
        name,
        height,
        mass,
        skinColor,
        eyeColor,
        hairColor,
        birthYear,
        gender,
        favorite
      ];
}

class DataPeopleInsert extends DataPeopleEvent {
  final String name;
  final String height;
  final String mass;
  final String skinColor;
  final String eyeColor;
  final String hairColor;
  final String birthYear;
  final String gender;

  DataPeopleInsert({
    required this.name,
    required this.height,
    required this.mass,
    required this.skinColor,
    required this.eyeColor,
    required this.hairColor,
    required this.birthYear,
    required this.gender,
  });

  @override
  List<Object?> get props => [
        name,
        height,
        mass,
        skinColor,
        eyeColor,
        hairColor,
        birthYear,
        gender,
      ];
}

class DataPeopleDelete extends DataPeopleEvent {
  final int index;

  DataPeopleDelete({required this.index});

  @override
  // TODO: implement props
  List<Object?> get props => [index];

}
class DataPeopleFav extends DataPeopleEvent {
  final int fav;
  final int id;

  DataPeopleFav({required this.fav, required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id,fav];
}

class DataPeopleSearch extends DataPeopleEvent {
  final String nama;

  DataPeopleSearch({required this.nama});

  @override
  List<Object?> get props => [];
}

class DataPeopleSort extends DataPeopleEvent {
  final String sort;

  DataPeopleSort({required this.sort});

  @override
  List<Object?> get props => [sort];
}

class DataPeopleFavorite extends DataPeopleEvent {
  @override
  List<Object?> get props => [];

}

class DataPeopleDelFav extends DataPeopleEvent {
  final int index;

  DataPeopleDelFav({required this.index});

  @override
  // TODO: implement props
  List<Object?> get props => [index];
}
