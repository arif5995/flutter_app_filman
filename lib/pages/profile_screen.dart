import 'package:flutter/material.dart';
import 'package:flutter_app_filman/blocs/authenticate_bloc.dart';
import 'package:flutter_app_filman/blocs/login_bloc.dart';
import 'package:flutter_app_filman/blocs/login_bloc.dart';
import 'package:flutter_app_filman/blocs/user_bloc.dart';
import 'package:flutter_app_filman/pages/login_screen.dart';
import 'package:flutter_app_filman/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
              UserBloc(servicesData: ServicesData())
                ..add(UserCurrent())),
          BlocProvider(
              create: (context) =>
                  AuthenticateBloc(servicesData: ServicesData()))
        ],
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text('Profil'),
            actions: [
              BlocConsumer<AuthenticateBloc, AuthenticateState>(
                listener: (context, state) {
                  if (state is AuthtenticateNotLoaded) {
                    // context.read<AuthenticateBloc>().add(AuthEventAppStarted());
                    Get.to(LoginScreen());
                    print('Log OUTT');
                  }
                },
                builder: (context, state) {
                  return BlocBuilder<AuthenticateBloc, AuthenticateState>(
                    builder: (context, state) {
                      print('profil $state');
                      return GestureDetector(
                        onTap: () {
                          context.read<AuthenticateBloc>().add(SignOutLoaded());
                        },
                        child: Icon(Icons.logout),
                      );
                    },
                  );
                },
              ),
              SizedBox(width: 8),
            ],
          ),
          body: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is ResultUser) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 1.0,
                                spreadRadius: 0.0,
                                offset: Offset(1.0, 1.0))
                          ],
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0))),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                                state.photo ?? 'Tidak Ada Foto'),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 8, top: 20),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hi, ',
                                        style: TextStyle(
                                            color: Colors.white),
                                      ),
                                      Text(
                                        state.name ??
                                            "Tidak Ada Nama",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15),
                                      )
                                    ],
                                  ),
                                  Text(
                                    state.email ?? "Tidak Ada Email",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }return Container();
            },
          ),
        ));
  }
}
