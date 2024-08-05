import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'fraud_data.dart';

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
      padding:
          const EdgeInsets.all(16.0), // Add padding around the entire widget
      child: Column(
        children: <Widget>[
          _buildComparisonChart(),
          SizedBox(height: 20),
          _buildComparisonText(),
          SizedBox(height: 20),
          _buildFraudDetection(),
        ],
      ),
    );
  }

  Widget _buildComparisonChart() {
    switch (feature) {
      case 'age':
        return _buildBarChartForFeature(
            'Age', dummyData.map((e) => e.age.toDouble()).toList());
      case 'amount':
        return _buildBarChartForFeature(
            'Amount', dummyData.map((e) => e.amount).toList());
      case 'gender':
        return _buildBoxPlotForGender();
      case 'category':
        return _buildPieChartForCategories();
      default:
        return Container();
    }
  }

  Widget _buildBarChartForFeature(String title, List<double> values) {
    double userValue = _getUserValue();
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
      _buildBarGroup(2, minValue, Colors.red),
      _buildBarGroup(3, maxValue, Colors.orange),
      _buildBarGroup(1, meanValue, Colors.green),
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

  double _getUserValue() {
    switch (feature) {
      case 'age':
        return userInput.age.toDouble();
      case 'amount':
        return userInput.amount;
      default:
        return 0;
    }
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

  Widget _buildBoxPlotForGender() {
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

  Widget _buildPieChartForCategories() {
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

    // Sort and take the top 5 categories
    var sortedCategories = categoryData.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedCategories.take(5).toList();
  }

  Widget _buildComparisonText() {
    String comparisonText = '';
    List<MapEntry<String, double>> topCategories = _getTopCategoryData();

    switch (feature) {
      case 'age':
        comparisonText =
            'Your age: ${userInput.age}, Mean age: ${_calculateMean(dummyData.map((e) => e.age.toDouble()).toList()).toStringAsFixed(2)}, Min age: ${_calculateMin(dummyData.map((e) => e.age.toDouble()).toList()).toStringAsFixed(2)}, Max age: ${_calculateMax(dummyData.map((e) => e.age.toDouble()).toList()).toStringAsFixed(2)}';
        break;
      case 'amount':
        comparisonText =
            'Your amount: \$${userInput.amount.toStringAsFixed(2)}, Mean amount: \$${_calculateMean(dummyData.map((e) => e.amount).toList()).toStringAsFixed(2)}, Min amount: \$${_calculateMin(dummyData.map((e) => e.amount).toList()).toStringAsFixed(2)}, Max amount: \$${_calculateMax(dummyData.map((e) => e.amount).toList()).toStringAsFixed(2)}';
        break;
      case 'gender':
        comparisonText = 'Gender Distribution:\n';
        int maleCount = dummyData.where((p) => p.gender == 'M').length;
        int femaleCount = dummyData.where((p) => p.gender == 'F').length;
        comparisonText += 'Males: $maleCount, Females: $femaleCount';
        break;
      case 'category':
        comparisonText = 'Top 5 Categories: ';
        comparisonText += topCategories
            .map((entry) => '${entry.key}: \$${entry.value.toStringAsFixed(2)}')
            .join(', ');
        break;
      default:
        comparisonText = 'No data';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        comparisonText,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildFraudDetection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 10),
      ],
    );
  }

  bool _isFraudDetected() {
    if (userInput.amount > 1000) {
      return true;
    }
    return false;
  }
}
