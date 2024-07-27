import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'credit_person.dart';
import 'credit_user_input_page.dart';

class CreditHomePage extends StatefulWidget {
  CreditHomePage({Key? key}) : super(key: key);

  @override
  _CreditHomePageState createState() => _CreditHomePageState();
}

class _CreditHomePageState extends State<CreditHomePage> {
  List<CreditPerson> people = [];

  @override
  void initState() {
    super.initState();
    people = dummyCreditData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color(0xFF1E3354),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Credit Approval',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  _buildChartCard('Credit Result', _buildCreditResultChart(), [
                    _buildLegendItem(Colors.green, 'Good Credit'),
                    _buildLegendItem(Colors.red, 'Bad Credit'),
                  ]),
                  _buildChartCard('Education', _buildEducationChart(), [
                    _buildLegendItem(Colors.blue, 'Higher education'),
                    _buildLegendItem(Colors.orange, 'Secondary education'),
                    _buildLegendItem(Colors.green, 'Incomplete higher'),
                  ]),
                  _buildChartCard('Age Groups', _buildAgeGroupChart(), [
                    _buildLegendItem(Colors.purple, '20-29'),
                    _buildLegendItem(Colors.blue, '30-39'),
                    _buildLegendItem(Colors.green, '40-49'),
                    _buildLegendItem(Colors.orange, '50+'),
                  ]),
                  _buildChartCard('Income Range', _buildIncomeRangeChart(), [
                    _buildLegendItem(Colors.blue, 'Low'),
                    _buildLegendItem(Colors.green, 'Medium'),
                    _buildLegendItem(Colors.orange, 'High'),
                  ]),
                  _buildChartCard('Family Status', _buildFamilyStatusChart(), [
                    _buildLegendItem(Colors.blue, 'Married'),
                    _buildLegendItem(Colors.green, 'Single'),
                    _buildLegendItem(Colors.orange, 'Civil marriage'),
                    _buildLegendItem(Colors.red, 'Widow'),
                  ]),
                  _buildChartCard('Housing Type', _buildHousingTypeChart(), [
                    _buildLegendItem(Colors.blue, 'House / apartment'),
                    _buildLegendItem(Colors.green, 'With parents'),
                    _buildLegendItem(Colors.orange, 'Co-op apartment'),
                    _buildLegendItem(Colors.red, 'Rented apartment'),
                    _buildLegendItem(Colors.purple, 'Office apartment'),
                  ]),
                  _buildEmptyCard(), // New empty card
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
              MaterialPageRoute(builder: (context) => CreditUserInputPage()),
            );
          },
          label: Text('Get Approval', style: TextStyle(color: Colors.white)),
          icon: Icon(Icons.add, color: Colors.white),
          backgroundColor: Color.fromARGB(255, 30, 51, 84),
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

  Widget _buildEmptyCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
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

  Widget _buildCreditResultChart() {
    int goodClients = people.where((person) => person.result).length;
    int badClients = people.length - goodClients;
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: [
          PieChartSectionData(
            color: Colors.green,
            value: goodClients.toDouble(),
            title: goodClients.toString(),
            radius: 30,
            titleStyle: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            color: Colors.red,
            value: badClients.toDouble(),
            title: badClients.toString(),
            radius: 30,
            titleStyle: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationChart() {
    Map<String, int> educationData =
        _calculateCategoryData(people.map((p) => p.educationType).toList());
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: educationData.entries.map((entry) {
          Color color = _getEducationColor(entry.key);
          return PieChartSectionData(
            color: color,
            value: entry.value.toDouble(),
            title: entry.value.toString(),
            radius: 30,
            titleStyle: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAgeGroupChart() {
    Map<String, int> ageGroupData = _calculateAgeGroupData();
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: ageGroupData.entries.map((entry) {
          Color color = _getAgeGroupColor(entry.key);
          return PieChartSectionData(
            color: color,
            value: entry.value.toDouble(),
            title: entry.value.toString(),
            radius: 30,
            titleStyle: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildIncomeRangeChart() {
    Map<String, int> incomeRangeData = _calculateIncomeRangeData();
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: incomeRangeData.entries.map((entry) {
          Color color = _getIncomeRangeColor(entry.key);
          return PieChartSectionData(
            color: color,
            value: entry.value.toDouble(),
            title: entry.value.toString(),
            radius: 30,
            titleStyle: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFamilyStatusChart() {
    Map<String, int> familyStatusData =
        _calculateCategoryData(people.map((p) => p.familyStatus).toList());
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: familyStatusData.entries.map((entry) {
          Color color = _getFamilyStatusColor(entry.key);
          return PieChartSectionData(
            color: color,
            value: entry.value.toDouble(),
            title: entry.value.toString(),
            radius: 30,
            titleStyle: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHousingTypeChart() {
    Map<String, int> housingTypeData =
        _calculateCategoryData(people.map((p) => p.housingType).toList());
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: housingTypeData.entries.map((entry) {
          Color color = _getHousingTypeColor(entry.key);
          return PieChartSectionData(
            color: color,
            value: entry.value.toDouble(),
            title: entry.value.toString(),
            radius: 30,
            titleStyle: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
          );
        }).toList(),
      ),
    );
  }

  Map<String, int> _calculateCategoryData(List<String> data) {
    Map<String, int> categoryMap = {};
    for (var item in data) {
      categoryMap[item] = (categoryMap[item] ?? 0) + 1;
    }
    return categoryMap;
  }

  Map<String, int> _calculateAgeGroupData() {
    Map<String, int> ageGroupMap = {
      '20-29': 0,
      '30-39': 0,
      '40-49': 0,
      '50+': 0
    };
    for (var person in people) {
      int age = (-person.daysBirth ~/ 365);
      if (age >= 20 && age < 30)
        ageGroupMap['20-29'] = (ageGroupMap['20-29'] ?? 0) + 1;
      else if (age >= 30 && age < 40)
        ageGroupMap['30-39'] = (ageGroupMap['30-39'] ?? 0) + 1;
      else if (age >= 40 && age < 50)
        ageGroupMap['40-49'] = (ageGroupMap['40-49'] ?? 0) + 1;
      else if (age >= 50) ageGroupMap['50+'] = (ageGroupMap['50+'] ?? 0) + 1;
    }
    return ageGroupMap;
  }

  Map<String, int> _calculateIncomeRangeData() {
    Map<String, int> incomeRangeMap = {'Low': 0, 'Medium': 0, 'High': 0};
    for (var person in people) {
      if (person.annualIncome < 50000)
        incomeRangeMap['Low'] = (incomeRangeMap['Low'] ?? 0) + 1;
      else if (person.annualIncome < 100000)
        incomeRangeMap['Medium'] = (incomeRangeMap['Medium'] ?? 0) + 1;
      else
        incomeRangeMap['High'] = (incomeRangeMap['High'] ?? 0) + 1;
    }
    return incomeRangeMap;
  }

  Color _getEducationColor(String education) {
    switch (education) {
      case 'Higher education':
        return Colors.blue;
      case 'Secondary education':
        return Colors.orange;
      case 'Incomplete higher':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color _getAgeGroupColor(String ageGroup) {
    switch (ageGroup) {
      case '20-29':
        return Colors.purple;
      case '30-39':
        return Colors.blue;
      case '40-49':
        return Colors.green;
      case '50+':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Color _getIncomeRangeColor(String incomeRange) {
    switch (incomeRange) {
      case 'Low':
        return Colors.blue;
      case 'Medium':
        return Colors.green;
      case 'High':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Color _getFamilyStatusColor(String familyStatus) {
    switch (familyStatus) {
      case 'Married':
        return Colors.blue;
      case 'Single':
        return Colors.green;
      case 'Civil marriage':
        return Colors.orange;
      case 'Widow':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getHousingTypeColor(String housingType) {
    switch (housingType) {
      case 'House / apartment':
        return Colors.blue;
      case 'With parents':
        return Colors.green;
      case 'Co-op apartment':
        return Colors.orange;
      case 'Rented apartment':
        return Colors.red;
      case 'Office apartment':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
