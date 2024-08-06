import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'loanperson.dart' as loanPersonData;
import 'loan_prediction_page.dart' as loanPredictionPageData;
import '../custom_app_bar.dart';

class LoanGeneralAnalyticsPage extends StatefulWidget {
  @override
  _LoanGeneralAnalyticsPageState createState() =>
      _LoanGeneralAnalyticsPageState();
}

class _LoanGeneralAnalyticsPageState extends State<LoanGeneralAnalyticsPage> {
  int totalClients = 0;
  int acceptedClients = 0;
  int rejectedClients = 0;

  @override
  void initState() {
    super.initState();
    calculateAnalytics();
  }

  void calculateAnalytics() {
    setState(() {
      totalClients = loanPersonData.dummyData.length;
      acceptedClients =
          loanPersonData.dummyData.where((person) => person.loanStatus).length;
      rejectedClients =
          loanPersonData.dummyData.where((person) => !person.loanStatus).length;
    });
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
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        c: context,
        title: 'Loan Prediction',
        backButton: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
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
                  _buildCard('Accepted Clients', acceptedClients.toString()),
                  _buildCard('Rejected Clients', rejectedClients.toString()),
                  _buildCard(
                      'Average Age', _calculateAverageAge().toStringAsFixed(1)),
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
                childAspectRatio: 0.8,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildChartCard(
                      'Marital Status', _buildMaritalStatusPieChart(), [
                    _buildLegendItem(Colors.green, 'Single'),
                    _buildLegendItem(Colors.red, 'Married'),
                  ]),
                  _buildChartCard(
                      'House Ownership', _buildHouseOwnershipChart(), [
                    _buildLegendItem(Colors.blue, 'Owned'),
                    _buildLegendItem(Colors.orange, 'Rented'),
                  ]),
                  _buildChartCard('Car Ownership', _buildCarOwnershipChart(), [
                    _buildLegendItem(Colors.green, 'Yes'),
                    _buildLegendItem(Colors.red, 'No'),
                  ]),
                  _buildChartCard('Profession', _buildProfessionChart(), [
                    _buildLegendItem(Colors.blue, 'Engineer'),
                    _buildLegendItem(Colors.green, 'Teacher'),
                    _buildLegendItem(Colors.red, 'Doctor'),
                    _buildLegendItem(Colors.orange, 'Chef'),
                  ]),
                  _buildChartCard('Loan Status', _buildLoanStatusChart(), [
                    _buildLegendItem(Colors.green, 'Accepted'),
                    _buildLegendItem(Colors.red, 'Denied'),
                  ]),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Top 3 Professions',
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
              child: Container(
                height: 300,
                child: _buildTop3ProfessionsChart(),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Marital Status',
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
              child: Container(
                height: 300,
                child: _buildMaritalStatusBarChart(),
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
                MaterialPageRoute(
                    builder: (context) =>
                        loanPredictionPageData.UserInputForm()),
              );
            },
            label:
                Text('Start Prediction', style: TextStyle(color: Colors.white)),
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Color.fromARGB(255, 34, 34, 34),
          ),
        ),
      ),
    );
  }

  double _calculateAverageAge() {
    if (loanPersonData.dummyData.isEmpty) return 0;
    int totalAge =
        loanPersonData.dummyData.fold(0, (sum, person) => sum + person.age);
    return totalAge / loanPersonData.dummyData.length;
  }

  Widget _buildMaritalStatusPieChart() {
    Map<String, int> maritalStatusData =
        _calculateMaritalStatusData(loanPersonData.dummyData);
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: maritalStatusData.entries.map((entry) {
          return PieChartSectionData(
            color: entry.key == 'Single' ? Colors.green : Colors.red,
            value: entry.value.toDouble(),
            title: '${entry.value}',
            radius: 30,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHouseOwnershipChart() {
    Map<String, int> houseOwnershipData =
        _calculateHouseOwnershipData(loanPersonData.dummyData);
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: houseOwnershipData.entries.map((entry) {
          return PieChartSectionData(
            color: entry.key == 'Owned' ? Colors.blue : Colors.orange,
            value: entry.value.toDouble(),
            title: '${entry.value}',
            radius: 30,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCarOwnershipChart() {
    Map<String, int> carOwnershipData =
        _calculateCarOwnershipData(loanPersonData.dummyData);
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: carOwnershipData.entries.map((entry) {
          return PieChartSectionData(
            color: entry.key == 'Yes' ? Colors.green : Colors.red,
            value: entry.value.toDouble(),
            title: '${entry.value}',
            radius: 30,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProfessionChart() {
    Map<String, int> professionData =
        _calculateProfessionData(loanPersonData.dummyData);
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: professionData.entries.map((entry) {
          Color color;
          switch (entry.key) {
            case 'Engineer':
              color = Colors.blue;
              break;
            case 'Teacher':
              color = Colors.green;
              break;
            case 'Doctor':
              color = Colors.red;
              break;
            case 'Chef':
              color = Colors.orange;
              break;
            default:
              color = Colors.grey;
          }
          return PieChartSectionData(
            color: color,
            value: entry.value.toDouble(),
            title: '${entry.value}',
            radius: 30,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLoanStatusChart() {
    Map<String, int> loanStatusData =
        _calculateLoanStatusData(loanPersonData.dummyData);
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: loanStatusData.entries.map((entry) {
          return PieChartSectionData(
            color: entry.key == 'Accepted' ? Colors.green : Colors.red,
            value: entry.value.toDouble(),
            title: '${entry.value}',
            radius: 30,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTop3ProfessionsChart() {
    Map<String, int> professionData =
        _calculateTop3ProfessionsData(loanPersonData.dummyData);
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: professionData.values.reduce((a, b) => a > b ? a : b).toDouble(),
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                List<String> titles = professionData.keys.toList();
                return Text(
                  titles[value.toInt()],
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                );
              },
              reservedSize: 30,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                return Text(
                  value.toInt().toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                );
              },
              reservedSize: 30,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: professionData.entries
            .map((entry) => BarChartGroupData(
                  x: professionData.keys.toList().indexOf(entry.key),
                  barRods: [
                    BarChartRodData(
                      toY: entry.value.toDouble(),
                      color: Colors.blue,
                      width: 22,
                    )
                  ],
                ))
            .toList(),
      ),
    );
  }

  Widget _buildMaritalStatusBarChart() {
    Map<String, int> maritalStatusData =
        _calculateMaritalStatusData(loanPersonData.dummyData);
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY:
            maritalStatusData.values.reduce((a, b) => a > b ? a : b).toDouble(),
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                List<String> titles = maritalStatusData.keys.toList();
                return Text(
                  titles[value.toInt()],
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                );
              },
              reservedSize: 30,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                return Text(
                  value.toInt().toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                );
              },
              reservedSize: 30,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: maritalStatusData.entries
            .map((entry) => BarChartGroupData(
                  x: maritalStatusData.keys.toList().indexOf(entry.key),
                  barRods: [
                    BarChartRodData(
                      toY: entry.value.toDouble(),
                      color: entry.key == 'Single' ? Colors.green : Colors.red,
                      width: 22,
                    )
                  ],
                ))
            .toList(),
      ),
    );
  }

  Map<String, int> _calculateMaritalStatusData(
      List<loanPersonData.Person> data) {
    final Map<String, int> maritalStatusData = {
      'Single': 0,
      'Married': 0,
    };

    for (var person in data) {
      if (person.maritalStatus == 'Single') {
        maritalStatusData['Single'] = maritalStatusData['Single']! + 1;
      } else if (person.maritalStatus == 'Married') {
        maritalStatusData['Married'] = maritalStatusData['Married']! + 1;
      }
    }

    return maritalStatusData;
  }

  Map<String, int> _calculateHouseOwnershipData(
      List<loanPersonData.Person> data) {
    final Map<String, int> houseOwnershipData = {
      'Owned': 0,
      'Rented': 0,
    };

    for (var person in data) {
      if (person.houseOwnership == 'Owned') {
        houseOwnershipData['Owned'] = houseOwnershipData['Owned']! + 1;
      } else if (person.houseOwnership == 'Rented') {
        houseOwnershipData['Rented'] = houseOwnershipData['Rented']! + 1;
      }
    }

    return houseOwnershipData;
  }

  Map<String, int> _calculateCarOwnershipData(
      List<loanPersonData.Person> data) {
    final Map<String, int> carOwnershipData = {
      'Yes': 0,
      'No': 0,
    };

    for (var person in data) {
      if (person.carOwnership == 'Yes') {
        carOwnershipData['Yes'] = carOwnershipData['Yes']! + 1;
      } else if (person.carOwnership == 'No') {
        carOwnershipData['No'] = carOwnershipData['No']! + 1;
      }
    }

    return carOwnershipData;
  }

  Map<String, int> _calculateProfessionData(List<loanPersonData.Person> data) {
    final Map<String, int> professionData = {
      'Engineer': 0,
      'Teacher': 0,
      'Doctor': 0,
      'Chef': 0,
    };

    for (var person in data) {
      if (person.profession == 'Engineer') {
        professionData['Engineer'] = professionData['Engineer']! + 1;
      } else if (person.profession == 'Teacher') {
        professionData['Teacher'] = professionData['Teacher']! + 1;
      } else if (person.profession == 'Doctor') {
        professionData['Doctor'] = professionData['Doctor']! + 1;
      } else if (person.profession == 'Chef') {
        professionData['Chef'] = professionData['Chef']! + 1;
      }
    }

    return professionData;
  }

  Map<String, int> _calculateLoanStatusData(List<loanPersonData.Person> data) {
    final Map<String, int> loanStatusData = {
      'Accepted': 0,
      'Denied': 0,
    };

    for (var person in data) {
      if (person.loanStatus) {
        loanStatusData['Accepted'] = loanStatusData['Accepted']! + 1;
      } else {
        loanStatusData['Denied'] = loanStatusData['Denied']! + 1;
      }
    }

    return loanStatusData;
  }

  Map<String, int> _calculateTop3ProfessionsData(
      List<loanPersonData.Person> data) {
    final Map<String, int> professionData = {
      'Engineer': 0,
      'Teacher': 0,
      'Doctor': 0,
      'Chef': 0,
    };

    for (var person in data) {
      if (person.profession == 'Engineer') {
        professionData['Engineer'] = professionData['Engineer']! + 1;
      } else if (person.profession == 'Teacher') {
        professionData['Teacher'] = professionData['Teacher']! + 1;
      } else if (person.profession == 'Doctor') {
        professionData['Doctor'] = professionData['Doctor']! + 1;
      } else if (person.profession == 'Chef') {
        professionData['Chef'] = professionData['Chef']! + 1;
      }
    }

    final sortedProfessions = professionData.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return {
      for (var i = 0; i < sortedProfessions.length && i < 3; i++)
        sortedProfessions[i].key: sortedProfessions[i].value
    };
  }
}
