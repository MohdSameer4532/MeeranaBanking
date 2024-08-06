import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'fraud_data.dart'; // Import your data file
import 'fraud_prediction.dart'; // Import FraudPredictionPage
import '../custom_app_bar.dart';

class FraudGeneralAnalyticsPage extends StatefulWidget {
  @override
  _FraudGeneralAnalyticsPageState createState() =>
      _FraudGeneralAnalyticsPageState();
}

class _FraudGeneralAnalyticsPageState extends State<FraudGeneralAnalyticsPage> {
  final List<FraudPerson> data = getFraudPersons();

  int totalClients = 0;
  int acceptedClients = 0;
  int deniedClients = 0;
  double averageAge = 0;

  Map<String, double> ageRangeData = {};
  Map<String, double> genderData = {};
  Map<String, double> categoriesData = {};
  Map<String, double> amountData = {};
  Map<String, double> fraudStatusData = {};

  @override
  void initState() {
    super.initState();
    calculateAnalytics();
  }

  void calculateAnalytics() {
    setState(() {
      totalClients = data.length;
      acceptedClients = data
          .where((person) => !person.fraudDetected)
          .length; // Assuming not detected as accepted
      deniedClients = data
          .where((person) => person.fraudDetected)
          .length; // Assuming detected as denied

      // Calculate average age
      if (data.isNotEmpty) {
        averageAge =
            data.map((e) => e.age).reduce((a, b) => a + b) / data.length;
      }

      // Calculate other analytics
      ageRangeData = _calculateAgeRangeData();
      genderData = _calculateGenderData();
      categoriesData = _calculateCategoriesData();
      amountData = _calculateAmountData();
      fraudStatusData = _calculateFraudStatusData();
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

  Map<String, double> _calculateAmountData() {
    Map<String, double> amountRanges = {
      '1-50': 0,
      '50-100': 0,
      '100+': 0,
    };

    for (var person in data) {
      double amount = person.amount;
      if (amount >= 1 && amount <= 50) {
        amountRanges['1-50'] = amountRanges['1-50']! + 1;
      } else if (amount > 50 && amount <= 100) {
        amountRanges['50-100'] = amountRanges['50-100']! + 1;
      } else if (amount > 100) {
        amountRanges['100+'] = amountRanges['100+']! + 1;
      }
    }

    return amountRanges;
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

  Map<String, double> _calculateCategoriesData() {
    Map<String, double> categoriesCounts = {
      'es_travel': 0,
      'es_tech': 0,
      'es_health': 0,
      'es_food': 0,
    };

    for (var person in data) {
      String category = person.category;
      if (categoriesCounts.containsKey(category)) {
        categoriesCounts[category] = categoriesCounts[category]! + 1;
      }
    }

    return categoriesCounts;
  }

  Map<String, double> _calculateFraudStatusData() {
    Map<String, double> fraudCounts = {
      'Fraud Detected': 0,
      'Fraud Not Detected': 0
    };

    for (var person in data) {
      if (person.fraudDetected) {
        fraudCounts['Fraud Detected'] = fraudCounts['Fraud Detected']! + 1;
      } else {
        fraudCounts['Fraud Not Detected'] =
            fraudCounts['Fraud Not Detected']! + 1;
      }
    }

    return fraudCounts;
  }

  List<PieChartSectionData> _generatePieChartSections(
      Map<String, double> data) {
    List<PieChartSectionData> sections = [];
    data.forEach((key, value) {
      sections.add(
        PieChartSectionData(
          color: _getColorForKey(key),
          value: value,
          title: '${value.toStringAsFixed(0)}',
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
      case 'es_travel':
        return Colors.blue;
      case 'es_tech':
        return Colors.orange;
      case 'es_health':
        return Colors.green;
      case 'es_food':
        return Colors.red;
      case '1-50':
        return Colors.blue;
      case '50-100':
        return Colors.orange;
      case '100+':
        return Colors.red;
      case 'Fraud Detected':
        return Colors.red;
      case 'Fraud Not Detected':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Widget _buildPieChart(Map<String, double> data) {
    return Container(
      height: 200,
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
          Text(
            label,
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        c: context,
        title: 'Fraud Detection',
        backButton: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'General Analytics',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.5,
                children: [
                  _buildCard('Total Clients', totalClients.toString()),
                  _buildCard('Accepted Clients', '$acceptedClients'),
                  _buildCard('Denied Clients', '$deniedClients'),
                  _buildCard('Average Age', averageAge.toStringAsFixed(1)),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Graphical View',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 16),
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
                  _buildChartCard(
                      'Previous Clients', _buildPieChart(fraudStatusData), [
                    _buildLegendItem(Colors.red, 'Fraud Detected'),
                    _buildLegendItem(Colors.green, 'Fraud Not Detected'),
                  ]),
                  _buildChartCard('Gender', _buildPieChart(genderData), [
                    _buildLegendItem(Colors.blue, 'Male'),
                    _buildLegendItem(Colors.pink, 'Female'),
                  ]),
                ],
              ),
            ),
            SizedBox(height: 16),
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
                  _buildChartCard('Category', _buildPieChart(categoriesData), [
                    _buildLegendItem(Colors.blue, 'Travel'),
                    _buildLegendItem(Colors.orange, 'Tech'),
                    _buildLegendItem(Colors.green, 'Health'),
                    _buildLegendItem(Colors.red, 'Food'),
                  ]),
                  _buildChartCard('Amount Range', _buildPieChart(amountData), [
                    _buildLegendItem(Colors.blue, '1-50'),
                    _buildLegendItem(Colors.orange, '50-100'),
                    _buildLegendItem(Colors.red, '100+'),
                  ]),
                  _buildChartCard('Age Range', _buildPieChart(ageRangeData), [
                    _buildLegendItem(Colors.blue, '18-30'),
                    _buildLegendItem(Colors.green, '30-50'),
                    _buildLegendItem(Colors.red, '50+'),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FraudPredictionPage()),
            );
          },
          label: Text('Detect Fraud', style: TextStyle(color: Colors.white)),
          icon: Icon(Icons.add, color: Colors.white),
          backgroundColor: Color.fromARGB(255, 34, 34, 34),
        ),
      ),
    );
  }

  Widget _buildCard(String title, String value) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold, // Make the title bold
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
