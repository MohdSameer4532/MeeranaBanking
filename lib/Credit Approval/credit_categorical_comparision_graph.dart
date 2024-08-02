import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'credit_person.dart';

class CategoricalComparisonGraph extends StatefulWidget {
  final List<CreditPerson> dummyData;
  final CreditPerson userInput;
  final String feature;

  const CategoricalComparisonGraph({
    Key? key,
    required this.dummyData,
    required this.userInput,
    required this.feature,
  }) : super(key: key);

  @override
  _CategoricalComparisonGraphState createState() => _CategoricalComparisonGraphState();
}

class _CategoricalComparisonGraphState extends State<CategoricalComparisonGraph> {
  late String userCategory;
  late Map<String, int> categoryCounts;

  @override
  void initState() {
    super.initState();
    userCategory = _getFeatureValue(widget.userInput);
    categoryCounts = _getCategoryCounts();
  }

  @override
  Widget build(BuildContext context) {
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
                            _abbreviateLabel(labels[value.toInt()]),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
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
                    final percentage = (count / widget.dummyData.length * 100).toStringAsFixed(1);
                    return BarTooltipItem(
                      '$category\n$count ($percentage%)',
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
    for (final person in widget.dummyData) {
      final category = _getFeatureValue(person);
      counts[category] = (counts[category] ?? 0) + 1;
    }
    return counts;
  }

  List<BarChartGroupData> _getBarGroups(Map<String, int> categoryCounts) {
    final List<Color> colors = [
      Colors.green,
      Colors.blue,
      Colors.red,
      Colors.yellow,
      Colors.purple
    ];
    return categoryCounts.entries.map((entry) {
      final index = categoryCounts.keys.toList().indexOf(entry.key);
      final isUserCategory = entry.key == userCategory;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: entry.value.toDouble(),
            color: isUserCategory ? Colors.green : colors[index % colors.length],
            width: 40,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList();
  }

  Widget _buildLegend(String userCategory) {
    final userCount = categoryCounts[userCategory] ?? 0;
    final totalCount = widget.dummyData.length;
    final percentage = (userCount / totalCount * 100).toStringAsFixed(1);

    return Column(
      children: [
        Text(
          'Comparison for ${_getFeatureName()}: $userCategory',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          'Your input: $userCount out of $totalCount ($percentage%)',
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: categoryCounts.keys.map((category) {
            final index = categoryCounts.keys.toList().indexOf(category);
            final List<Color> colors = [
              Colors.orange,
              Colors.blue,
              Colors.red,
              Colors.yellow,
              Colors.purple
            ];
            final color = category == userCategory ? Colors.green : colors[index % colors.length];
            return _legendItem(color, category);
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

  String _getFeatureValue(CreditPerson person) {
    switch (widget.feature) {
      case 'gender':
        return person.gender;
      case 'ownCar':
        return person.ownCar ? 'Yes' : 'No';
      case 'ownProperty':
        return person.ownProperty ? 'Yes' : 'No';
      case 'incomeType':
        return person.incomeType;
      case 'educationType':
        return person.educationType;
      case 'familyStatus':
        return person.familyStatus;
      case 'housingType':
        return person.housingType;
      case 'occupationType':
        return person.occupationType;
      default:
        return '';
    }
  }

  String _getFeatureName() {
    switch (widget.feature) {
      case 'gender':
        return 'Gender';
      case 'ownCar':
        return 'Own Car';
      case 'ownProperty':
        return 'Own Property';
      case 'incomeType':
        return 'Income Type';
      case 'educationType':
        return 'Education Type';
      case 'familyStatus':
        return 'Family Status';
      case 'housingType':
        return 'Housing Type';
      case 'occupationType':
        return 'Occupation Type';
      default:
        return '';
    }
  }

  double _getMaxCount(Map<String, int> categoryCounts) {
    final max = categoryCounts.values.reduce((a, b) => a > b ? a : b);
    return (max * 1.2).toDouble();
  }

  String _abbreviateLabel(String label) {
    if (label.length <= 5) return label;
    return label.substring(0, 3) + '...';
  }
}