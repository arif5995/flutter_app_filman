import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_filman/blocs/data_people_bloc.dart';
import 'package:flutter_app_filman/bottom_navbar.dart';
import 'package:flutter_app_filman/entitis/people.dart';
import 'package:flutter_app_filman/pages/home_screen.dart';
import 'package:flutter_app_filman/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class DetailScreen extends StatefulWidget {
  // final People people;

  const DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final listPeople = Get.arguments as People;
  bool _edit = false;
  bool pressAttention1 = false;
  bool get pressAttention {
      if (listPeople.favorite == 0)
        return false;
      return true;
  }
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
    BotToast.closeAllLoading();
    print('boool $pressAttention');

    _nameController.text = listPeople.name;
    _heightController.text = listPeople.height;
    _massController.text = listPeople.mass;
    _skinColorController.text = listPeople.skin_color;
    _hairColorController.text = listPeople.hair_color;
    _eyeColorController.text = listPeople.eye_color;
    _birthYearController.text = listPeople.birth_year;
    _genderController.text = listPeople.gender;
  }

  void _controller() {
    if (!_edit) {
      _nameController.text = listPeople.name;
      _heightController.text = listPeople.height;
      _massController.text = listPeople.mass;
      _skinColorController.text = listPeople.skin_color;
      _hairColorController.text = listPeople.hair_color;
      _eyeColorController.text = listPeople.eye_color;
      _birthYearController.text = listPeople.birth_year;
      _genderController.text = listPeople.gender;
    } else {
      // _nameController.;
      // _heightController.clear();
      // _massController.clear();
      // _skinColorController.clear();
      // _eyeColorController.clear();
      // _hairColorController.clear();
      // _birthYearController.clear();
      // _genderController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final data1 = ModalRoute.of(context)!.settings.arguments as
    // People;
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
                  icon: Icon(Icons.edit)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.favorite,
                  color: listPeople.favorite == 1 ? Colors.red : Colors.grey,
                ),
              )
            ],
          ),
          body: BlocConsumer<DataPeopleBloc, DataPeopleState>(
            listener: (context, state) {
              if (state is DataPeopleSukses) {
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //   content: Text(state.sukses),
                //   duration: Duration(seconds: 1),
                //   backgroundColor: Colors.green,
                // ));
                Get.to(BottomNavBar());
              }
              if (state is DataPeopleFailure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.error),
                  duration: Duration(seconds: 1),
                  backgroundColor: Colors.green,
                ));
              }
            },
            builder: (context, state) {
              return BlocBuilder<DataPeopleBloc, DataPeopleState>(
                  builder: (context, state) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text('favorit ${listPeople.favorite}'),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          autofocus: true,
                          focusNode: FocusNode(),
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
                          decoration: InputDecoration(labelText: 'Skin Color'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          // initialValue: widget.people.hair_color,
                          enabled: _edit,
                          controller: _hairColorController,
                          decoration: InputDecoration(labelText: 'Hair Color'),
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
                          decoration: InputDecoration(labelText: 'Birth Year'),
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
                                  print('name ${_nameController.text}');
                                  context.read<DataPeopleBloc>().add(
                                      DataPeopleUpdate(
                                          id: listPeople.id!,
                                          name: _nameController.text,
                                          height: _heightController.text,
                                          mass: _massController.text,
                                          skinColor: _skinColorController.text,
                                          eyeColor: _eyeColorController.text,
                                          hairColor: _hairColorController.text,
                                          birthYear: _birthYearController.text,
                                          gender: _genderController.text,
                                          favorite: listPeople.favorite!,
                                      ));
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
                );
              });
            },
          )),
    );
  }
}
