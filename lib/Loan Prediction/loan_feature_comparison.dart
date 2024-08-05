import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'loanperson.dart';

class FeatureComparisonGraph extends StatefulWidget {
  final List<Person> dummyData;
  final Person userInput;
  final String feature;

  FeatureComparisonGraph({
    required this.dummyData,
    required this.userInput,
    required this.feature,
  });

  @override
  _FeatureComparisonGraphState createState() => _FeatureComparisonGraphState();
}

class _FeatureComparisonGraphState extends State<FeatureComparisonGraph> {
  double _minX = 0;
  double _maxX = 0;
  double _minY = 0;
  double _maxY = 0;
  bool _isZoomed = false;

  @override
  void initState() {
    super.initState();
    _updateBoundaries();
  }

  void _updateBoundaries() {
    if (widget.dummyData.isEmpty) {
      _minY = 0;
      _maxY = 1;
      return;
    }

    final List<double> featureValues =
        widget.dummyData.map((person) => _getFeatureValue(person)).toList();

    _minX = 0;
    _maxX = widget.dummyData.length.toDouble() - 1;

    _minY = featureValues.reduce((a, b) => a < b ? a : b);
    _maxY = featureValues.reduce((a, b) => a > b ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    print("Building graph for feature: ${widget.feature}");
    print("User input value: ${_getFeatureValue(widget.userInput)}");
    print("Number of data points: ${widget.dummyData.length}");

    final List<double> featureValues =
        widget.dummyData.map((person) => _getFeatureValue(person)).toList();
    final double userValue = _getFeatureValue(widget.userInput);
    final double meanVal = featureValues.isNotEmpty
        ? featureValues.reduce((a, b) => a + b) / featureValues.length
        : 0.0;
    final double medianVal =
        featureValues.isNotEmpty ? _calculateMedian(featureValues) : 0.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: LineChart(
                  LineChartData(
                    minX: _minX,
                    maxX: _maxX,
                    minY: _minY,
                    maxY: _maxY,
                    titlesData: FlTitlesData(
                      bottomTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(value.toStringAsFixed(0));
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      _createLineChartBarData(featureValues, Colors.blue),
                      _createHorizontalLine(_maxY, Colors.orange, 'Maximum'),
                      _createHorizontalLine(meanVal, Colors.purple, 'Mean'),
                      _createHorizontalLine(medianVal, Colors.yellow, 'Median'),
                      _createHorizontalLine(
                          userValue, Colors.green, 'User Data'),
                    ],
                    extraLinesData: ExtraLinesData(
                      horizontalLines: [
                        HorizontalLine(
                          y: userValue,
                          color: Colors.green,
                          strokeWidth: 2,
                          label: HorizontalLineLabel(
                            show: true,
                            alignment: Alignment.topRight,
                            padding: EdgeInsets.only(right: 5, top: 5),
                            style: TextStyle(color: Colors.black),
                            labelResolver: (line) =>
                                'User: ${userValue.toStringAsFixed(2)}',
                          ),
                        ),
                      ],
                    ),
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                          return touchedBarSpots.map((barSpot) {
                            final flSpot = barSpot;
                            return LineTooltipItem(
                              '${widget.feature}: ${flSpot.y.toStringAsFixed(2)}',
                              TextStyle(color: Colors.white),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              _buildLegend(),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_isZoomed) {
                      _updateBoundaries();
                    } else {
                      _minX = _maxX / 2;
                      _minY = _maxY / 2;
                    }
                    _isZoomed = !_isZoomed;
                  });
                },
                child: Text(_isZoomed ? 'Reset Zoom' : 'Zoom In'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem(Colors.blue, 'Data'),
        _legendItem(Colors.orange, 'Max'),
        _legendItem(Colors.purple, 'Mean'),
        _legendItem(Colors.yellow, 'Median'),
        _legendItem(Colors.green, 'User'),
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
        SizedBox(width: 8),
      ],
    );
  }

  double _getFeatureValue(Person person) {
    switch (widget.feature) {
      case 'income':
        return person.income.toDouble();
      case 'age':
        return person.age.toDouble();
      case 'experience':
        return person.experience.toDouble();
      case 'currentJobYears':
        return person.currentJobYears.toDouble();
      case 'currentHouseYears':
        return person.currentHouseYears.toDouble();
      default:
        return 0;
    }
  }

  double _calculateMedian(List<double> values) {
    values.sort();
    final middle = values.length ~/ 2;
    if (values.length % 2 == 0) {
      return (values[middle - 1] + values[middle]) / 2;
    } else {
      return values[middle];
    }
  }

  LineChartBarData _createLineChartBarData(List<double> values, Color color) {
    return LineChartBarData(
      spots: values.asMap().entries.map((entry) {
        return FlSpot(entry.key.toDouble(), entry.value);
      }).toList(),
      isCurved: true,
      color: color,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    );
  }

  LineChartBarData _createHorizontalLine(double y, Color color, String label) {
    return LineChartBarData(
      spots: [FlSpot(_minX, y), FlSpot(_maxX, y)],
      color: color,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    );
  }
}
