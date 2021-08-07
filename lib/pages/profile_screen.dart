import 'package:flutter/material.dart';
import 'package:flutter_app_filman/blocs/authenticate_bloc.dart';
import 'package:flutter_app_filman/blocs/authenticate_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticateBloc, AuthenticateState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text('Profil'),
            actions: [
              GestureDetector(
                onTap: () {
                  context.read<AuthenticateBloc>().add(SignOutLoaded());
                },
                child: Icon(Icons.logout),
              ),
              SizedBox(width: 8),
            ],
          ),
          body: Column(
            children: [
              BlocBuilder<AuthenticateBloc, AuthenticateState>(
                  builder: (context, state) {
                print('Auth $state');
                if (state is AuthtenticateLoaded) {
                  return Container(
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
                          backgroundImage: NetworkImage(state.user.photoURL!),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8, top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hi, ',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      state.user.displayName ??
                                          "Tidak Ada Nama",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    )
                                  ],
                                ),
                                Text(
                                  state.user.email ?? "Tidak Ada Email",
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
                  );
                }
                return Container(
                  color: Colors.blue,
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
