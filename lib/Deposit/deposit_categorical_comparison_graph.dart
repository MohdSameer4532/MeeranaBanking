import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'deposit_person.dart';

class CategoricalComparisonGraph extends StatelessWidget {
  final List<Person> dummyData;
  final Person userInput;
  final String feature;

  const CategoricalComparisonGraph({
    Key? key,
    required this.dummyData,
    required this.userInput,
    required this.feature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String userCategory = _getFeatureValue(userInput);
    final Map<String, int> categoryCounts = _getCategoryCounts();

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
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        );
                      }
                      return const Text('');
                    },
                    reservedSize: 40,
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
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              barGroups: _getBarGroups(categoryCounts),
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final category = categoryCounts.keys.toList()[group.x];
                    final count = categoryCounts[category]!;
                    return BarTooltipItem(
                      '$category: $count',
                      const TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        _buildLegend(userCategory),
      ],
    );
  }

  Map<String, int> _getCategoryCounts() {
    final counts = <String, int>{};
    for (final person in dummyData) {
      final category = _getFeatureValue(person);
      counts[category] = (counts[category] ?? 0) + 1;
    }
    return counts;
  }

  List<BarChartGroupData> _getBarGroups(Map<String, int> categoryCounts) {
    final List<Color> colors = [Colors.blue, Colors.green, Colors.red, Colors.yellow, Colors.purple];
    return categoryCounts.entries.map((entry) {
      final index = categoryCounts.keys.toList().indexOf(entry.key);
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: entry.value.toDouble(),
            color: colors[index % colors.length],
            width: 60,
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
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: _getCategoryCounts().keys.map((category) {
            final index = _getCategoryCounts().keys.toList().indexOf(category);
            final List<Color> colors = [Colors.blue, Colors.green, Colors.red, Colors.yellow, Colors.purple];
            return _legendItem(colors[index % colors.length], category);
          }).toList(),
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
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }

  String _getFeatureValue(Person person) {
    switch (feature) {
      case 'education':
        return person.education;
      case 'marital':
        return person.marital;
      case 'personalLoan':
        return person.personalLoan ? 'Yes' : 'No';
      case 'housingLoan':
        return person.housingLoan ? 'Yes' : 'No';
      case 'job':
        return person.job;
      default:
        return '';
    }
  }

  String _getFeatureName() {
    switch (feature) {
      case 'education':
        return 'Education';
      case 'marital':
        return 'Marital Status';
      case 'personalLoan':
        return 'Personal Loan';
      case 'housingLoan':
        return 'Housing Loan';
      case 'job':
        return 'Job';
      default:
        return '';
    }
  }

  double _getMaxCount(Map<String, int> categoryCounts) {
    final max = categoryCounts.values.reduce((a, b) => a > b ? a : b);
    return (max * 1.2).toDouble(); // Add 20% padding to the top
  }
}