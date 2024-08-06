import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'person.dart'; // Import your Person class and dummyData list
import 'user_input_form.dart'; // Import your UserInputForm widget
import '../custom_app_bar.dart';

class DepositPredictionPage extends StatefulWidget {
  @override
  _DepositPredictionPageState createState() => _DepositPredictionPageState();
}

class _DepositPredictionPageState extends State<DepositPredictionPage> {
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
      totalClients = dummyData.length;
      acceptedClients = dummyData.where((person) => person.result).length;
      rejectedClients = dummyData.where((person) => !person.result).length;
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
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
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
        title: 'Deposit Prediction',
        backButton: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
                  _buildCard('Likely Clients', acceptedClients.toString()),
                  _buildCard('Unlikely Clients', rejectedClients.toString()),
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
                childAspectRatio: 0.68,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildChartCard('Total Clients', _buildTotalClientsChart(), [
                    _buildLegendItem(Colors.green, 'Accepted Client'),
                    _buildLegendItem(Colors.red, 'Rejected Client'),
                  ]),
                  _buildChartCard('Education', _buildEducationChart(), [
                    _buildLegendItem(Colors.blue, 'Primary'),
                    _buildLegendItem(
                        Color.fromARGB(255, 91, 102, 161), 'Secondary'),
                    _buildLegendItem(Colors.indigo, 'Tertiary'),
                  ]),
                  _buildChartCard('Age Group', _buildAgeGroupChart(), [
                    _buildLegendItem(Colors.green, '20-29'),
                    _buildLegendItem(Colors.blue, '30-39'),
                    _buildLegendItem(Colors.orange, '40-49'),
                    _buildLegendItem(Colors.pink, '50-59'),
                  ]),
                  _buildChartCard('Balance Range', _buildBalanceRangeChart(), [
                    _buildLegendItem(Colors.green, '1000+'),
                    _buildLegendItem(Colors.blue, '5000+'),
                  ]),
                  _buildChartCard(
                      'Marital Status', _buildMaritalStatusChart(), [
                    _buildLegendItem(Colors.green, 'Single'),
                    _buildLegendItem(Colors.red, 'Married'),
                    _buildLegendItem(
                        Color.fromARGB(255, 6, 112, 160), 'Divorced'),
                  ]),
                  _buildChartCard('Personal Loan', _buildPersonalLoanChart(), [
                    _buildLegendItem(Colors.green, 'True'),
                    _buildLegendItem(Colors.red, 'False'),
                  ]),
                  _buildChartCard('Housing Loan', _buildHousingLoanChart(), [
                    _buildLegendItem(Colors.green, 'True'),
                    _buildLegendItem(Colors.red, 'False'),
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
                MaterialPageRoute(builder: (context) => UserInputForm()),
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
    if (dummyData.isEmpty) return 0;
    int totalAge = dummyData.fold(0, (sum, person) => sum + person.age);
    return totalAge / dummyData.length;
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

  Widget _buildEducationChart() {
    Map<String, int> educationData = _calculateEducationData(dummyData);
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: educationData.keys.map((level) {
          Color color;
          switch (level) {
            case 'primary':
              color = Colors.blue;
              break;
            case 'secondary':
              color = Color.fromARGB(255, 91, 102, 161);
              break;
            case 'tertiary':
              color = Colors.indigo;
              break;
            default:
              color = Colors.grey;
              break;
          }
          return PieChartSectionData(
            color: color,
            value: educationData[level]!.toDouble(),
            title: educationData[level].toString(),
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
            case '50-59':
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

  Widget _buildBalanceRangeChart() {
    Map<String, int> balanceRangeData = _calculateBalanceRangeData(dummyData);
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: balanceRangeData.keys.map((range) {
          Color color;
          switch (range) {
            case '1000+':
              color = Colors.green;
              break;
            case '5000+':
              color = Colors.blue;
              break;
            default:
              color = Colors.grey;
              break;
          }
          return PieChartSectionData(
            color: color,
            value: balanceRangeData[range]!.toDouble(),
            title: balanceRangeData[range].toString(),
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
          Color color;
          switch (status) {
            case 'single':
              color = Colors.green;
              break;
            case 'married':
              color = Colors.red;
              break;
            case 'divorced':
              color = Color.fromARGB(255, 6, 112, 160);
              break;
            default:
              color = Colors.grey;
              break;
          }
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

  Widget _buildPersonalLoanChart() {
    Map<String, int> personalLoanData = _calculatePersonalLoanData(dummyData);
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: personalLoanData.keys.map((loan) {
          Color color = loan == 'true' ? Colors.green : Colors.red;
          return PieChartSectionData(
            color: color,
            value: personalLoanData[loan]!.toDouble(),
            title: personalLoanData[loan].toString(),
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

  Widget _buildHousingLoanChart() {
    Map<String, int> housingLoanData = _calculateHousingLoanData(dummyData);
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: housingLoanData.keys.map((loan) {
          Color color = loan == 'true' ? Colors.green : Colors.red;
          return PieChartSectionData(
            color: color,
            value: housingLoanData[loan]!.toDouble(),
            title: housingLoanData[loan].toString(),
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

  Map<String, int> _calculateTotalClientsData(List<Person> dummyData) {
    Map<String, int> totalClientsData = {'Accepted': 0, 'Rejected': 0};

    for (var person in dummyData) {
      if (person.result) {
        totalClientsData['Accepted'] = totalClientsData['Accepted']! + 1;
      } else {
        totalClientsData['Rejected'] = totalClientsData['Rejected']! + 1;
      }
    }

    return totalClientsData;
  }

  Map<String, int> _calculateEducationData(List<Person> dummyData) {
    Map<String, int> educationData = {
      'primary': 0,
      'secondary': 0,
      'tertiary': 0
    };

    for (var person in dummyData) {
      switch (person.education) {
        case 'primary':
          educationData['primary'] = educationData['primary']! + 1;
          break;
        case 'secondary':
          educationData['secondary'] = educationData['secondary']! + 1;
          break;
        case 'tertiary':
          educationData['tertiary'] = educationData['tertiary']! + 1;
          break;
      }
    }

    return educationData;
  }

  Map<String, int> _calculateAgeGroupData(List<Person> dummyData) {
    Map<String, int> ageGroupData = {
      '20-29': 0,
      '30-39': 0,
      '40-49': 0,
      '50-59': 0
    };

    for (var person in dummyData) {
      int age = person.age; // Use the age directly from the Person object
      if (age >= 20 && age <= 29) {
        ageGroupData['20-29'] = ageGroupData['20-29']! + 1;
      } else if (age >= 30 && age <= 39) {
        ageGroupData['30-39'] = ageGroupData['30-39']! + 1;
      } else if (age >= 40 && age <= 49) {
        ageGroupData['40-49'] = ageGroupData['40-49']! + 1;
      } else if (age >= 50 && age <= 59) {
        ageGroupData['50-59'] = ageGroupData['50-59']! + 1;
      }
    }

    return ageGroupData;
  }

  Map<String, int> _calculateBalanceRangeData(List<Person> dummyData) {
    Map<String, int> balanceRangeData = {'1000+': 0, '5000+': 0};

    for (var person in dummyData) {
      int balance =
          person.balance; // Use the balance directly from the Person object
      if (balance >= 1000 && balance < 5000) {
        balanceRangeData['1000+'] = balanceRangeData['1000+']! + 1;
      } else if (balance >= 5000) {
        balanceRangeData['5000+'] = balanceRangeData['5000+']! + 1;
      }
    }

    return balanceRangeData;
  }

  Map<String, int> _calculateMaritalStatusData(List<Person> dummyData) {
    Map<String, int> maritalStatusData = {
      'single': 0,
      'married': 0,
      'divorced': 0
    };

    for (var person in dummyData) {
      switch (person.marital) {
        case 'single':
          maritalStatusData['single'] = maritalStatusData['single']! + 1;
          break;
        case 'married':
          maritalStatusData['married'] = maritalStatusData['married']! + 1;
          break;
        case 'divorced':
          maritalStatusData['divorced'] = maritalStatusData['divorced']! + 1;
          break;
      }
    }

    return maritalStatusData;
  }

  Map<String, int> _calculatePersonalLoanData(List<Person> dummyData) {
    Map<String, int> personalLoanData = {'true': 0, 'false': 0};

    for (var person in dummyData) {
      if (person.personalLoan) {
        personalLoanData['true'] = personalLoanData['true']! + 1;
      } else {
        personalLoanData['false'] = personalLoanData['false']! + 1;
      }
    }

    return personalLoanData;
  }

  Map<String, int> _calculateHousingLoanData(List<Person> dummyData) {
    Map<String, int> housingLoanData = {'true': 0, 'false': 0};

    for (var person in dummyData) {
      if (person.housingLoan) {
        housingLoanData['true'] = housingLoanData['true']! + 1;
      } else {
        housingLoanData['false'] = housingLoanData['false']! + 1;
      }
    }

    return housingLoanData;
  }
}
