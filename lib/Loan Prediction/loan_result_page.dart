import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'loanperson.dart';
import '../custom_app_bar.dart';

class LoanResultPage extends StatelessWidget {
  final String predictionResult;
  final Map<String, dynamic> userInputData;
  final List<LoanPerson> dataset = getLoanPersons();

  LoanResultPage({required this.predictionResult, required this.userInputData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        c: context,
        title: 'Loan Result',
        backButton: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            _buildUserInputSummary(context),
            _buildSectionTitle('Prediction Result'),
            _buildResultDisplay(),
            _buildSectionTitle('Income Comparison'),
            _buildComparisonSection(
              child: FeatureComparisonGraph(
                dataset: dataset,
                userInput: userInputData,
                feature: 'income',
              ),
            ),
            _buildSectionTitle('Age Comparison'),
            _buildComparisonSection(
              child: FeatureComparisonGraph(
                dataset: dataset,
                userInput: userInputData,
                feature: 'age',
              ),
            ),
            _buildSectionTitle('Experience Comparison'),
            _buildComparisonSection(
              child: FeatureComparisonGraph(
                dataset: dataset,
                userInput: userInputData,
                feature: 'experience',
              ),
            ),
            _buildSectionTitle('Marital Status Comparison'),
            _buildComparisonSection(
              child: CategoricalComparisonGraph(
                dataset: dataset,
                userInput: userInputData,
                feature: 'maritalStatus',
              ),
            ),
            _buildSectionTitle('House Ownership Comparison'),
            _buildComparisonSection(
              child: CategoricalComparisonGraph(
                dataset: dataset,
                userInput: userInputData,
                feature: 'houseOwnership',
              ),
            ),
            _buildSectionTitle('Car Ownership Comparison'),
            _buildComparisonSection(
              child: CategoricalComparisonGraph(
                dataset: dataset,
                userInput: userInputData,
                feature: 'carOwnership',
              ),
            ),
            _buildSectionTitle('Profession Comparison'),
            _buildComparisonSection(
              child: CategoricalComparisonGraph(
                dataset: dataset,
                userInput: userInputData,
                feature: 'profession',
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInputSummary(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Input Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 16),
            _buildProfileItem(context, Icons.attach_money, 'Income',
                '${userInputData['income']}'),
            _buildProfileItem(
                context, Icons.cake, 'Age', '${userInputData['age']}'),
            _buildProfileItem(context, Icons.work, 'Experience',
                '${userInputData['experience']} years'),
            _buildProfileItem(context, Icons.business, 'Current Job',
                '${userInputData['currentJobYears']} years'),
            _buildProfileItem(context, Icons.home, 'Current House',
                '${userInputData['currentHouseYears']} years'),
            _buildProfileItem(context, Icons.favorite, 'Marital Status',
                userInputData['maritalStatus']),
            _buildProfileItem(context, Icons.house, 'House Ownership',
                userInputData['houseOwnership']),
            _buildProfileItem(context, Icons.directions_car, 'Car Ownership',
                userInputData['carOwnership']),
            _buildProfileItem(
                context, Icons.work, 'Profession', userInputData['profession']),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(
      BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 28, color: _getIconColor(icon)),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getIconColor(IconData icon) {
    switch (icon) {
      case Icons.attach_money:
        return Colors.green;
      case Icons.cake:
        return Colors.pink;
      case Icons.work:
        return Colors.brown;
      case Icons.business:
        return Colors.blue;
      case Icons.home:
        return Colors.orange;
      case Icons.favorite:
        return Colors.red;
      case Icons.house:
        return Colors.teal;
      case Icons.directions_car:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blue[900],
        ),
      ),
    );
  }

  Widget _buildComparisonSection({required Widget child}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          height: 300,
          child: child,
        ),
      ),
    );
  }

  Widget _buildResultDisplay() {
    bool isApproved = predictionResult == 'Loan Approved';
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: isApproved ? Colors.green[100] : Colors.red[100],
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            Center(
              child: Icon(
                isApproved ? Icons.thumb_up : Icons.thumb_down,
                size: 50,
                color: isApproved ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                isApproved ? 'Loan Approved' : 'Loan Denied',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureComparisonGraph extends StatelessWidget {
  final List<LoanPerson> dataset;
  final Map<String, dynamic> userInput;
  final String feature;

  FeatureComparisonGraph({
    required this.dataset,
    required this.userInput,
    required this.feature,
  });

  @override
  Widget build(BuildContext context) {
    List<double> data = _getFeatureData();
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: data.reduce((a, b) => a > b ? a : b),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const titles = ['Min', 'Max', 'Mean', 'Median', 'User'];
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(titles[value.toInt()],
                      style: TextStyle(fontSize: 12)),
                );
              },
              reservedSize: 40,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(value.toInt().toString(),
                    style: TextStyle(fontSize: 12));
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: [
          for (int i = 0; i < data.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                    toY: data[i],
                    color: i == data.length - 1 ? Colors.green : Colors.blue)
              ],
            ),
        ],
      ),
    );
  }

  List<double> _getFeatureData() {
    List<double> featureValues =
        dataset.map((person) => _getFeatureValue(person)).toList();

    return [
      featureValues.reduce((a, b) => a < b ? a : b), // Min
      featureValues.reduce((a, b) => a > b ? a : b), // Max
      _mean(featureValues), // Mean
      _median(featureValues), // Median
      userInput[feature].toDouble(), // User
    ];
  }

  double _getFeatureValue(LoanPerson person) {
    switch (feature) {
      case 'income':
        return person.income;
      case 'age':
        return person.age;
      case 'experience':
        return person.experience;
      default:
        return 0.0;
    }
  }

  double _mean(List<double> values) {
    return values.reduce((a, b) => a + b) / values.length;
  }

  double _median(List<double> values) {
    values.sort();
    int middle = values.length ~/ 2;
    if (values.length % 2 == 0) {
      return (values[middle - 1] + values[middle]) / 2;
    } else {
      return values[middle];
    }
  }
}

class CategoricalComparisonGraph extends StatelessWidget {
  final List<LoanPerson> dataset;
  final Map<String, dynamic> userInput;
  final String feature;

  CategoricalComparisonGraph({
    required this.dataset,
    required this.userInput,
    required this.feature,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, double> data = _getCategoricalData();
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 100,
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() < data.keys.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(data.keys.elementAt(value.toInt()),
                        style: TextStyle(fontSize: 10),
                        textAlign: TextAlign.center),
                  );
                }
                return Text('');
              },
              reservedSize: 40,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                if (value % 20 == 0) {
                  return Text("${value.toInt()}%",
                      style: TextStyle(fontSize: 10));
                }
                return Text('');
              },
              interval: 20,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: [
          for (int i = 0; i < data.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: data.values.elementAt(i),
                  color: data.keys.elementAt(i) == userInput[feature]
                      ? Colors.green
                      : Colors.blue,
                  width: 20,
                )
              ],
            ),
        ],
      ),
    );
  }

  Map<String, double> _getCategoricalData() {
    Map<String, int> counts = {};
    for (var person in dataset) {
      String value = _getCategoricalFeatureValue(person);
      counts[value] = (counts[value] ?? 0) + 1;
    }

    Map<String, double> percentages = {};
    int total = dataset.length;

    counts.forEach((key, value) {
      percentages[key] = (value / total) * 100;
    });

    return percentages;
  }

  String _getCategoricalFeatureValue(LoanPerson person) {
    switch (feature) {
      case 'maritalStatus':
        return person.maritalStatus;
      case 'houseOwnership':
        return person.houseOwnership;
      case 'carOwnership':
        return person.carOwnership;
      case 'profession':
        return person.profession;
      default:
        return '';
    }
  }
}
