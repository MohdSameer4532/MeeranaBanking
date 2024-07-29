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
            _buildSectionTitle('User Input Summary'),
            _buildUserInputSummary(context),
            _buildSectionTitle('Prediction Result'),
            _buildResultDisplay(),
            _buildSectionTitle('Income Comparison'),
            _buildComparisonSection(
              child:
                  _buildNumericalComparisonChart('Income Comparison', 'income'),
            ),
            _buildSectionTitle('Age Comparison'),
            _buildComparisonSection(
              child: _buildNumericalComparisonChart('Age Comparison', 'age'),
            ),
            _buildSectionTitle('Experience Comparison'),
            _buildComparisonSection(
              child: _buildNumericalComparisonChart(
                  'Experience Comparison', 'experience'),
            ),
            _buildSectionTitle('Current Job Years Comparison'),
            _buildComparisonSection(
              child: _buildNumericalComparisonChart(
                  'Current Job Years Comparison', 'currentJobYears'),
            ),
            _buildSectionTitle('Current House Years Comparison'),
            _buildComparisonSection(
              child: _buildNumericalComparisonChart(
                  'Current House Years Comparison', 'currentHouseYears'),
            ),
            _buildSectionTitle('Marital Status Comparison'),
            _buildComparisonSection(
              child: _buildCategoricalComparisonChart(
                  'Marital Status', 'maritalStatus'),
            ),
            _buildSectionTitle('House Ownership Comparison'),
            _buildComparisonSection(
              child: _buildCategoricalComparisonChart(
                  'House Ownership', 'houseOwnership'),
            ),
            _buildSectionTitle('Car Ownership Comparison'),
            _buildComparisonSection(
              child: _buildCategoricalComparisonChart(
                  'Car Ownership', 'carOwnership'),
            ),
            _buildSectionTitle('Profession Comparison'),
            _buildComparisonSection(
              child:
                  _buildCategoricalComparisonChart('Profession', 'profession'),
            ),
            _buildSectionTitle('Loan Status Comparison'),
            _buildComparisonSection(
              child: _buildCategoricalComparisonChart('Loan Status', 'status'),
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
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumericalComparisonChart(String title, String feature) {
    var data = _getNumericalComparison(feature);
    if (data.isEmpty)
      return SizedBox.shrink(); // Avoid rendering an empty chart
    var colors = [
      Colors.blue,
      Colors.orange,
      Colors.brown,
      Colors.yellow,
      Colors.green
    ];

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: data.isNotEmpty ? data.reduce((a, b) => a > b ? a : b) : 1,
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
                BarChartRodData(toY: data[i], color: colors[i % colors.length])
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildCategoricalComparisonChart(String title, String feature) {
    var data = _getCategoricalComparison(feature);
    if (data.isEmpty)
      return SizedBox.shrink(); // Avoid rendering an empty chart
    var colors = [Colors.blue, Colors.green, Colors.red];

    // Ensure the number of categories does not exceed the available colors
    if (data.length > colors.length) {
      colors = List.generate(data.length,
          (index) => Colors.primaries[index % Colors.primaries.length]);
    }

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
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(data.keys.elementAt(value.toInt()),
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
                    toY: data.values.elementAt(i),
                    color: colors[i % colors.length])
              ],
            ),
        ],
      ),
    );
  }

  List<double> _getNumericalComparison(String feature) {
    List<double> featureValues =
        dataset.map((person) => _getFeatureValue(person, feature)).toList();

    return [
      if (featureValues.isNotEmpty)
        featureValues.reduce((a, b) => a < b ? a : b), // Min
      if (featureValues.isNotEmpty)
        featureValues.reduce((a, b) => a > b ? a : b), // Max
      if (featureValues.isNotEmpty) _mean(featureValues), // Mean
      if (featureValues.isNotEmpty) _median(featureValues), // Median
      userInputData.containsKey(feature)
          ? userInputData[feature].toDouble()
          : 0.0 // User
    ];
  }

  double _getFeatureValue(LoanPerson person, String feature) {
    switch (feature) {
      case 'income':
        return person.income;
      case 'age':
        return person.age;
      case 'experience':
        return person.experience;
      case 'currentJobYears':
        return person.currentJobYears;
      case 'currentHouseYears':
        return person.currentHouseYears;
      default:
        return 0.0;
    }
  }

  double _mean(List<double> values) {
    if (values.isEmpty) return 0.0;
    return values.reduce((a, b) => a + b) / values.length;
  }

  double _median(List<double> values) {
    if (values.isEmpty) return 0.0;
    values.sort();
    int middle = values.length ~/ 2;
    if (values.length % 2 == 0) {
      return (values[middle - 1] + values[middle]) / 2;
    } else {
      return values[middle];
    }
  }

  Map<String, double> _getCategoricalComparison(String feature) {
    Map<String, int> counts = {};
    for (var person in dataset) {
      String value = _getCategoricalFeatureValue(person, feature);
      counts[value] = (counts[value] ?? 0) + 1;
    }

    Map<String, double> percentages = {};
    int total = dataset.length;

    counts.forEach((key, value) {
      percentages[key] = (value / total) * 100;
    });

    return percentages;
  }

  String _getCategoricalFeatureValue(LoanPerson person, String feature) {
    switch (feature) {
      case 'maritalStatus':
        return person.maritalStatus;
      case 'houseOwnership':
        return person.houseOwnership;
      case 'carOwnership':
        return person.carOwnership;
      case 'profession':
        return person.profession;
      case 'status': // New case for Success vs Denied
        return person.loanStatus;
      default:
        return '';
    }
  }
}
