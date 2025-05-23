import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Csvdata {
  getCsvData() async {
    String csvString = await rootBundle.loadString(
      'assets/us-epa-pm25-aqi.csv',
    );
    List<List<dynamic>> csvData = const CsvToListConverter(
      fieldDelimiter: ';',
      eol: '\n',
    ).convert(csvString);

    List<String> headers = List<String>.from(csvData[0]);

    List<Map<String, dynamic>> csvDataMap = [];
    for (var i = 1; i < csvData.length; i++) {
      Map<String, dynamic> row = {};

      for (var j = 0; j < headers.length; j++) {
        String columnName = headers[j];
        String value = csvData[i][j].toString().trim();

        switch (columnName) {
          case 'DateTime':
            row[columnName] = DateFormat('yyyy-MM-dd HH:mm:ss').parse(value);
            break;
          case 'AirPredict-Padova-Mortise A':
            row[columnName] = double.tryParse(value);
            break;
          case 'AirPredict-Padova-Mortise B':
            row[columnName] = double.tryParse(value);
            break;
        }
      }
      csvDataMap.add(row);
    } // for

    //await saveCsvData(csvDataMap);
    return csvDataMap;
  }

  Future<List<Map<String, dynamic>>> getCsvDataByDate(DateTime dt) async {
    List<Map<String, dynamic>> csvDataMap = await getCsvData();

    var date = dt.copyWith(day: dt.day % 4 + 7, month: 2, year: 2025);
    List<Map<String, dynamic>> filteredData =
        csvDataMap.where((row) {
          DateTime rowDate = row['DateTime'];
          return rowDate.year == date.year &&
              rowDate.month == date.month &&
              rowDate.day == date.day;
        }).toList();

    print(
      "Dati filtrati per il giorno ${date.toString()}: ${filteredData.length} righe trovate.",
    );
    return filteredData;
  }

  List<DateTime> getTimeStamp(
    List<Map<String, dynamic>> csvData,
    String columnName,
  ) {
    List<DateTime> values = [];
    for (var row in csvData) {
      var value = row[columnName];
      if (value != null && value is DateTime) {
        values.add(value);
      }
    }
    return values;
  }

  List<double> getPM(List<Map<String, dynamic>> csvData, String columnName) {
    List<double> values = [];
    for (var row in csvData) {
      var value = row[columnName];
      if (value != null && value is num) {
        values.add(value.toDouble());
      }
    }
    return values;
  }
}
