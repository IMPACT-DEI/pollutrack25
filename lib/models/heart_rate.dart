
import 'package:intl/intl.dart';

class HR{
  final DateTime timestamp;
  final int value;

  HR({
    required this.timestamp,
    required this.value,
  });

  HR.fromJson(String date, Map<String, dynamic> json) :
      timestamp = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),
      value = json["value"];

/*
@override
  String toString() {
    return 'HR{timestamp: $timestamp, value: $value}';
  }
*/


}


/*
List<HR> generateHRdata(DateTime date) {
  Random random = Random();
  List<HR> hrData = [];

  int baseHeartRate = 70; 
  int minHeartRate = 50; 
  int maxHeartRate = 100; 
  double fluctuationFactor = 0.2; 

  for (int index = 0; index < 24; index++) {

    int fluctuation = (baseHeartRate * fluctuationFactor).round(); 
    int heartRate = baseHeartRate + random.nextInt(2 * fluctuation + 1) - fluctuation;
    heartRate = heartRate.clamp(minHeartRate, maxHeartRate);
    hrData.add(HR(timestamp: date.add(Duration(hours: index)), value: heartRate));
  }

  return hrData;

}
*/
