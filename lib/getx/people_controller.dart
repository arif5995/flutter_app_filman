import 'dart:async';

import 'package:get/get.dart';

class PeopleController extends GetxController{
  var peopleList = [].obs;

  @override
  void onInit() {
    peopleList();
    Timer.periodic(Duration(minutes: 5), (timer) => peopleList());
    super.onInit();
  }
}