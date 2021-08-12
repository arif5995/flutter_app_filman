import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_filman/blocs/data_people_bloc.dart';
import 'package:flutter_app_filman/pages/detail_screen.dart';
import 'package:flutter_app_filman/services/services.dart';
import 'package:flutter_app_filman/widget/showdialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class FavoritScreen extends StatelessWidget {
  const FavoritScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataPeopleBloc(servicesData: ServicesData())
        ..add(DataPeopleFavorite()),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Favorite'),
        ),
        body: BlocConsumer<DataPeopleBloc, DataPeopleState>(
          listener: (context, state) {
            if (state is DataPeopleSukses) {
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   content: Text(state.sukses),
              //   duration: Duration(seconds: 1),
              //   backgroundColor: Colors.green,
              // ));
              BotToast.showSimpleNotification(
                  title: state.sukses, duration: Duration(seconds: 10));
              context.read<DataPeopleBloc>().add(DataPeopleFavorite());
              // Get.offAll(BottomNavBar())
            }
          },
          builder: (context, state) {
            return BlocBuilder<DataPeopleBloc, DataPeopleState>(
                builder: (context, state) {
              DataPeopleState dataPeopleState =
                  context.watch<DataPeopleBloc>().state;
              print('state home $state');
              if (state is DataPeopleLoaded) {
                return ListView.builder(
                    itemCount: state.people.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            BotToast.showLoading();
                            Get.to(DetailScreen(),
                                arguments: state.people[index]);
                          },
                          title: Text(state.people[index].name),
                          subtitle: Text(
                              '${state.people[index].favorite.toString()} ${state.people[index].gender}'),
                          leading: Icon(
                            Icons.favorite,
                            color: state.people[index].favorite == 1
                                ? Colors.red
                                : Colors.grey,
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              showAlertDialogCustom(
                                  context: context,
                                  name: state.people[index].name,
                                  cancel: () {
                                    Get.back();
                                  },
                                  yess: () {
                                    context.read<DataPeopleBloc>().add(
                                        DataPeopleDelFav(
                                            index: state.people[index].id!));
                                    Get.back();
                                  });
                            },
                            color: Colors.grey,
                            icon: Icon(Icons.delete),
                          ),
                        ),
                      );
                    });
              }
              if (state is DataPeopleFailure) {
                return Center(
                  child: Text(state.error),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
