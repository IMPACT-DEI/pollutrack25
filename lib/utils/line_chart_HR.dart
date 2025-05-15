import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pollutrack25/models/heart_rate.dart';
import 'package:graphic/graphic.dart';

class LineChartHr extends StatelessWidget{
  const LineChartHr({
    Key? key,
    required this.hrData,}) : super(key:key);

  final List<HR> hrData;

   @override
   Widget build(BuildContext context) {
    final chartData = hrData
        .map((e) => {
              'time': e.timestamp,
              'hr': e.value,
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
        'hr': Variable<Map<String,dynamic>, num>(
          accessor: (map) => map['hr'] as num,
          scale: LinearScale(
            min: 40,
            max: 180,
          ),
        ),
      },
      marks: <Mark<Shape>>[
        LineMark(
          position: Varset('time') * Varset('hr'),
          shape: ShapeEncode(value: BasicLineShape(smooth: false)),
          size: SizeEncode(value: 2),
          color: ColorEncode(value: const Color(0xFF326F5E)),),
      ],
      axes: [
        Defaults.horizontalAxis,
        Defaults.verticalAxis,
      ],
      selections: {'tap': PointSelection(dim: Dim.x)},
    );
  }
}
