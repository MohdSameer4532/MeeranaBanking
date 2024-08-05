import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'loanperson.dart';

class CategoricalComparisonGraph extends StatelessWidget {
  final List<Person> dummyData;
  final Person userInput;
  final String feature;

  CategoricalComparisonGraph({
    required this.dummyData,
    required this.userInput,
    required this.feature,
  });

  @override
  Widget build(BuildContext context) {
    final String userCategory = _getFeatureValue(userInput);
    final Map<String, int> categoryCounts = _getCategoryCounts(userCategory);

    return Column(
      children: [
        Expanded(
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: _getMaxCount(categoryCounts),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final labels = categoryCounts.keys.toList();
                      if (value.toInt() < labels.length) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            labels[value.toInt()],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        );
                      }
                      return Text('');
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
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              barGroups: categoryCounts.entries.map((entry) {
                return BarChartGroupData(
                  x: categoryCounts.keys.toList().indexOf(entry.key),
                  barRods: [
                    BarChartRodData(
                      toY: entry.value.toDouble(),
                      color: entry.key == userCategory ? Colors.green : Colors.blue,
                      width: 60,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                );
              }).toList(),
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final category = categoryCounts.keys.toList()[group.x];
                    final count = categoryCounts[category]!;
                    return BarTooltipItem(
                      '$category: $count',
                      TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        _buildLegend(userCategory),
      ],
    );
  }

  Map<String, int> _getCategoryCounts(String userCategory) {
    final Map<String, int> counts = {};
    for (final person in dummyData) {
      final category = _getFeatureValue(person);
      counts[category] = (counts[category] ?? 0) + 1;
    }
    return counts;
  }

  Widget _buildLegend(String userCategory) {
    return Column(
      children: [
        Text(
          'Comparison for ${_getFeatureName()}: $userCategory',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _legendItem(Colors.green, 'User Category'),
            SizedBox(width: 20),
            _legendItem(Colors.blue, 'Other Categories'),
          ],
        ),
      ],
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
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

  String _getFeatureValue(Person person) {
    switch (feature) {
      case 'maritalStatus':
        return person.maritalStatus;
      case 'houseOwnership':
        return person.houseOwnership;
      case 'carOwnership':
        return person.carOwnership;
      case 'profession':
        return person.profession;
      default:
        return '';
    }
  }

  String _getFeatureName() {
    switch (feature) {
      case 'maritalStatus':
        return 'Marital Status';
      case 'houseOwnership':
        return 'House Ownership';
      case 'carOwnership':
        return 'Car Ownership';
      case 'profession':
        return 'Profession';
      default:
        return '';
    }
  }

  double _getMaxCount(Map<String, int> categoryCounts) {
    final max = categoryCounts.values.reduce((a, b) => a > b ? a : b);
    return (max * 1.2).toDouble();
  }
}
