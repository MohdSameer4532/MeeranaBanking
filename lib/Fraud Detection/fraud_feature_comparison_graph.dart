import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'fraud_data.dart';

// Main widget for feature comparison graph
class FeatureComparisonGraph extends StatelessWidget {
  final FraudPerson userInput;
  final List<FraudPerson> dummyData;
  final String feature;

  FeatureComparisonGraph({
    required this.userInput,
    required this.dummyData,
    required this.feature,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          _buildComparisonChart(),
          SizedBox(height: 20),
          _buildComparisonText(),
        ],
      ),
    );
  }

  Widget _buildComparisonChart() {
    switch (feature) {
      case 'age':
        return AgeBarChart(
          userValue: userInput.age.toDouble(),
          values: dummyData.map((e) => e.age.toDouble()).toList(),
        );
      case 'amount':
        return AmountLineChart(
          userValue: userInput.amount,
          values: dummyData.map((e) => e.amount).toList(),
        );
      case 'gender':
        return GenderBoxPlot(
          dummyData: dummyData,
        );
      case 'category':
        return CategoryPieChart(
          dummyData: dummyData,
        );
      default:
        return Container();
    }
  }

  Widget _buildComparisonText() {
    String comparisonText = '';
    _getTopCategoryData();

    switch (feature) {
      case 'age':
        comparisonText =
            'Your age: ${userInput.age}, Mean age: ${_calculateMean(dummyData.map((e) => e.age.toDouble()).toList()).toStringAsFixed(2)}, Min age: ${_calculateMin(dummyData.map((e) => e.age.toDouble()).toList()).toStringAsFixed(2)}, Max age: ${_calculateMax(dummyData.map((e) => e.age.toDouble()).toList()).toStringAsFixed(2)}';
        break;
      // default:
      //   comparisonText = 'No data';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        comparisonText,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  bool _isFraudDetected() {
    return userInput.amount > 1000;
  }

  List<MapEntry<String, double>> _getTopCategoryData() {
    Map<String, double> categoryData = {};
    for (var person in dummyData) {
      categoryData[person.category] =
          (categoryData[person.category] ?? 0.0) + person.amount;
    }

    var sortedCategories = categoryData.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedCategories.take(5).toList();
  }

  double _calculateMean(List<double> values) {
    if (values.isEmpty) return 0;
    double sum = values.reduce((value, element) => value + element);
    return sum / values.length;
  }

  double _calculateMin(List<double> values) {
    if (values.isEmpty) return 0;
    return values.reduce((a, b) => a < b ? a : b);
  }

  double _calculateMax(List<double> values) {
    if (values.isEmpty) return 0;
    return values.reduce((a, b) => a > b ? a : b);
  }
}

// Widget for Bar Chart based on Age
class AgeBarChart extends StatelessWidget {
  final double userValue;
  final List<double> values;

  AgeBarChart({required this.userValue, required this.values});

  @override
  Widget build(BuildContext context) {
    double meanValue = _calculateMean(values);
    double minValue = _calculateMin(values);
    double maxValue = _calculateMax(values);

    double maxY = [userValue, meanValue, minValue, maxValue]
            .reduce((a, b) => a > b ? a : b) *
        1.2;

    return Container(
      height: 300,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceBetween,
          maxY: maxY,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const style = TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  );
                  Widget text;
                  switch (value.toInt()) {
                    case 0:
                      text = const Text('User Input', style: style);
                      break;
                    case 1:
                      text = const Text('Mean', style: style);
                      break;
                    case 2:
                      text = const Text('Min', style: style);
                      break;
                    case 3:
                      text = const Text('Max', style: style);
                      break;
                    default:
                      text = const Text('');
                      break;
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: text,
                  );
                },
                reservedSize: 28,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: maxY / 4,
                getTitlesWidget: (value, meta) {
                  const style = TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  );
                  return Text(
                    value.toInt().toString(),
                    style: style,
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: _buildBarGroups(userValue, meanValue, minValue, maxValue),
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups(
      double userValue, double meanValue, double minValue, double maxValue) {
    return [
      _buildBarGroup(0, userValue, Colors.blue),
      _buildBarGroup(1, meanValue, Colors.green),
      _buildBarGroup(2, minValue, Colors.red),
      _buildBarGroup(3, maxValue, Colors.orange),
    ];
  }

  BarChartGroupData _buildBarGroup(int x, double value, Color color) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 10,
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.black, width: 1),
        ),
      ],
    );
  }

  double _calculateMean(List<double> values) {
    if (values.isEmpty) return 0;
    double sum = values.reduce((value, element) => value + element);
    return sum / values.length;
  }

  double _calculateMin(List<double> values) {
    if (values.isEmpty) return 0;
    return values.reduce((a, b) => a < b ? a : b);
  }

  double _calculateMax(List<double> values) {
    if (values.isEmpty) return 0;
    return values.reduce((a, b) => a > b ? a : b);
  }
}

// Widget for Line Chart based on Amount

class AmountLineChart extends StatelessWidget {
  final double userValue;
  final List<double> values;

  AmountLineChart({required this.userValue, required this.values});

  @override
  Widget build(BuildContext context) {
    double meanValue = _calculateMean(values);
    double minValue = _calculateMin(values);
    double maxValue = _calculateMax(values);

    double maxY = [userValue, meanValue, minValue, maxValue]
            .reduce((a, b) => a > b ? a : b) *
        1.2;

    return Column(
      children: [
        Container(
          height: 300,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                // Line for the User Input
                LineChartBarData(
                  spots: [
                    FlSpot(0, userValue),
                    FlSpot(1, userValue),
                    FlSpot(2, userValue),
                    FlSpot(3, userValue),
                  ],
                  isCurved: false,
                  color: Colors.yellow,
                  dotData: FlDotData(
                    show: false,
                    getDotPainter: (spot, percent, barData, index) =>
                        FlDotCirclePainter(
                      radius: 4,
                      color: Colors.yellow,
                      strokeColor: Colors.black,
                      strokeWidth: 1,
                    ),
                  ),
                  belowBarData: BarAreaData(show: false),
                  isStrokeCapRound: true,
                  aboveBarData: BarAreaData(show: false),
                  barWidth: 2,
                  showingIndicators: [0],
                ),
                // Line for Mean, Min, and Max Values
                LineChartBarData(
                  spots: [
                    FlSpot(0, userValue),
                    FlSpot(1, meanValue),
                    FlSpot(2, minValue),
                    FlSpot(3, maxValue),
                  ],
                  isCurved: true,
                  color: Colors.blue,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) {
                      Color dotColor;
                      switch (index) {
                        case 0:
                          dotColor = Colors.yellow; // User Value
                          break;
                        case 1:
                          dotColor = Colors.green; // Mean Value
                          break;
                        case 2:
                          dotColor = Colors.red; // Min Value
                          break;
                        case 3:
                          dotColor = Colors.orange; // Max Value
                          break;
                        default:
                          dotColor = Colors.blue; // Default
                      }
                      return FlDotCirclePainter(
                        radius: 4,
                        color: dotColor,
                        strokeColor: Colors.black,
                        strokeWidth: 1,
                      );
                    },
                  ),
                  belowBarData: BarAreaData(show: false),
                  isStrokeCapRound: true,
                  aboveBarData: BarAreaData(show: false),
                  barWidth: 2,
                ),
              ],
              minY: 0,
              maxY: maxY,
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles:
                      SideTitles(showTitles: false), // Hide bottom titles
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    interval: (maxY / 5).toDouble(),
                    getTitlesWidget: (value, meta) {
                      const style = TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      );
                      return Text(
                        value.toStringAsFixed(0),
                        style: style,
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              gridData: FlGridData(show: false),
            ),
          ),
        ),
        SizedBox(height: 10),
        _buildLegend(),
      ],
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem(Colors.yellow, 'User Input'),
        SizedBox(width: 10),
        _buildLegendItem(Colors.green, 'Mean'),
        SizedBox(width: 10),
        _buildLegendItem(Colors.red, 'Min'),
        SizedBox(width: 10),
        _buildLegendItem(Colors.orange, 'Max'),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
          margin: EdgeInsets.only(right: 4),
        ),
        Text(label),
      ],
    );
  }

  double _calculateMean(List<double> values) {
    if (values.isEmpty) return 0;
    double sum = values.reduce((value, element) => value + element);
    return sum / values.length;
  }

  double _calculateMin(List<double> values) {
    if (values.isEmpty) return 0;
    return values.reduce((a, b) => a < b ? a : b);
  }

  double _calculateMax(List<double> values) {
    if (values.isEmpty) return 0;
    return values.reduce((a, b) => a > b ? a : b);
  }
}

// Widget for Box Plot based on Gender
class GenderBoxPlot extends StatelessWidget {
  final List<FraudPerson> dummyData;

  GenderBoxPlot({required this.dummyData});

  @override
  Widget build(BuildContext context) {
    List<double> maleAges = dummyData
        .where((person) => person.gender == 'M')
        .map((person) => person.age.toDouble())
        .toList();
    List<double> femaleAges = dummyData
        .where((person) => person.gender == 'F')
        .map((person) => person.age.toDouble())
        .toList();

    return Container(
      height: 300,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceBetween,
          maxY: [
                maleAges.reduce((a, b) => a > b ? a : b),
                femaleAges.reduce((a, b) => a > b ? a : b)
              ].reduce((a, b) => a > b ? a : b) *
              1.2,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const style = TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  );
                  switch (value.toInt()) {
                    case 0:
                      return const Text('Male', style: style);
                    case 1:
                      return const Text('Female', style: style);
                    default:
                      return const Text('');
                  }
                },
                reservedSize: 28,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: 10,
                getTitlesWidget: (value, meta) {
                  const style = TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  );
                  return Text(
                    value.toInt().toString(),
                    style: style,
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: [
            _buildBarGroup(0, maleAges.reduce((a, b) => a < b ? a : b),
                Colors.blue.withOpacity(0.2)),
            _buildBarGroup(
                0, maleAges.reduce((a, b) => a > b ? a : b), Colors.blue),
            _buildBarGroup(1, femaleAges.reduce((a, b) => a < b ? a : b),
                Colors.pink.withOpacity(0.2)),
            _buildBarGroup(
                1, femaleAges.reduce((a, b) => a > b ? a : b), Colors.pink),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double value, Color color) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 10,
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.black, width: 1),
        ),
      ],
    );
  }
}

// Widget for Pie Chart based on Category
class CategoryPieChart extends StatelessWidget {
  final List<FraudPerson> dummyData;

  CategoryPieChart({required this.dummyData});

  @override
  Widget build(BuildContext context) {
    List<MapEntry<String, double>> topCategories = _getTopCategoryData();

    if (topCategories.isEmpty) {
      return Center(child: Text("No categories available"));
    }

    return Container(
      height: 300,
      child: PieChart(
        PieChartData(
          sections: topCategories.asMap().entries.map((entry) {
            int index = entry.key;
            MapEntry<String, double> categoryEntry = entry.value;
            return PieChartSectionData(
              value: categoryEntry.value,
              title:
                  '${categoryEntry.key}\n${categoryEntry.value.toStringAsFixed(2)}',
              color: Colors.primaries[index % Colors.primaries.length],
              radius: 100,
              titleStyle: TextStyle(color: Colors.white),
            );
          }).toList(),
        ),
      ),
    );
  }

  List<MapEntry<String, double>> _getTopCategoryData() {
    Map<String, double> categoryData = {};
    for (var person in dummyData) {
      categoryData[person.category] =
          (categoryData[person.category] ?? 0.0) + person.amount;
    }

    var sortedCategories = categoryData.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedCategories.take(5).toList();
  }
}
