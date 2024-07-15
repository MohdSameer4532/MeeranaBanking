import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'loanperson.dart';

class LoanResultPage extends StatelessWidget {
  final String predictionResult;
  final Map<String, dynamic> userInputData;
  final List<LoanPerson> dataset = getLoanPersons();

  LoanResultPage({required this.predictionResult, required this.userInputData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color(0xFF1E3354),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Navigate back and handle layout adjustment
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Loan Prediction Result',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildResultDisplay(),
              SizedBox(height: 20),
              _buildUserInputSummary(),
              SizedBox(height: 20),
              _buildNumericalComparisons(),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Back to Prediction'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultDisplay() {
    return Card(
      color: predictionResult == 'Loan Approved'
          ? Colors.green[100]
          : Colors.red[100],
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Prediction Result',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              predictionResult,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInputSummary() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User Input Summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Income: ${userInputData['income']}'),
            Text('Age: ${userInputData['age']}'),
            Text('Experience: ${userInputData['experience']}'),
            Text('Current Job Years: ${userInputData['currentJobYears']}'),
            Text('Current House Years: ${userInputData['currentHouseYears']}'),
            Text('Marital Status: ${userInputData['maritalStatus']}'),
            Text('House Ownership: ${userInputData['houseOwnership']}'),
            Text('Car Ownership: ${userInputData['carOwnership']}'),
            Text('Profession: ${userInputData['profession']}'),
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
    return Column(
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
                      const titles = ['Min', 'Max', 'Mean', 'Median', 'User'];
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
                    barRods: [BarChartRodData(toY: data[i], color: colors[i])],
                  ),
              ],
            ),
          ),
        ),
      ],
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
