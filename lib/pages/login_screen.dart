import 'package:flutter/material.dart';
import 'package:flutter_app_filman/blocs/authenticate_bloc.dart';
import 'package:flutter_app_filman/blocs/login_bloc.dart';
import 'package:flutter_app_filman/bottom_navbar.dart';
import 'package:flutter_app_filman/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(child: BlocBuilder<AuthenticateBloc, AuthenticateState>(
//         builder: (context, state) {
//           final authBloc = BlocProvider.of<AuthenticateBloc>(context);
//           if (state is AuthtenticateNotLoaded) {
//             return _AuthForm();
//           }
//           if (state is AuthtenticateFailure) {
//             // show error
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(state.error),
//                   FlatButton(
//                       onPressed: () {
//                         authBloc.add(AuthEventAppStarted());
//                       },
//                       child: Text('Retry'))
//                 ],
//               ),
//             );
//           }
//           return Center(
//             child: CircularProgressIndicator(
//               strokeWidth: 2,
//             ),
//           );
//         },
//       )),
//     );
//   }
// }

//  class _AuthForm extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final service = ServicesData();
//     final authBloc = BlocProvider.of<AuthenticateBloc>(context);
//
//     return Container(
//       child: BlocProvider(
//         create: (context) =>
//             LoginBloc(servicesData: service, authenticateBloc: authBloc),
//         child: BlocConsumer<LoginBloc, LoginState>(
//           listener: (context, state) {
//             if (state is LoginGoogleError) {
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 content: Text('${state.error}'),
//                 backgroundColor: Colors.red,
//                 duration: Duration(seconds: 1),
//               ));
//             }
//           },
//           builder: (context, state) {
//             if (state is LoginGoogleSuccess) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             return Container(
//               alignment: Alignment.center,
//               child: Center(
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   child: InkWell(
//                     onTap: () {
//                       context.read<LoginBloc>().add(LoginLoaded());
//                     },
//                     borderRadius: BorderRadius.circular(15),
//                     child: Container(
//                       width: 200,
//                       height: 50,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30)),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Image.asset(
//                             "assets/images/google.png",
//                             width: 30,
//                             height: 30,
//                           ),
//                           Text("Sign In with google")
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = ServicesData();
    // final authBloc = BlocProvider.of<AuthenticateBloc>(context,listen: false);
    return BlocProvider(
      create: (context) => LoginBloc(
          servicesData: service,),
      child: Scaffold(
        body: SafeArea(
            child: Container(
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginGoogleError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${state.error}'),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 1),
                ));
              }
              if (state is LoginGoogleSuccess) {
                // return Center(
                //   child: CircularProgressIndicator(),
                // );
                Get.to(BottomNavBar());
              }
            },
            builder: (context, state) {
              print('state login $state');
              return Container(
                alignment: Alignment.center,
                child: Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: InkWell(
                      onTap: () {
                        context.read<LoginBloc>().add(LoginLoaded());
                      },
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              "assets/images/google.png",
                              width: 30,
                              height: 30,
                            ),
                            Text("Sign In with google")
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )),
      ),
    );
  }
}
