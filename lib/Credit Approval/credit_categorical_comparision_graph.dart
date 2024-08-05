import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'credit_person.dart';  // Ensure this is the correct import for your CreditPerson class

class CategoricalComparisonGraph extends StatefulWidget {
  final List<CreditPerson> dummyData;
  final CreditPerson userInput;
  final String feature;

  CategoricalComparisonGraph({
    required this.dummyData,
    required this.userInput,
    required this.feature,
  });

  @override
  _CategoricalComparisonGraphState createState() => _CategoricalComparisonGraphState();
}

class _CategoricalComparisonGraphState extends State<CategoricalComparisonGraph> {
  @override
  Widget build(BuildContext context) {
    final String userCategory = _getFeatureValue(widget.userInput);
    final Map<String, int> categoryCounts = _getCategoryCounts(userCategory);

    print('User Category: $userCategory');
    print('Category Counts: $categoryCounts');

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
                      final labels = ['Yes', 'No'];
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
              barGroups: [
                BarChartGroupData(
                  x: 0,
                  barRods: [
                    BarChartRodData(
                      toY: categoryCounts['yes']!.toDouble(),
                      color: Colors.green,
                      width: 60,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                ),
                BarChartGroupData(
                  x: 1,
                  barRods: [
                    BarChartRodData(
                      toY: categoryCounts['no']!.toDouble(),
                      color: Colors.red,
                      width: 60,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                ),
              ],
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final isYes = group.x == 0;
                    final count = isYes ? categoryCounts['yes']! : categoryCounts['no']!;
                    return BarTooltipItem(
                      '${isYes ? 'Yes' : 'No'}: $count',
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
    int yesCount = 0;
    int noCount = 0;
    for (final person in widget.dummyData) {
      print('Checking person with ${widget.feature}: ${_getFeatureValue(person)}, result: ${person.result}');
      if (_getFeatureValue(person) == userCategory) {
        if (person.result) {
          yesCount++;
        } else {
          noCount++;
        }
      }
    }
    return {'yes': yesCount, 'no': noCount};
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
            _legendItem(Colors.green, 'Yes'),
            SizedBox(width: 20),
            _legendItem(Colors.red, 'No'),
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

  String _getFeatureValue(CreditPerson person) {
    switch (widget.feature) {
      case 'gender':
        return person.gender;
      case 'educationType':
        return person.educationType;
      case 'familyStatus':
        return person.familyStatus;
      case 'ownCar':
        return person.ownCar ? 'Yes' : 'No';
      case 'ownProperty':
        return person.ownProperty ? 'Yes' : 'No';
      case 'incomeType':
        return person.incomeType;
      case 'occupationType':
        return person.occupationType;
      case 'housingType':
        return person.housingType;
      default:
        return '';
    }
  }

  String _getFeatureName() {
    switch (widget.feature) {
      case 'gender':
        return 'gender'; 
      case 'educationType':
        return 'Education Type';
      case 'familyStatus':
        return 'Family Status';
      case 'ownCar':
        return 'Own Car';
      case 'ownProperty':
        return 'Own Property';
      case 'incomeType':
        return 'incomeType';
      case 'occupationType':
        return 'Occupation Type';
      case 'housingType':
        return 'housingType'; 
      default:
        return '';
    }
  }

  double _getMaxCount(Map<String, int> categoryCounts) {
    final max = categoryCounts.values.reduce((a, b) => a > b ? a : b);
    return (max * 1.2).toDouble();
  }
}
