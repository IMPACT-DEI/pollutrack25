
import 'package:flutter/material.dart';
import 'package:pollutrack25/models/heart_rate.dart';
import 'package:pollutrack25/models/pm25.dart';
import 'package:pollutrack25/services/csvData.dart';
import 'package:pollutrack25/utils/algorithm.dart';
import 'package:pollutrack25/services/impact.dart';

class DataProvider extends ChangeNotifier {
  DateTime currentDate = DateTime.now();
  List<HR> heartRates = [];
  List<PM25> pm25 = [];
  double exposure = -1;
  String name = "User";
  String surname = "";

  final Impact impact = Impact();
  final Algorithmms algorithm = Algorithmms(1);
  final Csvdata csvdata = Csvdata();
  final Csvdata csvData = Csvdata();

  DataProvider() {
    // upon creation we get the data of today
    getDataOfDay(currentDate);
  }

  // if data is loading we should provide the user with some feedback in UI
  bool get loading {
    return exposure < 0;
  }

  void getDataOfDay(DateTime date) async {
    // reset the values to show loading animation
    _loading();
    currentDate = date; // Update the current date
    // heartRates = await getHeartRateData(date);
    heartRates = await impact.getHRData(date);

    List<Map<String, dynamic>> csvData = await csvdata.getCsvDataByDate(
      currentDate,
    );
    List<double> pmcsv = csvdata.getPM(csvData, 'AirPredict-Padova-Mortise A');
    List<DateTime> timeStamp = csvdata.getTimeStamp(csvData, 'DateTime');

    pm25 = List.generate(
      timeStamp.length,
      (index) => PM25(
        timestamp: timeStamp[index].copyWith(
          day: currentDate.day,
          month: currentDate.month,
          year: currentDate.year,
        ),
        value: pmcsv[index],
      ),
    );
    print('PM25: ${pm25.length}');

    print('New data fetched for date: $date');
    exposure = _calculateExposure(heartRates, pm25);

    notifyListeners();
  }

  void _loading() {
    heartRates = [];
    pm25 = [];
    exposure = -1;
    notifyListeners();
  }

  void setUserName(String name, String surname) {
    this.name = name;
    this.surname = surname;
    notifyListeners();
  }

  Future<List<PM25>> getPM25Data(DateTime date) async {
    // Simulate fetching PM2.5 data from a database or API
    return Future.delayed(Duration(seconds: 1), () => generatePM25(date));
  }

  // method that implements the state of the art formulas
  double _calculateExposure(List<HR> hr, List<PM25> pm25) {
    var vent = algorithm.getVentilationRate(hr);

    var inalhation = algorithm.getInhalationRate(vent, pm25);
    return inalhation.isNotEmpty
        ? inalhation.map((e) => e.value).reduce((a, b) => a + b) *
            100 /
            4384.8 // value for 70bpm at pm2.5 of 25 (EU threshold)
        : 0;
  }
}
