import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app_filman/entitis/people.dart';
import 'package:flutter_app_filman/models/people_model.dart';
import 'package:flutter_app_filman/services/services.dart';
import 'package:logger/logger.dart';

part 'data_people_event.dart';

part 'data_people_state.dart';

class DataPeopleBloc extends Bloc<DataPeopleEvent, DataPeopleState> {
  DataPeopleBloc({required this.servicesData}) : super(DataPeopleInitial());
  final ServicesData servicesData;
  final logger = Logger();

  @override
  Stream<DataPeopleState> mapEventToState(
    DataPeopleEvent event,
  ) async* {
    yield DataPeopleBool(button: false);
    if (event is DataPeopleStart) {
      yield DataPeopleLoading();
      // yield DataPeopleBool(button: false);
      try {
        final checkDb = await servicesData.retrievePeople();
        if (checkDb.isEmpty) {
          final people = await servicesData.getPeople();
          if (people!.isNotEmpty) {
            final first = await servicesData.insertDataFromApi(people);
            if (first == 1) {
              final peoples = await servicesData.retrievePeople();
              // yield DataPeopleLoading();
              yield DataPeopleLoaded(people: peoples);
            } else {
              yield DataPeopleFailure(error: 'Data Kosong');
            }
          } else {
            print('data null');
          }
        } else {
          final peoples = await servicesData.retrievePeople();
          yield DataPeopleLoaded(people: peoples);
        }
      } catch (e) {}
    }

    if (event is DataPeopleDetail) {
      yield DataPeopleDetailIndex(people: event.people);
    }

    if (event is DataPeopleUpdate) {
      yield DataPeopleLoading();
      logger.d('Log Data People');
      print('upade');
      yield* _updateData(event);
    }

    if (event is DataPeopleSearch) {
      // yield DataPeopleBool(button: false);
      print('search');
      List<People> datapipel = [];
      final firstData = await servicesData.retrievePeople();
      if (event.nama.isNotEmpty) {
        if (firstData.isNotEmpty) {
          datapipel.clear();
          firstData.forEach((data) {
            if (data.name.toLowerCase().contains(event.nama.toLowerCase()))
              datapipel.add(data);
          });
          yield DataPeopleLoaded(people: datapipel);
        } else {
          yield DataPeopleFailure(error: 'Data Kosong');
        }
      } else {
        yield DataPeopleLoaded(people: firstData);
      }
    }

    if (event is DataPeopleSort) {
      final sortDesc = await servicesData.sortBy(event.sort);
      if (sortDesc.isNotEmpty) {
        yield DataPeopleBool(button: true);
        yield DataPeopleLoaded(people: sortDesc);
      } else {
        yield DataPeopleFailure(error: 'No Data');
      }
    }

    if (event is DataPeopleInsert) {
        yield* _insertData(event);
    }

    if (event is DataPeopleDelete) {
        final del = await servicesData.deletePeople(event.index);
        if (del != 0) {
          yield DataPeopleSukses(sukses: 'Data Berhasil Dihapus!');
        } else {
          yield DataPeopleFailure(error: 'Data Gagal Dihapus');
        }
    }

    if (event is DataPeopleFav) {
        final paporit = await servicesData.favoritkan(event.id, event.fav);
        if (paporit != 0) {
          yield DataPeopleSukses(sukses: 'Data Di Favoritkan');
        }else {
          yield DataPeopleFailure(error: 'Gagal');
        }
    }

    if (event is DataPeopleFavorite) {
        yield DataPeopleLoading();
        final dataFav = await servicesData.listFavorite(1);
        if (dataFav.isNotEmpty) {
          yield DataPeopleLoaded(people: dataFav);
        } else {
          yield DataPeopleFailure(error: 'No Data Favorit');
        }
    }

    if (event is DataPeopleDelFav) {
      final delFav = await servicesData.deleteFavorite(event.index);
      if (delFav != 0) {
        yield DataPeopleSukses(sukses: 'Data Berhasil Dihapus!');
      } else {
        yield DataPeopleFailure(error: 'Data Gagal Dihapus');
      }
    }
  }

  Stream<DataPeopleState> _insertData(DataPeopleInsert event) async* {
    print('bloc insert');
    PeopleModel data = PeopleModel(
        name: event.name,
        height: event.height,
        mass: event.mass,
        skin_color: event.skinColor,
        hair_color: event.hairColor,
        eye_color: event.eyeColor,
        birth_year: event.birthYear,
        gender: event.gender,
        homeworld: "kosong",);

    final update = await servicesData.insertData(data);
    print('hasil $update');
    if (update != 0) {
      // yield DataPeopleLoading();
      yield DataPeopleSukses(sukses: 'sukses');
    } else {
      yield DataPeopleFailure(error: 'Gagal Simpan');
    }
  }

  Stream<DataPeopleState> _updateData(DataPeopleUpdate event) async* {
    print('bloc update');
    PeopleModel data = PeopleModel(
        id: event.id,
        name: event.name,
        height: event.height,
        mass: event.mass,
        skin_color: event.skinColor,
        hair_color: event.hairColor,
        eye_color: event.eyeColor,
        birth_year: event.birthYear,
        gender: event.gender,
        homeworld: "kosong",
        favorite: event.favorite
    );
    print('data pipel ${data.toMap()}');
    final update = await servicesData.updatePeople(data);
    print('hasil $update');
    if (update != 0) {
      // yield DataPeopleLoading();
      yield DataPeopleSukses(sukses: 'sukses');
    } else {
      yield DataPeopleFailure(error: 'Gagal Simpan');
    }
  }
}
