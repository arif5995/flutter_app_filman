import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_filman/blocs/authenticate_bloc.dart';
import 'package:flutter_app_filman/bottom_navbar.dart';
import 'package:flutter_app_filman/pages/login_screen.dart';
import 'package:flutter_app_filman/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BlocProvider(
    create: (context) => AuthenticateBloc(servicesData: ServicesData())
      ..add(AuthEventAppStarted()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /// The future is part of the state of our widget. We should not call `initializeApp`
    /// directly inside [build].
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container(
                    color: Colors.white,
                    child: Center(
                      child: Text("Error Unknown!"),
                    ));
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return BlocBuilder<AuthenticateBloc, AuthenticateState>(
                  builder: (context, state) {
                    print('main state $state');
                    if (state is AuthtenticateLoaded) {
                      return BottomNavBar();
                    }
                    if (state is AuthenticateLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      );
                    }

                    return LoginScreen();
                  },
                );
              }
              return Container(
                  color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ));
            }));
  }
}
