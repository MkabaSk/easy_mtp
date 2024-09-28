/*
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Définition de la liste pieData
    final List<_PieData> pieData = [
      _PieData('Person 1', 35, '35%'),
      _PieData('Person 2', 28, '28%'),
      _PieData('Person 3', 34, '34%'),
      _PieData('Person 4', 32, '32%'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Test SfCircularChart'),
      ),
      body: Center(
        child: SfCircularChart(
          title: ChartTitle(text: 'Sales by sales person'),
          legend: Legend(isVisible: true),
          series: <PieSeries<_PieData, String>>[
            PieSeries<_PieData, String>(
              explode: true,
              explodeIndex: 0,
              dataSource: pieData,
              xValueMapper: (_PieData data, _) => data.xData,
              yValueMapper: (_PieData data, _) => data.yData,
              dataLabelMapper: (_PieData data, _) => data.text,
              dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
          ],
        ),
      ),
    );
  }
}

class _PieData {
  _PieData(this.xData, this.yData, [this.text]);
  final String xData;
  final num yData;
  String? text;
}
*/
