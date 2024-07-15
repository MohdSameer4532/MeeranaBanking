import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'fraud_data.dart'; // Assuming this imports your data structure
import 'fraud_prediction.dart'; // Import your prediction page

class FraudGeneralAnalyticsPage extends StatefulWidget {
  @override
  _FraudGeneralAnalyticsPageState createState() =>
      _FraudGeneralAnalyticsPageState();
}

class _FraudGeneralAnalyticsPageState extends State<FraudGeneralAnalyticsPage> {
  final List<FraudPerson> data =
      getFraudPersons(); // Replace with your data source

  Map<String, double> ageRangeData = {};
  Map<String, double> genderData = {};

  @override
  void initState() {
    super.initState();
    calculateAnalytics();
  }

  void calculateAnalytics() {
    setState(() {
      // Calculate age range data
      ageRangeData = _calculateAgeRangeData();

      // Calculate gender data
      genderData = _calculateGenderData();
    });
  }

  Map<String, double> _calculateAgeRangeData() {
    Map<String, double> ageRanges = {
      '18-30': 0,
      '30-50': 0,
      '50+': 0,
    };

    for (var person in data) {
      int age = person.age;
      if (age >= 18 && age <= 30) {
        ageRanges['18-30'] = ageRanges['18-30']! + 1;
      } else if (age > 30 && age <= 50) {
        ageRanges['30-50'] = ageRanges['30-50']! + 1;
      } else if (age > 50) {
        ageRanges['50+'] = ageRanges['50+']! + 1;
      }
    }

    return ageRanges;
  }

  Map<String, double> _calculateGenderData() {
    Map<String, double> genderCounts = {'Male': 0, 'Female': 0};

    for (var person in data) {
      if (person.gender == 'M') {
        genderCounts['Male'] = genderCounts['Male']! + 1;
      } else if (person.gender == 'F') {
        genderCounts['Female'] = genderCounts['Female']! + 1;
      }
    }

    return genderCounts;
  }

  List<PieChartSectionData> _generatePieChartSections(
      Map<String, double> data) {
    List<PieChartSectionData> sections = [];
    data.forEach((key, value) {
      sections.add(
        PieChartSectionData(
          color: _getColorForKey(key),
          value: value,
          title:
              '${value.toStringAsFixed(0)}', // Show counts instead of percentage
          radius: 30,
          titleStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    });
    return sections;
  }

  Color _getColorForKey(String key) {
    switch (key) {
      case '18-30':
        return Colors.blue;
      case '30-50':
        return Colors.green;
      case '50+':
        return Colors.red;
      case 'Male':
        return Colors.blue;
      case 'Female':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }

  Widget _buildPieChart(Map<String, double> data) {
    return Container(
      height: 200, // Set a fixed height for the pie chart
      child: PieChart(
        PieChartData(
          sections: _generatePieChartSections(data),
          centerSpaceRadius: 22,
          sectionsSpace: 0,
        ),
      ),
    );
  }

  Widget _buildChartCard(String title, Widget chart, List<Widget> legendItems) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Expanded(child: chart),
            SizedBox(height: 8),
            ...legendItems,
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            color: color,
          ),
          SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 10)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF1E3354),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Fraud General Analytics',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Center(
              child: Text(
                'General Analytics',
                style: TextStyle(
                  color: const Color.fromARGB(255, 2, 2, 2),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 0.68,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildChartCard('Age Range', _buildPieChart(ageRangeData), [
                    _buildLegendItem(Colors.blue, '18-30'),
                    _buildLegendItem(Colors.green, '30-50'),
                    _buildLegendItem(Colors.red, '50+'),
                  ]),
                  _buildChartCard('Gender', _buildPieChart(genderData), [
                    _buildLegendItem(Colors.blue, 'Male'),
                    _buildLegendItem(Colors.pink, 'Female'),
                  ]),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FraudPredictionPage()),
              );
            },
            label: Text('Predict Fraud Risk',
                style: TextStyle(color: Colors.white)),
            icon: Icon(Icons.add, color: Colors.white),
            backgroundColor: Color.fromARGB(255, 30, 51, 84),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FraudGeneralAnalyticsPage(),
  ));
}
