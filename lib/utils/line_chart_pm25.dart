import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pollutrack25/models/pm25.dart';
import 'package:graphic/graphic.dart';

class LineChartPm extends StatelessWidget{
  const LineChartPm({
    Key? key,
    required this.pmData,}) : super(key:key);

  final List<PM25> pmData;

   @override
   Widget build(BuildContext context) {
    final chartData = pmData
        .map((e) => {
              'time': e.timestamp,
              'pm25': e.value,
            })
        .toList();

    return Chart(
      data: chartData,
      variables: {
        'time': Variable<Map<String,dynamic>, DateTime>(
          accessor: (map) => map['time'] as DateTime,
          scale: TimeScale(
            formatter: (time) => DateFormat.Hm().format(time),
          ),
        ),
        'pm25': Variable<Map<String,dynamic>, num>(
          accessor: (map) => map['pm25'] as num,
          scale: LinearScale(
            min: 0,
            max: 300,
          ),
        ),
      },
      marks: <Mark<Shape>>[
        LineMark(
          position: Varset('time') * Varset('pm25'),
          shape: ShapeEncode(value: BasicLineShape(smooth: false)),
          size: SizeEncode(value: 2),
          color: ColorEncode(value: const Color(0xFF326F5E)),)
      ],
      axes: [
        Defaults.horizontalAxis,
        Defaults.verticalAxis,
      ],
      selections: {'tap': PointSelection(dim: Dim.x)},
    );
  }
}