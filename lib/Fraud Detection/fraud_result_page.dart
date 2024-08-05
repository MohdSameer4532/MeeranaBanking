import 'package:flutter/material.dart';
import 'fraud_data.dart';
import 'fraud_feature_comparison_graph.dart';
import '../custom_app_bar.dart';
import 'package:fl_chart/fl_chart.dart';

class FraudResultPage extends StatefulWidget {
  final FraudPerson userInput;
  final List<FraudPerson> dummyData;

  FraudResultPage({
    required this.userInput,
    required this.dummyData,
  });

  @override
  _FraudResultPageState createState() => _FraudResultPageState();
}

class _FraudResultPageState extends State<FraudResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        c: context,
        title: 'Fraud Result',
        backButton: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              _buildUserInputSummary(),
              SizedBox(height: 20),
              _buildFraudDetectionInfo(),
              SizedBox(height: 20),
              _buildComparisonSection('Age Comparison', 'age'),
              SizedBox(height: 20),
              _buildComparisonSection('Amount Comparison', 'amount'),
              SizedBox(height: 20),
              _buildComparisonSection(
                  'Gender Comparison', 'gender'), // Gender comparison
              SizedBox(height: 20),
              _buildComparisonSection(
                  'Category Comparison', 'category'), // Category comparison
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInputSummary() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Input Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 16),
            _buildProfileItem(
                Icons.person, 'Customer', widget.userInput.customer),
            _buildProfileItem(
                Icons.cake, 'Age', widget.userInput.age.toString()),
            _buildProfileItem(Icons.male, 'Gender', widget.userInput.gender),
            _buildProfileItem(Icons.location_on, 'Zip Code Origin',
                widget.userInput.zipcodeOri),
            _buildProfileItem(
                Icons.store, 'Merchant', widget.userInput.merchant),
            _buildProfileItem(Icons.location_city, 'Zip Merchant',
                widget.userInput.zipMerchant),
            _buildProfileItem(
                Icons.category, 'Category', widget.userInput.category),
            _buildProfileItem(Icons.attach_money, 'Amount',
                widget.userInput.amount.toStringAsFixed(2)),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 28, color: const Color.fromARGB(255, 146, 211, 205)),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$label: ', style: TextStyle(fontWeight: FontWeight.w500)),
              Text(value),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFraudDetectionInfo() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.thumb_up, color: Colors.green, size: 70),
                SizedBox(width: 10, height: 100),
                Text(
                  'No Fraud Detected',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonSection(String title, String feature) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        SizedBox(height: 10),
        Card(
          elevation: 5,
          child: FeatureComparisonGraph(
            dummyData: widget.dummyData,
            userInput: widget.userInput,
            feature: feature,
          ),
        ),
      ],
    );
  }

  List<LineChartBarData> _generateLineData(String feature) {
    switch (feature) {
      case 'gender':
        return _genderComparisonData();
      case 'age':
        return _ageComparisonData();
      case 'ageAmount':
        return _ageAmountComparisonData();
      case 'categoryGender':
        return _categoryGenderComparisonData();
      default:
        return [];
    }
  }

  List<LineChartBarData> _genderComparisonData() {
    return [
      LineChartBarData(
        spots: _generateGenderComparisonSpots(),
        isCurved: true,
        color: Colors.blue,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
      ),
    ];
  }

  List<FlSpot> _generateGenderComparisonSpots() {
    return [
      FlSpot(0, 1),
      FlSpot(1, 3),
      FlSpot(2, 2),
      FlSpot(3, 4),
    ];
  }

  List<LineChartBarData> _ageComparisonData() {
    return [
      LineChartBarData(
        spots: _generateAgeComparisonSpots(),
        isCurved: true,
        color: Colors.green,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
      ),
    ];
  }

  List<FlSpot> _generateAgeComparisonSpots() {
    return [
      FlSpot(0, 25),
      FlSpot(1, 30),
      FlSpot(2, 35),
      FlSpot(3, 40),
    ];
  }

  List<LineChartBarData> _ageAmountComparisonData() {
    return [
      LineChartBarData(
        spots: _generateAgeAmountComparisonSpots(),
        isCurved: true,
        color: Colors.red,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
      ),
    ];
  }

  List<FlSpot> _generateAgeAmountComparisonSpots() {
    return [
      FlSpot(0, 500),
      FlSpot(1, 1000),
      FlSpot(2, 1500),
      FlSpot(3, 2000),
    ];
  }

  List<LineChartBarData> _categoryGenderComparisonData() {
    return [
      LineChartBarData(
        spots: _generateCategoryGenderComparisonSpots(),
        isCurved: true,
        color: Colors.orange,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
      ),
    ];
  }

  List<FlSpot> _generateCategoryGenderComparisonSpots() {
    return [
      FlSpot(0, 1),
      FlSpot(1, 2),
      FlSpot(2, 3),
      FlSpot(3, 4),
    ];
  }
}
