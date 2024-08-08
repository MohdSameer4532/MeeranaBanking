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
  List<loanPersonData.Person> people = [];
  int totalClients = 0;
  int acceptedClients = 0;
  int rejectedClients = 0;
  double? averageAge;
  double? averageIncome;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      people = loanPersonData.dummyData;
      totalClients = people.length;
      _calculateAnalytics();
    });
  }

  void _calculateAnalytics() {
    setState(() {
      acceptedClients = people.where((person) => person.loanStatus).length;
      rejectedClients = people.where((person) => !person.loanStatus).length;
      averageAge =
          people.map((p) => p.age).reduce((a, b) => a + b) / people.length;
      averageIncome =
          people.map((p) => p.income).reduce((a, b) => a + b) / people.length;
    });
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
                  _buildStatisticCard('Total Clients', '$totalClients'),
                  _buildStatisticCard('Accepted Clients', '$acceptedClients'),
                  _buildStatisticCard('Denied Clients', '$rejectedClients'),
                  _buildStatisticCard('Average Income',
                      '${averageIncome?.toStringAsFixed(1) ?? 'N/A'}'),
                ],
              ),
            ),
            _buildTwoChartRow(
              'Loan Status',
              _buildLoanStatusChart(),
              [
                _buildLegendItem(Colors.green, 'Accepted'),
                _buildLegendItem(Colors.red, 'Rejected'),
              ],
              'Marital Status',
              _buildMaritalStatusChart(),
              [
                _buildLegendItem(Colors.blue, 'Single'),
                _buildLegendItem(Colors.orange, 'Married'),
                _buildLegendItem(Colors.green, 'Divorced'),
              ],
            ),
            _buildChartSection(
              'Marital Status Distribution',
              _buildMaritalStatusBarChart(),
              [
                _buildLegendItem(Colors.blue, 'Single'),
                _buildLegendItem(Colors.orange, 'Married'),
                _buildLegendItem(Colors.green, 'Divorced'),
              ],
            ),
            _buildTwoChartRow(
              'Age Group',
              _buildAgeGroupChart(),
              [
                _buildLegendItem(Colors.green, '20-29'),
                _buildLegendItem(Colors.blue, '30-39'),
                _buildLegendItem(Colors.orange, '40-49'),
                _buildLegendItem(Colors.pink, '50-59'),
              ],
              'Income Range',
              _buildIncomeRangeChart(),
              [
                _buildLegendItem(Colors.blue, 'Low'),
                _buildLegendItem(Colors.green, 'Medium'),
                _buildLegendItem(Colors.orange, 'High'),
              ],
            ),
            _buildChartSection(
              'Age vs Income',
              _buildAgeIncomeScatterPlot(),
              [],
            ),
            _buildTwoChartRow(
              'House Ownership',
              _buildHouseOwnershipChart(),
              [
                _buildLegendItem(Colors.blue, 'Owned'),
                _buildLegendItem(Colors.green, 'Rented'),
              ],
              'Car Ownership',
              _buildCarOwnershipChart(),
              [
                _buildLegendItem(Colors.green, 'Yes'),
                _buildLegendItem(Colors.red, 'No'),
              ],
            ),
            _buildChartSection(
              'House Ownership Distribution',
              _buildHouseOwnershipBarChart(),
              [
                _buildLegendItem(Colors.blue, 'Owned'),
                _buildLegendItem(Colors.green, 'Rented'),
              ],
            ),
            _buildChartSection(
              'Car Ownership Distribution',
              _buildCarOwnershipBarChart(),
              [
                _buildLegendItem(Colors.green, 'Yes'),
                _buildLegendItem(Colors.red, 'No'),
              ],
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
              MaterialPageRoute(
                  builder: (context) => loanPredictionPageData.UserInputForm()),
            );
          },
          label:
              Text('Start Prediction', style: TextStyle(color: Colors.white)),
          icon: Icon(Icons.add, color: Colors.white),
          backgroundColor: Color.fromARGB(255, 34, 34, 34),
        ),
      ),
    );
  }

  Widget _buildTwoChartRow(String title1, Widget chart1, List<Widget> legend1,
      String title2, Widget chart2, List<Widget> legend2) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildChartCard(title1, chart1, legend1),
          ),
          SizedBox(width: 16),
          Expanded(
            child: _buildChartCard(title2, chart2, legend2),
          ),
        ],
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 200,
              width: double.infinity,
              child: chart,
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: legendItems,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticCard(String title, String value) {
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
                fontWeight: FontWeight.normal, // Make the title bold
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

  Widget _buildChartSection(
      String title, Widget chart, List<Widget> legendItems) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
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
              SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: chart,
              ),
              SizedBox(height: 8),
              ...legendItems,
            ],
          ),
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

  Widget _buildLoanStatusChart() {
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: [
          PieChartSectionData(
            color: Colors.green,
            value: acceptedClients.toDouble(),
            title: acceptedClients.toString(),
            radius: 30,
            titleStyle: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            color: Colors.red,
            value: rejectedClients.toDouble(),
            title: rejectedClients.toString(),
            radius: 30,
            titleStyle: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildMaritalStatusChart() {
    Map<String, int> maritalStatusData =
        _calculateCategoryData(people.map((p) => p.maritalStatus).toList());
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: maritalStatusData.entries.map((entry) {
          return PieChartSectionData(
            color: entry.key == 'Single' ? Colors.blue : Colors.orange, 
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

  Widget _buildHouseOwnershipChart() {
    Map<String, int> houseOwnershipData =
        _calculateCategoryData(people.map((p) => p.houseOwnership).toList());
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: houseOwnershipData.entries.map((entry) {
          return PieChartSectionData(
            color: entry.key == 'Owned' ? Colors.blue : Colors.green,
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

  Widget _buildCarOwnershipChart() {
    Map<String, int> carOwnershipData =
        _calculateCategoryData(people.map((p) => p.carOwnership).toList());
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: carOwnershipData.entries.map((entry) {
          return PieChartSectionData(
            color: entry.key == 'Yes' ? Colors.green : Colors.red,
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
    Map<String, int> ageGroups = {
      '20-29': 0,
      '30-39': 0,
      '40-49': 0,
      '50-59': 0,
    };
    for (var person in people) {
      if (person.age >= 20 && person.age < 30) {
        ageGroups['20-29'] = ageGroups['20-29']! + 1;
      } else if (person.age >= 30 && person.age < 40) {
        ageGroups['30-39'] = ageGroups['30-39']! + 1;
      } else if (person.age >= 40 && person.age < 50) {
        ageGroups['40-49'] = ageGroups['40-49']! + 1;
      } else if (person.age >= 50 && person.age < 60) {
        ageGroups['50-59'] = ageGroups['50-59']! + 1;
      }
    }
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: ageGroups.entries.map((entry) {
          Color color;
          switch (entry.key) {
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
          }
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
    Map<String, int> incomeRanges = {
      'Low': 0,
      'Medium': 0,
      'High': 0,
    };

    for (var person in people) {
      if (person.income < 50000) {
        incomeRanges['Low'] = incomeRanges['Low']! + 1;
      } else if (person.income >= 50000 && person.income < 100000) {
        incomeRanges['Medium'] = incomeRanges['Medium']! + 1;
      } else {
        incomeRanges['High'] = incomeRanges['High']! + 1;
      }
    }

    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 22,
        sections: incomeRanges.entries.map((entry) {
          Color color;
          switch (entry.key) {
            case 'Low':
              color = Colors.blue;
              break;
            case 'Medium':
              color = Colors.green;
              break;
            case 'High':
              color = Colors.orange;
              break;
            default:
              color = Colors.grey;
          }
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

  Widget _buildMaritalStatusBarChart() {
    Map<String, int> maritalStatusData =
        _calculateCategoryData(people.map((p) => p.maritalStatus).toList());
    return _buildBarChart(maritalStatusData, Colors.blue, Colors.orange);
  }

  Widget _buildHouseOwnershipBarChart() {
    Map<String, int> houseOwnershipData =
        _calculateCategoryData(people.map((p) => p.houseOwnership).toList());
    return _buildBarChart(houseOwnershipData, Colors.blue, Colors.green);
  }

  Widget _buildCarOwnershipBarChart() {
    Map<String, int> carOwnershipData =
        _calculateCategoryData(people.map((p) => p.carOwnership).toList());
    return _buildBarChart(carOwnershipData, Colors.green, Colors.red);
  }

  Widget _buildBarChart(Map<String, int> data, Color color1, Color color2) {
    final maxY = data.values.reduce((a, b) => a > b ? a : b).toDouble();
    final interval = (maxY / 5).ceil().toDouble();

    return BarChart(
      BarChartData(
        barGroups: data.entries.map((entry) {
          return BarChartGroupData(
            x: data.keys.toList().indexOf(entry.key),
            barRods: [
              BarChartRodData(
                toY: entry.value.toDouble(),
                color: entry.key == data.keys.first ? color1 : color2,
                width: 20,
                borderRadius: BorderRadius.circular(3),
              ),
            ],
          );
        }).toList(),
        borderData: FlBorderData(show: true),
        maxY: maxY + interval,
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: interval,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                const style = TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                );
                List<String> titles = data.keys.toList();
                String text =
                    value.toInt() < titles.length ? titles[value.toInt()] : '';
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 4,
                  child: Text(text, style: style),
                );
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          horizontalInterval: interval,
          drawVerticalLine: false,
        ),
      ),
    );
  }

  Widget _buildAgeIncomeScatterPlot() {
    List<ScatterSpot> spots = people.map((person) {
      return ScatterSpot(
        person.age.toDouble(),
        person.income.toDouble(),
      );
    }).toList();

    return ScatterChart(
      ScatterChartData(
        scatterSpots: spots,
        minX: 20,
        maxX: 60,
        minY: 0,
        maxY: 300000, // Adjusted to accommodate full income values
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              interval: 10,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) => Text(
                '\$${(value / 1000).toInt()}k',
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              interval: 50000, // Adjusted interval
              reservedSize: 40, // Increased reserved size for labels
            ),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: true,
          horizontalInterval: 50000, // Adjusted to match Y-axis interval
        ),
        borderData: FlBorderData(show: true),
        scatterTouchData: ScatterTouchData(
          touchTooltipData: ScatterTouchTooltipData(
            getTooltipItems: (ScatterSpot touchedBarSpot) {
              return ScatterTooltipItem(
                'Age: ${touchedBarSpot.x.toInt()}\nIncome: \$${touchedBarSpot.y.toInt()}',
                textStyle: TextStyle(color: Colors.white),
                bottomMargin: 10,
              );
            },
          ),
        ),
      ),
    );
  }

  Map<String, int> _calculateCategoryData(List<String> categories) {
    Map<String, int> categoryData = {};
    for (var category in categories) {
      categoryData[category] = (categoryData[category] ?? 0) + 1;
    }
    return categoryData;
  }
}
