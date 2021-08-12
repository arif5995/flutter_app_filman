import 'package:flutter/material.dart';
import 'package:flutter_app_filman/blocs/data_people_bloc.dart';
import 'package:flutter_app_filman/bottom_navbar.dart';
import 'package:flutter_app_filman/pages/home_screen.dart';
import 'package:flutter_app_filman/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _massController = TextEditingController();
  TextEditingController _skinColorController = TextEditingController();
  TextEditingController _hairColorController = TextEditingController();
  TextEditingController _eyeColorController = TextEditingController();
  TextEditingController _birthYearController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  bool pressAttention  = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataPeopleBloc(servicesData: ServicesData()),
      child: Scaffold(
          appBar: AppBar(
            title: Text('Detail People'),
            actions: [
              // IconButton(
              //     onPressed: () {
              //       setState(() {
              //
              //         pressAttention = !pressAttention;
              //         print('favorit $pressAttention');
              //       });
              //     },
              //     icon: Icon(Icons.favorite, color: pressAttention ? Colors.red : Colors.grey,))
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
                            TextFormField(
                              keyboardType: TextInputType.name,
                              autofocus: true,
                              focusNode: FocusNode(),
                              controller: _nameController,
                              decoration: InputDecoration(labelText: 'Nama'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              controller: _heightController,
                              decoration: InputDecoration(labelText: 'Height'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              controller: _massController,
                              decoration: InputDecoration(labelText: 'Mass'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              controller: _skinColorController,
                              decoration:
                              InputDecoration(labelText: 'Skin Color'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              controller: _hairColorController,
                              decoration:
                              InputDecoration(labelText: 'Hair Color'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              controller: _eyeColorController,
                              decoration: InputDecoration(
                                  labelText: 'Eye Color'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              controller: _birthYearController,
                              decoration:
                              InputDecoration(labelText: 'Birth Year'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              controller: _genderController,
                              decoration: InputDecoration(labelText: 'Gender'),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                print('name ${_nameController.text}');
                                context.read<DataPeopleBloc>().add(
                                    DataPeopleInsert(
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
                                        gender: _genderController.text,
                                    ));
                              },
                              child: Text(
                                'Simpan',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    );

                  }
              );
            },
          )
      ),
    );
  }
}
