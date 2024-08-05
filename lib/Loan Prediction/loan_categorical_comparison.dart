// loan_categorical_comparison.dart
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
    print("Building categorical graph for feature: $feature");
    print("User input value: ${_getFeatureValue(userInput)}");
    print("Number of data points: ${dummyData.length}");

    final String userCategory = _getFeatureValue(userInput);
    final Map<String, Map<String, int>> categoryCounts =
        _getCategoryCounts(userCategory);

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
                      final categories = categoryCounts.keys.toList();
                      if (value.toInt() < categories.length) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            categories[value.toInt()],
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
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              barGroups: _createBarGroups(categoryCounts),
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final category = categoryCounts.keys.toList()[group.x];
                    final count = rod.toY.toInt();
                    final loanStatus = rodIndex == 0 ? 'Accepted' : 'Denied';
                    return BarTooltipItem(
                      '$category - $loanStatus: $count',
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

  Map<String, Map<String, int>> _getCategoryCounts(String userCategory) {
    final Map<String, Map<String, int>> counts = {};
    for (final person in dummyData) {
      final category = _getFeatureValue(person);
      if (!counts.containsKey(category)) {
        counts[category] = {'accepted': 0, 'denied': 0};
      }
      final key = person.loanStatus ? 'accepted' : 'denied';
      counts[category]![key] = (counts[category]![key] ?? 0) + 1;
    }
    return counts;
  }

  List<BarChartGroupData> _createBarGroups(
      Map<String, Map<String, int>> categoryCounts) {
    return categoryCounts.entries.mapIndexed((index, entry) {
      final counts = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: counts['accepted']!.toDouble(),
            color: Colors.green,
            width: 22,
            borderRadius: BorderRadius.circular(4),
          ),
          BarChartRodData(
            toY: counts['denied']!.toDouble(),
            color: Colors.red,
            width: 22,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList();
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
            _legendItem(Colors.green, 'Accepted'),
            SizedBox(width: 20),
            _legendItem(Colors.red, 'Denied'),
          ],
        ),
      ],
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 16, height: 16, color: color),
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
      case 'education':
        return 'Education';
      default:
        return '';
    }
  }

  double _getMaxCount(Map<String, Map<String, int>> categoryCounts) {
    int max = 0;
    for (var counts in categoryCounts.values) {
      final total = counts['accepted']! + counts['denied']!;
      if (total > max) max = total;
    }
    return (max * 1.2).toDouble();
  }
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int index, E element) f) {
    var index = 0;
    return map((e) => f(index++, e));
  }
}
