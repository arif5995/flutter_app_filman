import 'package:flutter/material.dart';
import 'package:flutter_app_filman/blocs/data_people_bloc.dart';
import 'package:flutter_app_filman/entitis/people.dart';
import 'package:flutter_app_filman/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailScreen extends StatefulWidget {
  final People people;
  const DetailScreen({Key? key, required this.people}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  bool _edit = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _massController = TextEditingController();
  TextEditingController _skinColorController = TextEditingController();
  TextEditingController _hairColorController = TextEditingController();
  TextEditingController _eyeColorController = TextEditingController();
  TextEditingController _birthYearController = TextEditingController();
  TextEditingController _genderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _nameController.text = widget.people.name;
      _heightController.text = widget.people.height;
      _massController.text = widget.people.mass;
      _skinColorController.text = widget.people.skin_color;
      _hairColorController.text = widget.people.hair_color;
      _eyeColorController.text = widget.people.eye_color;
      _birthYearController.text = widget.people.birth_year;
      _genderController.text = widget.people.gender;
    });
  }

  void _controller() {
    if (!_edit) {
      _nameController.text = widget.people.name;
      _heightController.text = widget.people.height;
      _massController.text = widget.people.mass;
      _skinColorController.text = widget.people.skin_color;
      _hairColorController.text = widget.people.hair_color;
      _eyeColorController.text = widget.people.eye_color;
      _birthYearController.text = widget.people.birth_year;
      _genderController.text = widget.people.gender;
    } else {
      _nameController.clear();
      _heightController.clear();
      _massController.clear();
      _skinColorController.clear();
      _eyeColorController.clear();
      _hairColorController.clear();
      _birthYearController.clear();
      _genderController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataPeopleBloc(servicesData: ServicesData()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detail People'),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _edit = !_edit;
                    _controller();
                  });
                },
                icon: Icon(Icons.edit))
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    // initialValue: widget.people.name,
                    controller: _nameController,
                    enabled: _edit,
                    decoration: InputDecoration(labelText: 'Nama'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    // initialValue: widget.people.height,
                    enabled: _edit,
                    controller: _heightController,
                    decoration: InputDecoration(labelText: 'Height'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    // initialValue: widget.people.mass,
                    enabled: _edit,
                    controller: _massController,
                    decoration: InputDecoration(labelText: 'Mass'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    // initialValue: widget.people.skin_color,
                    enabled: _edit,
                    controller: _skinColorController,
                    decoration:
                    InputDecoration(labelText: 'Skin Color'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    // initialValue: widget.people.hair_color,
                    enabled: _edit,
                    controller: _hairColorController,
                    decoration:
                    InputDecoration(labelText: 'Hair Color'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    // initialValue: widget.people.eye_color,
                    enabled: _edit,
                    controller: _eyeColorController,
                    decoration: InputDecoration(labelText: 'Eye Color'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    // initialValue: widget.people.birth_year,
                    enabled: _edit,
                    controller: _birthYearController,
                    decoration:
                    InputDecoration(labelText: 'Birth Year'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    // initialValue: widget.people.gender,
                    enabled: _edit,
                    controller: _genderController,
                    decoration: InputDecoration(labelText: 'Gender'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: _edit
                        ? () {
                      context.read<DataPeopleBloc>().add(
                          DataPeopleUpdate(
                              id: 0,
                              name: _nameController.text,
                              height: _hairColorController.text,
                              mass: _massController.text,
                              skinColor:
                              _skinColorController.text,
                              eyeColor: _eyeColorController.text,
                              hairColor:
                              _hairColorController.text,
                              birthYear:
                              _birthYearController.text,
                              gender: _genderController.text));
                    }
                        : null,
                    child: Text(
                      'Simpan',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
