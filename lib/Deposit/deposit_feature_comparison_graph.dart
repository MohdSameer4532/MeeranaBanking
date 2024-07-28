import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'deposit_person.dart';
import 'dart:math';

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
    final List<double> featureValues =
        widget.dummyData.map((person) => _getFeatureValue(person)).toList();
    _minX = 0;
    _maxX = widget.dummyData.length.toDouble() - 1;
    _minY = featureValues.reduce((a, b) => a < b ? a : b);
    _maxY = featureValues.reduce((a, b) => a > b ? a : b);

    // Include user input in max calculation
    final userValue = _getFeatureValue(widget.userInput);
    _maxY = _maxY > userValue ? _maxY : userValue;

    // Ensure non-zero range
    if (_maxY == _minY) {
      _maxY += 1;
    }

    // Add some padding to the top of the graph
    _maxY *= 1.1; // Increase max by 10%
  }

  @override
  Widget build(BuildContext context) {
    _updateBoundaries();
    final List<double> featureValues =
        widget.dummyData.map((person) => _getFeatureValue(person)).toList();
    final double userValue = _getFeatureValue(widget.userInput);
    final double meanVal =
        featureValues.reduce((a, b) => a + b) / featureValues.length;
    final double medianVal = _calculateMedian(featureValues);

    // Generate custom ticks for y-axis
    final yAxisTicks = _generateYAxisTicks(_minY, _maxY, 5);

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
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(_formatAxisLabel(value));
                          },
                          reservedSize: 40,
                          interval: yAxisTicks[1] - yAxisTicks[0],
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
                                'User: ${_formatAxisLabel(userValue)}',
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
                              '${widget.feature}: ${_formatAxisLabel(flSpot.y)}',
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisSize: MainAxisSize.min,
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
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        SizedBox(width: 4),
        Text(label),
        SizedBox(width: 8),
      ],
    );
  }

  double _getFeatureValue(Person person) {
    switch (widget.feature) {
      case 'age':
        return person.age.toDouble();
      case 'balance':
        return person.balance.toDouble();
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

  List<double> _generateYAxisTicks(
      double min, double max, int desiredTickCount) {
    double range = max - min;
    double unroundedTickSize = range / (desiredTickCount - 1);
    double tickSize = _roundToNiceInterval(unroundedTickSize);
    double start = (min / tickSize).floor() * tickSize;
    List<double> ticks = [];
    for (int i = 0; i < desiredTickCount; i++) {
      double tick = start + (i * tickSize);
      if (tick >= min && tick <= max) {
        ticks.add(tick);
      }
    }
    return ticks;
  }

  double _roundToNiceInterval(double value) {
    double exponent = (log(value) / ln10).floor().toDouble();
    double fraction = value / pow(10, exponent);
    double niceFraction;

    if (fraction < 1.5) {
      niceFraction = 1;
    } else if (fraction < 3) {
      niceFraction = 2;
    } else if (fraction < 7) {
      niceFraction = 5;
    } else {
      niceFraction = 10;
    }

    return niceFraction * pow(10, exponent);
  }

  String _formatAxisLabel(double value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    } else {
      return value.toStringAsFixed(0);
    }
  }
}
