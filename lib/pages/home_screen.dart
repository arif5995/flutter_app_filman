import 'package:flutter/material.dart';
import 'package:flutter_app_filman/blocs/data_people_bloc.dart';
import 'package:flutter_app_filman/entitis/people.dart';
import 'package:flutter_app_filman/pages/detail_screen.dart';
import 'package:flutter_app_filman/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      DataPeopleBloc(servicesData: ServicesData())
        ..add(DataPeopleStart()),
      child: Scaffold(
          appBar: AppBar(
            title: Text('Beranda'),
          ),
          body: SafeArea(
            child: BlocListener<DataPeopleBloc, DataPeopleState>(
              listener: (context, state) {
                // if (state is DataPeopleDetailIndex) {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) =>
                //               DetailScreen()));
                // }
              },
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        height: 400,
                        child: BlocBuilder<DataPeopleBloc, DataPeopleState>(
                          builder: (context, state) {
                            print('home $state');
                            if (state is DataPeopleLoaded) {
                              return ListView.builder(
                                  itemCount: state.people.length,
                                  itemBuilder: (BuildContext context,
                                      int index) {
                                    return Card(
                                      child: ListTile(
                                        onTap: () {
                                          // context.read<DataPeopleBloc>().add(
                                          //     DataPeopleDetail(
                                          //         people: state.people[index]));
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailScreen()));

                                        },
                                        title: Text(state.people[index].name),
                                        subtitle:
                                        Text(state.people[index].gender),
                                        leading: IconButton(
                                          onPressed: () {},
                                          color: Colors.grey,
                                          icon: Icon(Icons.favorite),
                                        ),
                                        trailing: IconButton(
                                          onPressed: () {},
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
                          },
                        ),
                      ),
                      Container(
                        height: 300,
                        child: BlocBuilder<DataPeopleBloc, DataPeopleState>(
                          builder: (context, state) {
                            if (state is DataPeopleLoaded) {
                              return _gridViewBuild(state.people);
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
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

Widget _gridViewBuild(List<People> pipels) {
  return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20
      ),
      itemCount: pipels.length,
      itemBuilder: (BuildContext context, index) {
        return Container(
          alignment: Alignment.center,
          child: Text(pipels[index].name),
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15)),
        );
      });
}

Widget _gridView() {
  return GridView.count(
    crossAxisCount: 2,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    scrollDirection: Axis.vertical,
    padding: EdgeInsets.all(8),
    shrinkWrap: true,
    childAspectRatio: 1,
    children: [
      ElevatedButton(onPressed: () {}, child: Text('John Wik')),
      ElevatedButton(onPressed: () {}, child: Text('John Wik')),
      ElevatedButton(onPressed: () {}, child: Text('John Wik')),
      ElevatedButton(onPressed: () {}, child: Text('John Wik')),
      ElevatedButton(onPressed: () {}, child: Text('John Wik'))
    ],
  );
}

Widget _itemGrid() {
  final Widget image = Material(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    clipBehavior: Clip.antiAlias,
    child: Image.asset(
      "assets/images/user.png",
      fit: BoxFit.cover,
    ),
  );

  return GridTile(
      footer: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(4))),
        clipBehavior: Clip.antiAlias,
        child: GridTileBar(
          backgroundColor: Colors.black45,
          title: Text('Titile'),
          subtitle: Text('Subtitle'),
        ),
      ),
      child: image);
}
