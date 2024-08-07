import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'credit_person.dart';

class FeatureComparisonGraph extends StatefulWidget {
  final List<CreditPerson> dummyData;
  final CreditPerson userInput;
  final String feature;

  const FeatureComparisonGraph({
    required this.dummyData,
    required this.userInput,
    required this.feature,
    Key? key,
  }) : super(key: key);

  @override
  _FeatureComparisonGraphState createState() => _FeatureComparisonGraphState();
}

class _FeatureComparisonGraphState extends State<FeatureComparisonGraph> {
  double _minX = 0;
  double _maxX = 0;
  double _minY = 0;
  double _maxY = 0;

  @override
  void initState() {
    super.initState();
    _updateBoundaries();
  }

  void _updateBoundaries() {
    final List<double> allValues = [
      ...widget.dummyData.map((person) => _getFeatureValue(person)),
      _getFeatureValue(widget.userInput)
    ];
    if (allValues.isNotEmpty) {
      _minX = 0;
      _maxX = widget.dummyData.length.toDouble();
      _minY = allValues.reduce((a, b) => a < b ? a : b);
      _maxY = allValues.reduce((a, b) => a > b ? a : b);

      // Add some padding to the Y-axis
      double yPadding = (_maxY - _minY) * 0.1;
      _minY -= yPadding;
      _maxY += yPadding;

      // Ensure minimum Y value is not negative
      _minY = _minY < 0 ? 0 : _minY;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<double> featureValues =
        widget.dummyData.map((person) => _getFeatureValue(person)).toList();
    if (featureValues.isEmpty) {
      return const Center(child: Text('No data available for this feature.'));
    }

    final double userValue = _getFeatureValue(widget.userInput);
    final double meanVal =
        featureValues.reduce((a, b) => a + b) / featureValues.length;
    final double medianVal = _calculateMedian(featureValues);

    _updateBoundaries();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          padding: const EdgeInsets.all(16),
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
                          reservedSize: 40,
                          interval: (_maxY - _minY) / 5,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              _formatYAxisLabel(value),
                              style: TextStyle(fontSize: 10),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      _createLineChartBarData(featureValues, Colors.blue),
                      _createHorizontalLine(meanVal, Colors.purple),
                      _createHorizontalLine(medianVal, Colors.yellow),
                      _createHorizontalLine(userValue, Colors.green),
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
                            padding: const EdgeInsets.only(right: 5, top: 5),
                            style: const TextStyle(color: Colors.black),
                            labelResolver: (line) =>
                                'User: ${_formatValue(userValue)}',
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
                              '${widget.feature}: ${_formatValue(flSpot.y)}',
                              const TextStyle(color: Colors.white),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLegend(),
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
        const SizedBox(width: 4),
        Text(label),
        const SizedBox(width: 8),
      ],
    );
  }

  double _getFeatureValue(CreditPerson person) {
    switch (widget.feature) {
      case 'annualIncome':
        return person.annualIncome;
      case 'daysBirth':
        return person.yearsBirth
            .abs()
            .toDouble(); // Convert negative to positive
      case 'daysEmployed':
        return person.yearsEmployed
            .abs()
            .toDouble(); // Convert negative to positive
      case 'noOfChildren':
        return person.noOfChildren.toDouble();
      case 'totalFamilyMembers':
        return person.totalFamilyMembers.toDouble();
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
        double y = entry.value;
        y = y.clamp(_minY, _maxY); // Clamp the y value to the chart boundaries
        return FlSpot(entry.key.toDouble(), y);
      }).toList(),
      isCurved: true,
      color: color,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    );
  }

  LineChartBarData _createHorizontalLine(double y, Color color) {
    y = y.clamp(_minY, _maxY); // Clamp the y value to the chart boundaries
    return LineChartBarData(
      spots: [FlSpot(_minX, y), FlSpot(_maxX, y)],
      color: color,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    );
  }

  String _formatYAxisLabel(double value) {
    if (widget.feature == 'annualIncome') {
      return '\$${(value / 1000).toStringAsFixed(0)}K';
    } else if (widget.feature == 'yearsBirth' ||
        widget.feature == 'yearsEmployed') {
      return '${value.toStringAsFixed(0)} years'; // Display in years
    } else {
      return value.toStringAsFixed(1);
    }
  }

  String _formatValue(double value) {
    if (widget.feature == 'annualIncome') {
      return '\$${value.toStringAsFixed(0)}';
    } else if (widget.feature == 'yearsBirth' ||
        widget.feature == 'yearsEmployed') {
      return '${value.toStringAsFixed(0)} years'; // Display in years
    } else {
      return value.toStringAsFixed(1);
    }
  }
}
