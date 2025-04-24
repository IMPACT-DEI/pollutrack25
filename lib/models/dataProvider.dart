import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pollutrack25/models/heart_rate.dart';
import 'package:pollutrack25/models/pm25.dart';

class DataProvider extends ChangeNotifier{
  DateTime currentDate = DateTime.now();
  List<HR> heartRates = generateHRdata(DateTime.now());
  List<PM25> pm25=generatePM25(DateTime.now());
  double exposure = Random().nextDouble() * 100;
  String name = "User";
  String surname = "";

  

  void getDataOfDay(DateTime date) async{
    currentDate = date; // Update the current date
    exposure = Random().nextDouble() * 100; // Simulate exposure value
    heartRates = await getHeartRateData(date); // Simulate fetching heart rate data
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
  return generateHRdata(date);
}

Future<List<PM25>> getPM25Data(DateTime date) async {
  // Simulate fetching PM2.5 data from a database or API
  return generatePM25(date);
}
}





