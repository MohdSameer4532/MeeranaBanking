import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'deposit_person.dart'; // Import your Person class and dummyData list
import 'deposit_user_input_form.dart'; // Import your UserInputForm widget

class DepositPredictionPage extends StatelessWidget {
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
          'Deposit General Analytics',
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
              // Navigate to user input form
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserInputForm()),
              );
            },
            label: Text('Start Prediction',
                style:
                    TextStyle(color: Colors.white)), // Set text color to white
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

  // Helper methods to calculate data for charts

  Map<String, int> _calculateTotalClientsData(List<Person> data) {
    int acceptedCount = data.where((person) => person.result).length;
    int rejectedCount = data.length - acceptedCount;
    return {'Accepted': acceptedCount, 'Rejected': rejectedCount};
  }

  Map<String, int> _calculateEducationData(List<Person> data) {
    Map<String, int> educationMap = {};
    data.forEach((person) {
      if (educationMap.containsKey(person.education)) {
        educationMap[person.education] = educationMap[person.education]! + 1;
      } else {
        educationMap[person.education] = 1;
      }
    });
    return educationMap;
  }

  Map<String, int> _calculateAgeGroupData(List<Person> data) {
    Map<String, int> ageGroupMap = {
      '20-29': 0,
      '30-39': 0,
      '40-49': 0,
      '50-59': 0,
    };
    data.forEach((person) {
      if (person.age >= 20 && person.age <= 29) {
        ageGroupMap['20-29'] = ageGroupMap['20-29']! + 1;
      } else if (person.age >= 30 && person.age <= 39) {
        ageGroupMap['30-39'] = ageGroupMap['30-39']! + 1;
      } else if (person.age >= 40 && person.age <= 49) {
        ageGroupMap['40-49'] = ageGroupMap['40-49']! + 1;
      } else if (person.age >= 50 && person.age <= 59) {
        ageGroupMap['50-59'] = ageGroupMap['50-59']! + 1;
      }
    });
    return ageGroupMap;
  }

  Map<String, int> _calculateBalanceRangeData(List<Person> data) {
    Map<String, int> balanceRangeMap = {
      '1000+': 0,
      '5000+': 0,
    };
    data.forEach((person) {
      if (person.balance >= 1000 && person.balance < 5000) {
        balanceRangeMap['1000+'] = balanceRangeMap['1000+']! + 1;
      } else if (person.balance >= 5000 && person.balance < 8000) {
        balanceRangeMap['5000+'] = balanceRangeMap['5000+']! + 1;
      }
    });
    return balanceRangeMap;
  }
}
