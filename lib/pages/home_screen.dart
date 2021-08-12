import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_filman/blocs/data_people_bloc.dart';
import 'package:flutter_app_filman/entitis/people.dart';
import 'package:flutter_app_filman/pages/add_screen.dart';
import 'package:flutter_app_filman/pages/detail_screen.dart';
import 'package:flutter_app_filman/services/services.dart';
import 'package:flutter_app_filman/widget/showdialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _name = TextEditingController();
    bool _color = false;

    return BlocProvider(
        create: (context) =>
        DataPeopleBloc(servicesData: ServicesData())
          ..add(DataPeopleStart()),
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Get.to(AddScreen());
                },
                backgroundColor: Colors.blue,
              ),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: BlocBuilder<DataPeopleBloc, DataPeopleState>(
                    builder: (context, state) {
                      return Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            cursorColor: Colors.white,
                            controller: _name,
                            onChanged: (name) {
                              print('nama $name');
                              context
                                  .read<DataPeopleBloc>()
                                  .add(DataPeopleSearch(nama: name));
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                hintText: " Search...",
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.cancel),
                                  color: Colors.white,
                                  onPressed: () {
                                    _name.clear();
                                    context
                                        .read<DataPeopleBloc>()
                                        .add(DataPeopleStart());
                                  },
                                )),
                            style:
                            TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                actions: [

                ],
                bottom: TabBar(
                  tabs: [
                    Tab(
                      icon: Icon(Icons.list),
                    ),
                    Tab(
                      icon: Icon(Icons.grid_3x3),
                    )
                  ],
                ),
              ),
              body: BlocListener<DataPeopleBloc, DataPeopleState>(
                listener: (context, state) {
                  if (state is DataPeopleSukses) {
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //   content: Text(state.sukses),
                    //   duration: Duration(seconds: 1),
                    //   backgroundColor: Colors.green,
                    // ));
                    BotToast.showSimpleNotification(
                        title: state.sukses, duration: Duration(seconds: 10));
                    context.read<DataPeopleBloc>().add(DataPeopleStart());
                    // Get.offAll(BottomNavBar())
                  }
                },
                child: TabBarView(
                  children: [
                    BlocBuilder<DataPeopleBloc, DataPeopleState>(
                        builder: (context, state) {
                          DataPeopleState dataPeopleState = context
                              .watch<DataPeopleBloc>()
                              .state;
                          print('state home $state');
                          if (state is DataPeopleLoaded) {
                            return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: ListView.builder(
                                      itemCount: state.people.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Card(
                                          child: ListTile(
                                            onTap: () {
                                              BotToast.showLoading();
                                              Get.to(DetailScreen(),
                                                  arguments: state
                                                      .people[index]);
                                            },
                                            title: Text(
                                                state.people[index].name),
                                            subtitle: Text(
                                                '${state.people[index].favorite
                                                    .toString()} ${state
                                                    .people[index].gender}'),
                                            leading: IconButton(
                                              onPressed: () {
                                                context.read<DataPeopleBloc>()
                                                    .add(
                                                    DataPeopleFav(
                                                        fav: 1,
                                                        id: state
                                                            .people[index]
                                                            .id!));
                                              },
                                              color:
                                              state.people[index].favorite == 1
                                                  ? Colors.red
                                                  : Colors.grey,
                                              icon: Icon(Icons.favorite),
                                            ),
                                            trailing: IconButton(
                                              onPressed: () {
                                                showAlertDialogCustom(
                                                    context: context,
                                                    name: state.people[index]
                                                        .name,
                                                    cancel: () {
                                                      Get.back();
                                                    },
                                                    yess: () {
                                                      context.read<
                                                          DataPeopleBloc>().add(
                                                          DataPeopleDelete(
                                                              index: state
                                                                  .people[index]
                                                                  .id!));
                                                      Get.back();
                                                    });
                                              },
                                              color: Colors.grey,
                                              icon: Icon(Icons.delete),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 9, right: 8, left: 8),
                                  child: Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: FlutterToggleTab(
                                        width: 100,
                                        borderRadius: 15,
                                        initialIndex: 0,
                                        selectedTextStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                        unSelectedTextStyle: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                        labels: ["Ascending", "Descending"],
                                        icons: [
                                          Icons.arrow_downward,
                                          Icons.arrow_upward
                                        ],
                                        selectedLabelIndex: (index) {
                                          print("Selected Index $index");
                                          if (index == 0) {
                                            print("Asc $index");
                                            context
                                                .read<DataPeopleBloc>()
                                                .add(
                                                DataPeopleSort(sort: 'Asc'));
                                          } else {
                                            context
                                                .read<DataPeopleBloc>()
                                                .add(
                                                DataPeopleSort(sort: 'Desc'));
                                            print("Desc $index");
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
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
                        }),
                    BlocBuilder<DataPeopleBloc, DataPeopleState>(
                        builder: (context, state) {
                          if (state is DataPeopleLoaded) {
                            return _gridViewBuild(state.people, context);
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
                        })
                  ],
                ),
              )),
        ));
  }
}

Widget _gridViewBuild(List<People> pipels, context) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: MediaQuery
                .of(context)
                .size
                .width /
                (MediaQuery
                    .of(context)
                    .size
                    .height / 1.4),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: pipels.length,
        itemBuilder: (BuildContext context, index) {
          return InkWell(
              onTap: () {
                BotToast.showLoading();
                Get.to(DetailScreen(), arguments: pipels[index]);
              },
              child: Card(
                  child: _itemGrid(pipels[index].name, pipels[index].gender)));
        }),
  );
}

Widget _itemGrid(String nama, String gender) {
  final Widget image = Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        'assets/images/portfolio judul.jpg',
        fit: BoxFit.cover,
      ));

  return GridTile(
      footer: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(4))),
        clipBehavior: Clip.antiAlias,
        child: GridTileBar(
          backgroundColor: Colors.black45,
          title: Text(gender),
          subtitle: Text(nama),
        ),
      ),
      child: image);
}

class PeoplSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(onPressed: () {}, icon: Icon(Icons.clear))];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // final suggestionList = query.isEmpty?
    throw UnimplementedError();
  }
}
