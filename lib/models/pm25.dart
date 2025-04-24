import 'dart:math';

class PM25{
  final DateTime timestamp;
  final double value;

  PM25({
    required this.timestamp,
    required this.value,
  });
}

List<PM25> generatePM25(DateTime date) {
  Random random = Random();
  List<PM25> pm25Data = [];

  double basePm25 = 10.0; 
  double fluctuationFactor = 0.3; 
  double minPm25 = 0.0; 
  double maxPm25 = 200.0; 

  for (int index = 0; index < 24; index++) {
  
    double fluctuation = basePm25 * fluctuationFactor;
    double pm25Value = basePm25 + (random.nextDouble() * 2 * fluctuation - fluctuation);
    pm25Value = pm25Value.clamp(minPm25, maxPm25);
    pm25Data.add(PM25(timestamp: date.add(Duration(hours: index)), value: pm25Value));
  }

  return pm25Data;
}