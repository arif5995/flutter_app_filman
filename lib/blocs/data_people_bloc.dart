import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app_filman/entitis/people.dart';
import 'package:flutter_app_filman/models/people_model.dart';
import 'package:flutter_app_filman/services/services.dart';

part 'data_people_event.dart';

part 'data_people_state.dart';

class DataPeopleBloc extends Bloc<DataPeopleEvent, DataPeopleState> {
  DataPeopleBloc({required this.servicesData}) : super(DataPeopleInitial());
  final ServicesData servicesData;

  @override
  Stream<DataPeopleState> mapEventToState(DataPeopleEvent event,) async* {
    if (event is DataPeopleStart) {
      try {
        final checkDb = await servicesData.retrievePeople();
        if (checkDb.isEmpty) {
          final people = await servicesData.getPeople();
          if (people!.isNotEmpty) {
            final first = await servicesData.insertDataFromApi(people);
            if (first == 1) {
              final peoples = await servicesData.retrievePeople();
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
      } catch (e) {

      }
    }

    if (event is DataPeopleDetail) {
        yield DataPeopleDetailIndex(people: event.people);
    }

    if (event is DataPeopleUpdate) {
      PeopleModel data = PeopleModel(
          name: event.name,
          height: event.height,
          mass: event.mass,
          skin_color: event.skinColor,
          hair_color: event.hairColor,
          eye_color: event.eyeColor,
          birth_year: event.birthYear,
          gender: event.gender,
          homeworld: "");

      final update = await servicesData.updatePeople(data.toJson(), event.id);
      if (update != 0) {
        yield DataPeopleSukses(sukses: 'sukses');
      } else {
        yield DataPeopleFailure(error: 'Gagal Simpan');
      }
    }
  }
}
