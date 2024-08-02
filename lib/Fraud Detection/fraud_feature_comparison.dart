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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildComparisonChart(),
        SizedBox(height: 20),
        _buildComparisonText(),
        SizedBox(height: 20),
        _buildFraudDetection(),
      ],
    );
  }

  Widget _buildComparisonChart() {
    // Determine the chart type based on the feature
    switch (feature) {
      case 'age':
        return _buildBarChartForFeature(
            'Age', dummyData.map((e) => e.age.toDouble()).toList());
      case 'amount':
        return _buildBarChartForFeature(
            'Amount', dummyData.map((e) => e.amount).toList());
      default:
        return Container(); // Handle other features or return an empty container
    }
  }

  Widget _buildBarChartForFeature(String title, List<double> values) {
    double userValue = _getUserValue();
    double meanValue = _calculateMean(values);
    double medianValue = _calculateMedian(values);
    double averageValue = _calculateMean(values);

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Text(
            //   '$title Comparison',
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.teal,
            //   ),
            // ),
            SizedBox(height: 10),
            Container(
              height: 300,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 200,
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
                              text = const Text('Median', style: style);
                              break;
                            case 3:
                              text = const Text('Average', style: style);
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
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: _buildBarGroups(
                      userValue, meanValue, medianValue, averageValue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups(double userValue, double meanValue,
      double medianValue, double averageValue) {
    return [
      _buildBarGroup(0, userValue, Colors.blue),
      _buildBarGroup(1, meanValue, Colors.green),
      _buildBarGroup(2, medianValue, Colors.red),
      _buildBarGroup(3, averageValue, Colors.orange),
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

  double _calculateMedian(List<double> values) {
    if (values.isEmpty) return 0;
    values.sort();
    int middle = values.length ~/ 2;
    if (values.length.isOdd) {
      return values[middle];
    } else {
      return (values[middle - 1] + values[middle]) / 2;
    }
  }

  Widget _buildComparisonText() {
    String comparisonText = '';
    switch (feature) {
      case 'age':
        comparisonText =
            'Your age: ${userInput.age}, Mean age: ${_calculateMean(dummyData.map((e) => e.age.toDouble()).toList()).toStringAsFixed(2)}, Median age: ${_calculateMedian(dummyData.map((e) => e.age.toDouble()).toList()).toStringAsFixed(2)}, Average age: ${_calculateMean(dummyData.map((e) => e.age.toDouble()).toList()).toStringAsFixed(2)}';
        break;
      case 'amount':
        comparisonText =
            'Your amount: \$${userInput.amount.toStringAsFixed(2)}, Mean amount: \$${_calculateMean(dummyData.map((e) => e.amount).toList()).toStringAsFixed(2)}, Median amount: \$${_calculateMedian(dummyData.map((e) => e.amount).toList()).toStringAsFixed(2)}, Average amount: \$${_calculateMean(dummyData.map((e) => e.amount).toList()).toStringAsFixed(2)}';
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
    _isFraudDetected();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // children: [
      //   // Icon(
      //   //   isFraud ? Icons.thumb_down : Icons.thumb_up,
      //   //   color: isFraud ? Colors.red : Colors.green,
      //   //   size: 40,
      //   // ),
      //   SizedBox(width: 10),
      //   // Text(
      //   //   isFraud ? 'Fraud Detected' : 'No Fraud Detected',
      //   //   style: TextStyle(
      //   //     fontSize: 18,
      //   //     color: isFraud ? Colors.red : Colors.green,
      //   //   ),
      //   // ),
      // ],
    );
  }

  bool _isFraudDetected() {
    if (userInput.amount > 1000) {
      return true;
    }
    return false;
  }
}
