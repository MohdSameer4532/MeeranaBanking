import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../custom_app_bar.dart';
import 'loanperson.dart';

class LoanResultPage extends StatelessWidget {
  final String predictionResult;
  final Map<String, dynamic> userInputData;
  final List<LoanPerson> dataset = getLoanPersons();

  LoanResultPage({required this.predictionResult, required this.userInputData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color of the Scaffold
      appBar: CustomAppBar(
        c: context,
        title: 'Loan Result',
        backButton: true, // Enable back button
        backgroundColor: Color.fromARGB(
            255, 30, 51, 84), // Set the background color of the AppBar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'User Input Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222),
                ),
              ),
              SizedBox(height: 10),
              _buildUserInputSummary(),
              SizedBox(height: 20),
              Text(
                'Loan Result',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222),
                ),
              ),
              SizedBox(height: 10),
              _buildPredictionResult(),
              SizedBox(height: 20),
              Text(
                'Comparison',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222),
                ),
              ),
              SizedBox(height: 10),
              _buildNumericalComparisons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInputSummary() {
    return Card(
      color: Colors.grey[100],
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInputRow(
                'Income:', userInputData['income']?.toString() ?? 'N/A'),
            _buildInputRow('Age:', userInputData['age']?.toString() ?? 'N/A'),
            _buildInputRow('Experience:',
                userInputData['experience']?.toString() ?? 'N/A'),
            _buildInputRow('Current Job Years:',
                userInputData['currentJobYears']?.toString() ?? 'N/A'),
            _buildInputRow('Current House Years:',
                userInputData['currentHouseYears']?.toString() ?? 'N/A'),
            _buildInputRow(
                'Marital Status:', userInputData['maritalStatus'] ?? 'N/A'),
            _buildInputRow(
                'House Ownership:', userInputData['houseOwnership'] ?? 'N/A'),
            _buildInputRow(
                'Car Ownership:', userInputData['carOwnership'] ?? 'N/A'),
            _buildInputRow('Profession:', userInputData['profession'] ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _buildInputRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildPredictionResult() {
    bool isApproved = predictionResult == 'Loan Approved';
    return Card(
      color: isApproved ? Colors.green[100] : Colors.red[100],
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              isApproved ? Icons.check_circle : Icons.cancel,
              color: isApproved ? Colors.green : Colors.red,
              size: 50,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                isApproved
                    ? 'Likely to make a deposit'
                    : 'Unlikely to make a deposit',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumericalComparisons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildNumericalComparisonChart('Income Comparison', 'income'),
        _buildNumericalComparisonChart('Age Comparison', 'age'),
        _buildNumericalComparisonChart('Experience Comparison', 'experience'),
        _buildNumericalComparisonChart(
            'Current Job Years Comparison', 'currentJobYears'),
        _buildNumericalComparisonChart(
            'Current House Years Comparison', 'currentHouseYears'),
      ],
    );
  }

  Widget _buildNumericalComparisonChart(String title, String feature) {
    var data = _getNumericalComparison(feature);
    var colors = [
      Colors.blue, // Data (Min)
      Colors.orange, // Max
      Colors.brown, // Mean
      Colors.yellow, // Median
      Colors.green // User
    ];
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 300,
              child: BarChart(
                BarChartData(
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const titles = [
                            'Min',
                            'Max',
                            'Mean',
                            'Median',
                            'User'
                          ];
                          return Text(titles[value.toInt()]);
                        },
                        reservedSize: 30,
                      ),
                    ),
                  ),
                  barGroups: [
                    for (int i = 0; i < data.length; i++)
                      BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(toY: data[i], color: colors[i])
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<double> _getNumericalComparison(String feature) {
    var values = dataset.map((person) {
      var value = person.toMap()[feature];
      return (value is int) ? value.toDouble() : value as double;
    }).toList();
    values.sort();
    return [
      values.first, // Min
      values.last, // Max
      values.reduce((a, b) => a + b) / values.length, // Mean
      values[values.length ~/ 2], // Median
      _getUserValue(feature), // User value
    ];
  }

  double _getUserValue(String feature) {
    var value = userInputData[feature];
    return (value is int) ? value.toDouble() : value as double;
  }
}
