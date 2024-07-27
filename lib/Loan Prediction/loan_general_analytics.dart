import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'loanperson.dart';
import 'loan_prediction_page.dart';

class LoanGeneralAnalyticsPage extends StatefulWidget {
  @override
  _LoanGeneralAnalyticsPageState createState() =>
      _LoanGeneralAnalyticsPageState();
}

class _LoanGeneralAnalyticsPageState extends State<LoanGeneralAnalyticsPage> {
  final List<Map<String, dynamic>> data = dummyData;

  int totalClients = 0;
  Map<String, double> averages = {};

  @override
  void initState() {
    super.initState();
    calculateAnalytics();
  }

  void calculateAnalytics() {
    setState(() {
      totalClients = data.length;
      List<String> numericFields = [
        'income',
        'age',
        'experience',
        'currentJobYears',
        'currentHouseYears'
      ];

      for (var field in numericFields) {
        averages[field] = data.isNotEmpty
            ? data
                    .map((person) => person[field] as int)
                    .reduce((a, b) => a + b) /
                totalClients
            : 0;
      }
    });
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

  Widget _buildTotalClientsChart() {
    Map<String, int> totalClientsData = _calculateTotalClientsData(dummyData);
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: totalClientsData.keys.map((status) {
          Color color = status == 'Accepted' ? Colors.green : Colors.red;
          return PieChartSectionData(
            color: color,
            value: totalClientsData[status]!.toDouble(),
            title: totalClientsData[status].toString(),
            radius: 30,
            titleStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildIncomeChart() {
    Map<String, int> incomeData = _calculateIncomeData(dummyData);
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: incomeData.keys.map((range) {
          Color color;
          switch (range) {
            case '0-45000':
              color = Colors.blue;
              break;
            case '45000-55000':
              color = Colors.green;
              break;
            case '55000-65000':
              color = Colors.orange;
              break;
            case '65000+':
              color = Colors.pink;
              break;
            default:
              color = Colors.grey;
              break;
          }
          return PieChartSectionData(
            color: color,
            value: incomeData[range]!.toDouble(),
            title: incomeData[range].toString(),
            radius: 30,
            titleStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildExperienceChart() {
    Map<String, int> experienceData = _calculateExperienceData(dummyData);
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: experienceData.keys.map((years) {
          Color color;
          switch (years) {
            case '0-5':
              color = Colors.blue;
              break;
            case '5-10':
              color = Colors.green;
              break;
            case '10-15':
              color = Colors.orange;
              break;
            case '15+':
              color = Colors.pink;
              break;
            default:
              color = Colors.grey;
              break;
          }
          return PieChartSectionData(
            color: color,
            value: experienceData[years]!.toDouble(),
            title: experienceData[years].toString(),
            radius: 30,
            titleStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAgeGroupChart() {
    Map<String, int> ageGroupData = _calculateAgeGroupData(dummyData);
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: ageGroupData.keys.map((group) {
          Color color;
          switch (group) {
            case '20-29':
              color = Colors.green;
              break;
            case '30-39':
              color = Colors.blue;
              break;
            case '40-49':
              color = Colors.orange;
              break;
            case '50+':
              color = Colors.pink;
              break;
            default:
              color = Colors.grey;
              break;
          }
          return PieChartSectionData(
            color: color,
            value: ageGroupData[group]!.toDouble(),
            title: ageGroupData[group].toString(),
            radius: 30,
            titleStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCurrentJobYearsChart() {
    Map<String, int> currentJobYearsData =
        _calculateCurrentJobYearsData(dummyData);
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: currentJobYearsData.keys.map((range) {
          Color color;
          switch (range) {
            case '0-2':
              color = Colors.green;
              break;
            case '2-4':
              color = Colors.blue;
              break;
            case '4-6':
              color = Colors.orange;
              break;
            case '6+':
              color = Colors.pink;
              break;
            default:
              color = Colors.grey;
              break;
          }
          return PieChartSectionData(
            color: color,
            value: currentJobYearsData[range]!.toDouble(),
            title: currentJobYearsData[range].toString(),
            radius: 30,
            titleStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCurrentHouseYearsChart() {
    Map<String, int> currentHouseYearsData =
        _calculateCurrentHouseYearsData(dummyData);
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: currentHouseYearsData.keys.map((range) {
          Color color;
          switch (range) {
            case '0-2':
              color = Colors.green;
              break;
            case '2-4':
              color = Colors.blue;
              break;
            case '4-6':
              color = Colors.orange;
              break;
            case '6+':
              color = Colors.pink;
              break;
            default:
              color = Colors.grey;
              break;
          }
          return PieChartSectionData(
            color: color,
            value: currentHouseYearsData[range]!.toDouble(),
            title: currentHouseYearsData[range].toString(),
            radius: 30,
            titleStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMaritalStatusChart() {
    Map<String, int> maritalStatusData = _calculateMaritalStatusData(dummyData);
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: maritalStatusData.keys.map((status) {
          Color color = status == 'Single' ? Colors.orange : Colors.pink;
          return PieChartSectionData(
            color: color,
            value: maritalStatusData[status]!.toDouble(),
            title: maritalStatusData[status].toString(),
            radius: 30,
            titleStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        }).toList(),
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
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Loan Prediction',
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
                  _buildChartCard('Total Clients', _buildTotalClientsChart(), [
                    _buildLegendItem(Colors.green, 'Accepted Client'),
                    _buildLegendItem(Colors.red, 'Denied Client'),
                  ]),
                  _buildChartCard('Income Range', _buildIncomeChart(), [
                    _buildLegendItem(Colors.blue, '0-45000'),
                    _buildLegendItem(Colors.green, '45000-55000'),
                    _buildLegendItem(Colors.orange, '55000-65000'),
                    _buildLegendItem(Colors.pink, '65000+'),
                  ]),
                  _buildChartCard('Experience', _buildExperienceChart(), [
                    _buildLegendItem(Colors.blue, '0-5'),
                    _buildLegendItem(Colors.green, '5-10'),
                    _buildLegendItem(Colors.orange, '10-15'),
                    _buildLegendItem(Colors.pink, '15+'),
                  ]),
                  _buildChartCard('Age Group', _buildAgeGroupChart(), [
                    _buildLegendItem(Colors.green, '20-29'),
                    _buildLegendItem(Colors.blue, '30-39'),
                    _buildLegendItem(Colors.orange, '40-49'),
                    _buildLegendItem(Colors.pink, '50+'),
                  ]),
                  _buildChartCard(
                      'Current Job Years', _buildCurrentJobYearsChart(), [
                    _buildLegendItem(Colors.green, '0-2'),
                    _buildLegendItem(Colors.blue, '2-4'),
                    _buildLegendItem(Colors.orange, '4-6'),
                    _buildLegendItem(Colors.pink, '6+'),
                  ]),
                  _buildChartCard(
                      'Current House Years', _buildCurrentHouseYearsChart(), [
                    _buildLegendItem(Colors.green, '0-2'),
                    _buildLegendItem(Colors.blue, '2-4'),
                    _buildLegendItem(Colors.orange, '4-6'),
                    _buildLegendItem(Colors.pink, '6+'),
                  ]),
                  _buildChartCard(
                      'Marital Status', _buildMaritalStatusChart(), [
                    _buildLegendItem(Colors.orange, 'Single'),
                    _buildLegendItem(Colors.pink, 'Married'),
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
                MaterialPageRoute(builder: (context) => LoanPredictionPage()),
              );
            },
            label:
                Text('Start Prediction', style: TextStyle(color: Colors.white)),
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Color.fromARGB(255, 30, 51, 84),
          ),
        ),
      ),
    );
  }

  Map<String, int> _calculateTotalClientsData(List<Map<String, dynamic>> data) {
    int acceptedCount = data.where((person) {
      var loanStatus = person['loanStatus'];
      return loanStatus != null && loanStatus.toLowerCase() == 'accepted';
    }).length;
    int deniedCount = data.length - acceptedCount;
    return {'Accepted': acceptedCount, 'Denied': deniedCount};
  }

  Map<String, int> _calculateIncomeData(List<Map<String, dynamic>> data) {
    Map<String, int> incomeMap = {
      '0-45000': 0,
      '45000-55000': 0,
      '55000-65000': 0,
      '65000+': 0,
    };
    data.forEach((person) {
      if (person['income'] != null) {
        if (person['income'] >= 0 && person['income'] < 45000) {
          incomeMap['0-45000'] = (incomeMap['0-45000'] ?? 0) + 1;
        } else if (person['income'] >= 45000 && person['income'] < 55000) {
          incomeMap['45000-55000'] = (incomeMap['45000-55000'] ?? 0) + 1;
        } else if (person['income'] >= 55000 && person['income'] < 65000) {
          incomeMap['55000-65000'] = (incomeMap['55000-65000'] ?? 0) + 1;
        } else {
          incomeMap['65000+'] = (incomeMap['65000+'] ?? 0) + 1;
        }
      }
    });
    return incomeMap;
  }

  Map<String, int> _calculateExperienceData(List<Map<String, dynamic>> data) {
    Map<String, int> experienceMap = {
      '0-5': 0,
      '5-10': 0,
      '10-15': 0,
      '15+': 0,
    };
    data.forEach((person) {
      if (person['experience'] != null) {
        if (person['experience'] >= 0 && person['experience'] < 5) {
          experienceMap['0-5'] = (experienceMap['0-5'] ?? 0) + 1;
        } else if (person['experience'] >= 5 && person['experience'] < 10) {
          experienceMap['5-10'] = (experienceMap['5-10'] ?? 0) + 1;
        } else if (person['experience'] >= 10 && person['experience'] < 15) {
          experienceMap['10-15'] = (experienceMap['10-15'] ?? 0) + 1;
        } else {
          experienceMap['15+'] = (experienceMap['15+'] ?? 0) + 1;
        }
      }
    });
    return experienceMap;
  }

  Map<String, int> _calculateAgeGroupData(List<Map<String, dynamic>> data) {
    Map<String, int> ageGroupMap = {
      '20-29': 0,
      '30-39': 0,
      '40-49': 0,
      '50+': 0,
    };
    data.forEach((person) {
      if (person['age'] != null) {
        if (person['age'] >= 20 && person['age'] < 30) {
          ageGroupMap['20-29'] = (ageGroupMap['20-29'] ?? 0) + 1;
        } else if (person['age'] >= 30 && person['age'] < 40) {
          ageGroupMap['30-39'] = (ageGroupMap['30-39'] ?? 0) + 1;
        } else if (person['age'] >= 40 && person['age'] < 50) {
          ageGroupMap['40-49'] = (ageGroupMap['40-49'] ?? 0) + 1;
        } else {
          ageGroupMap['50+'] = (ageGroupMap['50+'] ?? 0) + 1;
        }
      }
    });
    return ageGroupMap;
  }

  Map<String, int> _calculateCurrentJobYearsData(
      List<Map<String, dynamic>> data) {
    Map<String, int> jobYearsMap = {
      '0-2': 0,
      '2-4': 0,
      '4-6': 0,
      '6+': 0,
    };
    data.forEach((person) {
      if (person['currentJobYears'] != null) {
        if (person['currentJobYears'] >= 0 && person['currentJobYears'] < 2) {
          jobYearsMap['0-2'] = (jobYearsMap['0-2'] ?? 0) + 1;
        } else if (person['currentJobYears'] >= 2 &&
            person['currentJobYears'] < 4) {
          jobYearsMap['2-4'] = (jobYearsMap['2-4'] ?? 0) + 1;
        } else if (person['currentJobYears'] >= 4 &&
            person['currentJobYears'] < 6) {
          jobYearsMap['4-6'] = (jobYearsMap['4-6'] ?? 0) + 1;
        } else {
          jobYearsMap['6+'] = (jobYearsMap['6+'] ?? 0) + 1;
        }
      }
    });
    return jobYearsMap;
  }

  Map<String, int> _calculateCurrentHouseYearsData(
      List<Map<String, dynamic>> data) {
    Map<String, int> houseYearsMap = {
      '0-2': 0,
      '2-4': 0,
      '4-6': 0,
      '6+': 0,
    };
    data.forEach((person) {
      if (person['currentHouseYears'] != null) {
        if (person['currentHouseYears'] >= 0 &&
            person['currentHouseYears'] < 2) {
          houseYearsMap['0-2'] = (houseYearsMap['0-2'] ?? 0) + 1;
        } else if (person['currentHouseYears'] >= 2 &&
            person['currentHouseYears'] < 4) {
          houseYearsMap['2-4'] = (houseYearsMap['2-4'] ?? 0) + 1;
        } else if (person['currentHouseYears'] >= 4 &&
            person['currentHouseYears'] < 6) {
          houseYearsMap['4-6'] = (houseYearsMap['4-6'] ?? 0) + 1;
        } else {
          houseYearsMap['6+'] = (houseYearsMap['6+'] ?? 0) + 1;
        }
      }
    });
    return houseYearsMap;
  }

  Map<String, int> _calculateMaritalStatusData(
      List<Map<String, dynamic>> data) {
    Map<String, int> maritalStatusMap = {
      'Single': 0,
      'Married': 0,
    };
    data.forEach((person) {
      if (person['maritalStatus'] != null) {
        if (person['maritalStatus'].toLowerCase() == 'single') {
          maritalStatusMap['Single'] = (maritalStatusMap['Single'] ?? 0) + 1;
        } else if (person['maritalStatus'].toLowerCase() == 'married') {
          maritalStatusMap['Married'] = (maritalStatusMap['Married'] ?? 0) + 1;
        }
      }
    });
    return maritalStatusMap;
  }
}

void main() {
  runApp(MaterialApp(
    home: LoanGeneralAnalyticsPage(),
  ));
}
