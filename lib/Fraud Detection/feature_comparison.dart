import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class FeatureComparison extends StatelessWidget {
  final String title;
  final double userValue;
  final double datasetValue;
  final Color color;

  FeatureComparison({
    required this.title,
    required this.userValue,
    required this.datasetValue,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
            child: Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 300,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: _getMaxY(),
                barGroups: [
                  BarChartGroupData(x: 0, barRods: [
                    BarChartRodData(
                      toY: userValue,
                      color: color,
                      width: 20,
                    ),
                  ]),
                  BarChartGroupData(x: 1, barRods: [
                    BarChartRodData(
                      toY: datasetValue,
                      color: Colors.grey,
                      width: 20,
                    ),
                  ]),
                ],
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        String text = '';
                        switch (value.toInt()) {
                          case 0:
                            text = 'Your Value';
                            break;
                          case 1:
                            text = 'Dataset Avg';
                            break;
                        }
                        return Text(text);
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(value.toInt().toString());
                      },
                    ),
                  ),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(show: false),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Your Value: ${userValue.toStringAsFixed(2)}'),
                Text('Dataset Average: ${datasetValue.toStringAsFixed(2)}'),
              ],
            ),
          ),
          SizedBox(height: 20), // Adjust spacing as needed
        ],
      ),
    );
  }

  double _getMaxY() {
    return (userValue > datasetValue ? userValue : datasetValue) * 1.2;
  }
}
