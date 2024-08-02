import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class FeatureComparisonLineChart extends StatelessWidget {
  final String title;
  final double userValue;
  final double datasetValue;
  final Color color;

  FeatureComparisonLineChart({
    required this.title,
    required this.userValue,
    required this.datasetValue,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: 1,
              minY: 0,
              maxY: _getMaxY(),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
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
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                _createLineChartBarData([userValue], color, 'User'),
                _createLineChartBarData(
                    [datasetValue], Colors.grey, 'Dataset Avg'),
              ],
              extraLinesData: ExtraLinesData(
                horizontalLines: [
                  HorizontalLine(
                    y: userValue,
                    color: color,
                    strokeWidth: 2,
                    label: HorizontalLineLabel(
                      show: true,
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.only(right: 5, top: 5),
                      style: const TextStyle(color: Colors.black),
                      labelResolver: (line) =>
                          'User: ${userValue.toStringAsFixed(2)}',
                    ),
                  ),
                  HorizontalLine(
                    y: datasetValue,
                    color: Colors.grey,
                    strokeWidth: 2,
                    label: HorizontalLineLabel(
                      show: true,
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.only(right: 5, top: 5),
                      style: const TextStyle(color: Colors.black),
                      labelResolver: (line) =>
                          'Dataset Avg: ${datasetValue.toStringAsFixed(2)}',
                    ),
                  ),
                ],
              ),
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                    return touchedBarSpots.map((barSpot) {
                      final flSpot = barSpot;
                      return LineTooltipItem(
                        '${flSpot.y}',
                        const TextStyle(color: Colors.white),
                      );
                    }).toList();
                  },
                ),
              ),
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
    );
  }

  double _getMaxY() {
    return (userValue > datasetValue ? userValue : datasetValue) * 1.2;
  }

  LineChartBarData _createLineChartBarData(
      List<double> values, Color color, String label) {
    return LineChartBarData(
      spots: values.asMap().entries.map((entry) {
        double y = entry.value;
        return FlSpot(entry.key.toDouble(), y);
      }).toList(),
      isCurved: true,
      color: color,
      dotData: FlDotData(show: true),
      belowBarData: BarAreaData(show: false),
    );
  }
}
