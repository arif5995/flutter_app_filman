// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeopleModel _$PeopleModelFromJson(Map<String, dynamic> json) {
  return PeopleModel(
    name: json['name'],
    height: json['height'],
    mass: json['mass'],
    skin_color: json['skin_color'],
    hair_color: json['hair_color'],
    eye_color: json['eye_color'],
    birth_year: json['birth_year'],
    gender: json['gender'],
    homeworld: json['homeworld'],
  );
}

Map<String, dynamic> _$PeopleModelToJson(PeopleModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'height': instance.height,
      'mass': instance.mass,
      'skin_color': instance.skin_color,
      'hair_color': instance.hair_color,
      'eye_color': instance.eye_color,
      'birth_year': instance.birth_year,
      'gender': instance.gender,
      'homeworld': instance.homeworld,
    };
