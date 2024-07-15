import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'credit_person.dart';

class CategoricalComparisonGraph extends StatelessWidget {
  final List<CreditPerson> dummyData;
  final CreditPerson userInput;
  final String feature;

  const CategoricalComparisonGraph({
    super.key,
    required this.dummyData,
    required this.userInput,
    required this.feature,
  });

  @override
  Widget build(BuildContext context) {
    final dataMap = _groupDataByFeature();
    final userValue = _getCategoricalFeatureValue(userInput);

    if (dataMap.isEmpty) {
      return const Center(child: Text('No data available for this feature.'));
    }

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barGroups: dataMap.entries.map((entry) {
          final isUser = entry.key == userValue;
          return BarChartGroupData(
            x: entry.key.hashCode,
            barRods: [
              BarChartRodData(
                toY: entry.value.toDouble(),
                color: isUser ? Colors.green : Colors.blue,
                width: 16,
                borderRadius: isUser
                    ? BorderRadius.circular(0)
                    : BorderRadius.circular(10),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY:
                      dataMap.values.reduce((a, b) => a > b ? a : b).toDouble(),
                  color: Colors.grey.withOpacity(0.3),
                ),
              ),
            ],
            showingTooltipIndicators: [0],
          );
        }).toList(),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                final String featureValue = dataMap.keys.elementAt(dataMap.keys
                    .toList()
                    .indexWhere((k) => k.hashCode == value.toInt()));
                return Text(featureValue);
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                return Text(value.toInt().toString());
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: true),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final featureValue = dataMap.keys.elementAt(groupIndex);
              return BarTooltipItem(
                '$featureValue: ${rod.toY.toInt()}',
                const TextStyle(color: Colors.white),
              );
            },
          ),
        ),
      ),
    );
  }

  Map<String, int> _groupDataByFeature() {
    final Map<String, int> dataMap = {};
    for (final person in dummyData) {
      final featureValue = _getCategoricalFeatureValue(person);
      dataMap[featureValue] = (dataMap[featureValue] ?? 0) + 1;
    }
    return dataMap;
  }

  String _getCategoricalFeatureValue(CreditPerson person) {
    switch (feature) {
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
}
