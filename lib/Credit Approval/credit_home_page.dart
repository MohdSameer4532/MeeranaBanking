import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'credit_person.dart';
import 'credit_user_input_page.dart';
import '../custom_app_bar.dart';

class CreditHomePage extends StatefulWidget {
  CreditHomePage({Key? key}) : super(key: key);

  @override
  _CreditHomePageState createState() => _CreditHomePageState();
}

class _CreditHomePageState extends State<CreditHomePage> {
  List<CreditPerson> people = [];
  double? averageAge;
  double? averageIncome;
  String? mostCommonHousingType;
  double? goodCustomerPercentage;

  @override
  void initState() {
    super.initState();
    people = dummyCreditData;
    _calculateAverages();
  }

  void _calculateAverages() {
    if (people.isNotEmpty) {
      averageAge = people.map((p) => p.yearsBirth).reduce((a, b) => a + b) / people.length;
      averageIncome = people.map((p) => p.annualIncome).reduce((a, b) => a + b) / people.length;
      
      Map<String, int> housingTypeCounts = {};
      for (var person in people) {
        housingTypeCounts[person.housingType] = (housingTypeCounts[person.housingType] ?? 0) + 1;
      }
      mostCommonHousingType = housingTypeCounts.entries
          .reduce((a, b) => a.value > b.value ? a : b)
          .key;

      int goodCustomers = people.where((p) => p.result).length;
      goodCustomerPercentage = (goodCustomers / people.length) * 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        c: context,
        title: 'Credit Approval',
        backButton: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Overall Statistics',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildStatisticCard('Average Age', '${averageAge?.toStringAsFixed(1) ?? 'N/A'} years'),
                  _buildStatisticCard('Average Income', '\$${averageIncome?.toStringAsFixed(2) ?? 'N/A'}'),
                  _buildStatisticCard('Most Common Housing Type', mostCommonHousingType ?? 'N/A'),
                  _buildStatisticCard('Good Customer Percentage', '${goodCustomerPercentage?.toStringAsFixed(1) ?? 'N/A'}%'),
                  _buildStatisticCard('Bad Customer Percentage', '${goodCustomerPercentage != null ? (100 - goodCustomerPercentage!).toStringAsFixed(1) : 'N/A'}%'),
                ],
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
                  // Empty card
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    color: Colors.white,
                    child: Center(
                      child: Text(''),
                    ),
                  ),
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
          backgroundColor: Color.fromARGB(255, 34, 34, 34),
        ),
      ),
    );
  }

  Widget _buildStatisticCard(String title, String value) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(0),
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
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
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

  Map<String, int> _calculateCategoryData(List<String> categories) {
    Map<String, int> categoryCounts = {};
    for (var category in categories) {
      categoryCounts[category] = (categoryCounts[category] ?? 0) + 1;
    }
    return categoryCounts;
  }

  Map<String, int> _calculateAgeGroupData() {
    Map<String, int> ageGroupCounts = {};
    for (var person in people) {
      String ageGroup;
      if (person.yearsBirth < 30) {
        ageGroup = '20-29';
      } else if (person.yearsBirth < 40) {
        ageGroup = '30-39';
      } else if (person.yearsBirth < 50) {
        ageGroup = '40-49';
      } else {
        ageGroup = '50+';
      }
      ageGroupCounts[ageGroup] = (ageGroupCounts[ageGroup] ?? 0) + 1;
    }
    return ageGroupCounts;
  }

  Map<String, int> _calculateIncomeRangeData() {
    Map<String, int> incomeRangeCounts = {};
    for (var person in people) {
      String incomeRange;
      if (person.annualIncome < 50000) {
        incomeRange = 'Low';
      } else if (person.annualIncome < 100000) {
        incomeRange = 'Medium';
      } else {
        incomeRange = 'High';
      }
      incomeRangeCounts[incomeRange] = (incomeRangeCounts[incomeRange] ?? 0) + 1;
    }
    return incomeRangeCounts;
  }

  Color _getEducationColor(String educationType) {
    switch (educationType) {
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
