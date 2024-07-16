import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'credit_person.dart';

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
  late String userCategory;
  late Map<String, int> categoryCounts;
  late List<String> hiddenCategories;

  final List<Color> colors = [
    Color(0xFF4E79A7),
    Color(0xFFF28E2B),
    Color(0xFFE15759),
    Color(0xFF76B7B2),
    Color(0xFF59A14F),
    Color(0xFFEDC948),
    Color(0xFFB07AA1),
    Color(0xFFFF9DA7),
    Color(0xFF9C755F),
    Color(0xFFBAB0AC),
  ];

  @override
  void initState() {
    super.initState();
    userCategory = _getFeatureValue(widget.userInput);
    categoryCounts = _getCategoryCounts();
    hiddenCategories = [];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'This graph shows the distribution of ${_getFeatureName().toLowerCase()} across all data points. Your category is highlighted in yellow.',
                  style: TextStyle(fontSize: 14, fontStyle: FontStyle.normal),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: constraints.maxHeight * 0.6,
                width: constraints.maxWidth,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: _getMaxCount(categoryCounts),
                    titlesData: _getTitlesData(),
                    borderData: FlBorderData(show: false),
                    barGroups: _getBarGroups(constraints.maxWidth),
                    barTouchData: _getBarTouchData(),
                  ),
                  swapAnimationDuration: Duration(milliseconds: 150),
                  swapAnimationCurve: Curves.linear,
                ),
              ),
              SizedBox(height: 20),
              _buildLegend(),
            ],
          ),
        );
      },
    );
  }

  FlTitlesData _getTitlesData() {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 60,
          getTitlesWidget: (value, meta) {
            final labels = categoryCounts.keys.toList();
            if (value.toInt() < labels.length) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    labels[value.toInt()],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
            return Text(value.toInt().toString(), style: TextStyle(fontSize: 10));
          },
        ),
      ),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }

  List<BarChartGroupData> _getBarGroups(double maxWidth) {
    final barWidth = (maxWidth / (categoryCounts.length * 2)).clamp(10.0, 30.0);
    return categoryCounts.entries.map((entry) {
      final index = categoryCounts.keys.toList().indexOf(entry.key);
      final color = colors[index % colors.length];
      final isUser = entry.key == userCategory;
      final isHidden = hiddenCategories.contains(entry.key);
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: isHidden ? 0 : entry.value.toDouble(),
            color: isUser ? Colors.yellow : color,
            width: barWidth,
            borderRadius: BorderRadius.circular(barWidth / 3),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: _getMaxCount(categoryCounts),
              color: Colors.grey.withOpacity(0.3),
            ),
          ),
          if (isUser && _shouldShowUserIndicator())
            BarChartRodData(
              toY: entry.value.toDouble() + 0.5,
              color: Colors.green,
              width: barWidth / 2,
              borderRadius: BorderRadius.circular(barWidth / 6),
            ),
        ],
        showingTooltipIndicators: isUser ? [0, 1] : [],
      );
    }).toList();
  }

  bool _shouldShowUserIndicator() {
    return ['gender', 'educationType', 'housingType'].contains(widget.feature);
  }

  BarTouchData _getBarTouchData() {
    return BarTouchData(
      touchTooltipData: BarTouchTooltipData(
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          final featureValue = categoryCounts.keys.elementAt(group.x);
          final count = rod.toY.toInt();
          final total = categoryCounts.values.reduce((a, b) => a + b);
          final percentage = (count / total * 100).toStringAsFixed(1);
          String tooltipText = '$featureValue:\n$count ($percentage%)';
          if (rodIndex == 1 && _shouldShowUserIndicator()) {
            tooltipText += '\nYour Input';
          }
          return BarTooltipItem(
            tooltipText,
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          );
        },
      ),
    );
  }

  Widget _buildLegend() {
    return Column(
      children: [
        Text(
          'Comparison for ${_getFeatureName()}: $userCategory',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ...categoryCounts.keys.map((category) {
              final index = categoryCounts.keys.toList().indexOf(category);
              final color = colors[index % colors.length];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (hiddenCategories.contains(category)) {
                      hiddenCategories.remove(category);
                    } else {
                      hiddenCategories.add(category);
                    }
                  });
                },
                child: Opacity(
                  opacity: hiddenCategories.contains(category) ? 0.5 : 1.0,
                  child: _legendItem(color, category),
                ),
              );
            }).toList(),
            if (_shouldShowUserIndicator())
              _legendItem(Colors.green, 'Your Input'),
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
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Map<String, int> _getCategoryCounts() {
    final Map<String, int> dataMap = {};
    for (final person in widget.dummyData) {
      final featureValue = _getFeatureValue(person);
      dataMap[featureValue] = (dataMap[featureValue] ?? 0) + 1;
    }
    return dataMap;
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
    if (categoryCounts.isEmpty) return 0;
    final max = categoryCounts.values.reduce((a, b) => a > b ? a : b);
    return (max * 1.2).toDouble();
  }
}