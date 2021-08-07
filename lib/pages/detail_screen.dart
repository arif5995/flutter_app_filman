import 'package:flutter/material.dart';
import 'package:flutter_app_filman/blocs/data_people_bloc.dart';
import 'package:flutter_app_filman/entitis/people.dart';
import 'package:flutter_app_filman/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailScreen extends StatefulWidget {
  // final People people;
  const DetailScreen({Key? key}) : super(key: key);

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
                    _edit = true;
                  });
                },
                icon: Icon(Icons.edit))
          ],
        ),
        body: BlocConsumer<DataPeopleBloc, DataPeopleState>(
          listener: (context, state) {
            if (state is DataPeopleSukses) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.sukses),
                duration: const Duration(seconds: 1),
              ));
            }
            if (state is DataPeopleFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.error),
                duration: const Duration(seconds: 1),
              ));
            }
          },
          builder: (context, state) {
            return BlocBuilder<DataPeopleBloc, DataPeopleState>(
              builder: (context, state) {
                if (state is DataPeopleDetailIndex) {
                  return SafeArea(
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
                                        id: state.people.id!,
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
                  );
                }
                return Container();
              },
            );
          },
        ),
      ),
    );
  }
}
