class People {
  final int? id;
  final String name;
  final String height;
  final String mass;
  final String skin_color;
  final String hair_color;
  final String eye_color;
  final String birth_year;
  final String gender;
  final String homeworld;

  People(
      {
        this.id,
        required this.name,
        required this.height,
        required this.mass,
        required this.skin_color,
        required this.hair_color,
        required this.eye_color,
        required this.birth_year,
        required this.gender,
        required this.homeworld});

  Map<String, Object?> toMap() {
    return {
      'id' : id,
      'name': name,
      'height': height,
      'mass': mass,
      'skin_color': skin_color,
      'hair_color': hair_color,
      'eye_color': eye_color,
      'birth_year': birth_year,
      'gender': gender,
      'homeworld': homeworld
    };
  }
}
