import 'package:flutter_app_filman/entitis/people.dart';
import 'package:json_annotation/json_annotation.dart';

part 'people_model.g.dart';

@JsonSerializable()
class PeopleModel extends People {
  PeopleModel(
      {id,
      required name,
      required height,
      required mass,
      required skin_color,
      required hair_color,
      required eye_color,
      required birth_year,
      required gender,
      required homeworld,
      favorite})
      : super(
            id: id,
            name: name,
            mass: mass,
            height: height,
            skin_color: skin_color,
            hair_color: hair_color,
            eye_color: eye_color,
            birth_year: birth_year,
            gender: gender,
            homeworld: homeworld,
            favorite: favorite);

  factory PeopleModel.fromJson(Map<String, dynamic> json) =>
      _$PeopleModelFromJson(json);

  Map<String, dynamic> toJson() => _$PeopleModelToJson(this);
}
