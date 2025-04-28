import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pollutrack25/models/heart_rate.dart';
import 'package:pollutrack25/models/pm25.dart';

class DataProvider extends ChangeNotifier {
  DateTime currentDate = DateTime.now();
  List<HR> heartRates = [];
  List<PM25> pm25 = [];
  double exposure = -1;
  String name = "User";
  String surname = "";

  DataProvider() {
    // upon creation we get the data of today
    getDataOfDay(currentDate);
  }

  // if data is loading we should provide the user with some feedback in UI
  bool get loading {
    return heartRates.isEmpty || pm25.isEmpty || exposure < 0;
  }

  void getDataOfDay(DateTime date) async {
    // reset the values to show loading animation
    heartRates = [];
    pm25 = [];
    exposure = -1;
    notifyListeners();

    currentDate = date; // Update the current date
    exposure = Random().nextDouble() * 100; // Simulate exposure value
    heartRates = await getHeartRateData(
      date,
    ); // Simulate fetching heart rate data
    pm25 = await getPM25Data(date); // Simulate fetching PM2.5 data
    print('New data fetched for date: $date');
    notifyListeners();
  }

  void setUserName(String name, String surname) {
    this.name = name;
    this.surname = surname;
    notifyListeners();
  }

  Future<List<HR>> getHeartRateData(DateTime date) async {
    // Simulate fetching heart rate data from a database or API
    return Future.delayed(Duration(seconds: 1), () => generateHRdata(date));
  }

  Future<List<PM25>> getPM25Data(DateTime date) async {
    // Simulate fetching PM2.5 data from a database or API
    return Future.delayed(Duration(seconds: 1), () => generatePM25(date));
  }
}
