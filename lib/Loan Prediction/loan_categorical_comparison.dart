import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CategoricalComparison extends StatelessWidget {
  final String title;
  final List<Person> dummyData;
  final Person userInput;
  final String feature;

  CategoricalComparison({
    required this.title,
    required this.dummyData,
    required this.userInput,
    required this.feature,
  });

  @override
  Widget build(BuildContext context) {
    final userCategory = getFeatureValue(userInput, feature);
    final categoryCounts = _getCategoryCounts();
    final maxCount = _getMaxCount(categoryCounts);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildComparisonItem('Your Value', userCategory),
              _buildComparisonItem('Feature', getFeatureName(feature)),
            ],
          ),
          SizedBox(height: 20),
          Container(
            height: 300,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxCount.toDouble(),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const titles = ['Success', 'Denied'];
                        return Text(titles[value.toInt()]);
                      },
                      reservedSize: 30,
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
                borderData: FlBorderData(show: false),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: categoryCounts['Success']!.toDouble(),
                        color: Colors.green,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: categoryCounts['Denied']!.toDouble(),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ],
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        rod.toY.round().toString(),
                        TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildComparisonItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Map<String, int> _getCategoryCounts() {
    int successCount = 0;
    int deniedCount = 0;

    for (var person in dummyData) {
      if (getFeatureValue(person, feature) ==
          getFeatureValue(userInput, feature)) {
        if (person.status == 'Success') {
          successCount++;
        } else if (person.status == 'Denied') {
          deniedCount++;
        }
      }
    }

    return {'Success': successCount, 'Denied': deniedCount};
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem(Colors.green, 'Success'),
        SizedBox(width: 20),
        _legendItem(Colors.red, 'Denied'),
      ],
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        SizedBox(width: 4),
        Text(label),
      ],
    );
  }

  String getFeatureValue(Person person, String feature) {
    switch (feature) {
      case 'MaritalStatus':
        return person.maritalStatus;
      case 'HouseOwnership':
        return person.houseOwnership;
      case 'CarOwnership':
        return person.carOwnership;
      default:
        return 'Unknown';
    }
  }

  String getFeatureName(String feature) {
    switch (feature) {
      case 'MaritalStatus':
        return 'Marital Status';
      case 'HouseOwnership':
        return 'House Ownership';
      case 'CarOwnership':
        return 'Car Ownership';
      default:
        return 'Unknown';
    }
  }

  int _getMaxCount(Map<String, int> counts) {
    return counts.values.reduce((max, value) => max > value ? max : value);
  }
}

class Person {
  final String maritalStatus;
  final String houseOwnership;
  final String carOwnership;
  final String status;

  Person({
    required this.maritalStatus,
    required this.houseOwnership,
    required this.carOwnership,
    required this.status,
  });
}
