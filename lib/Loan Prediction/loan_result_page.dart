import 'package:flutter/material.dart';
import 'loanperson.dart';
import 'loan_feature_comparison.dart';
import 'loan_categorical_comparison.dart';
import '../custom_app_bar.dart';

class ResultScreen extends StatelessWidget {
  final Person userInput;
  final List<Person> dummyData;

  ResultScreen({required this.userInput, required this.dummyData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        c: context,
        title: 'Loan Prediction Result',
        backButton: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            _buildUserInputSummary(),
            _buildSectionTitle('Prediction Result'),
            _buildResultDisplay(),
            _buildSectionTitle('Age Comparison'),
            _buildComparisonSection(
              child: FeatureComparisonGraph(
                dummyData: dummyData,
                userInput: userInput,
                feature: 'age',
              ),
            ),
            _buildSectionTitle('Balance Comparison'),
            _buildComparisonSection(
              child: FeatureComparisonGraph(
                dummyData: dummyData,
                userInput: userInput,
                feature: 'balance',
              ),
            ),
            _buildSectionTitle('Education Comparison'),
            _buildComparisonSection(
              child: CategoricalComparisonGraph(
                dummyData: dummyData,
                userInput: userInput,
                feature: 'education',
              ),
            ),
            _buildSectionTitle('Marital Status Comparison'),
            _buildComparisonSection(
              child: CategoricalComparisonGraph(
                dummyData: dummyData,
                userInput: userInput,
                feature: 'maritalStatus',
              ),
            ),
            _buildSectionTitle('Car Ownership Comparison'),
            _buildComparisonSection(
              child: CategoricalComparisonGraph(
                dummyData: dummyData,
                userInput: userInput,
                feature: 'carOwnership',
              ),
            ),
            _buildSectionTitle('House Ownership Comparison'),
            _buildComparisonSection(
              child: CategoricalComparisonGraph(
                dummyData: dummyData,
                userInput: userInput,
                feature: 'houseOwnership',
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInputSummary() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
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
            SizedBox(height: 10),
            _buildSummaryItem(
                'Income', '${userInput.income}', Icons.monetization_on),
            _buildSummaryItem('Age', '${userInput.age}', Icons.cake),
            _buildSummaryItem(
                'Experience', '${userInput.experience}', Icons.work),
            _buildSummaryItem('Current Job Years',
                '${userInput.currentJobYears}', Icons.work),
            _buildSummaryItem('Current House Years',
                '${userInput.currentHouseYears}', Icons.house),
            _buildSummaryItem('Marital Status', userInput.maritalStatus,
                Icons.family_restroom),
            _buildSummaryItem(
                'House Ownership', userInput.houseOwnership, Icons.home),
            _buildSummaryItem(
                'Car Ownership', userInput.carOwnership, Icons.directions_car),
            _buildSummaryItem('Profession', userInput.profession, Icons.work),
            _buildSummaryItem(
                'Loan Status',
                userInput.loanStatus ? 'Accepted' : 'Denied',
                Icons.credit_card),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24.0, color: Colors.blue[900]),
          SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: Text(
              title + ':',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blue[900],
        ),
      ),
    );
  }

  Widget _buildComparisonSection({required Widget child}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          height: 300,
          child: child,
        ),
      ),
    );
  }

  Widget _buildResultDisplay() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: userInput.loanStatus ? Colors.green[100] : Colors.red[100],
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            Center(
              child: Icon(
                userInput.loanStatus ? Icons.thumb_up : Icons.thumb_down,
                size: 50,
                color: userInput.loanStatus ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                userInput.loanStatus ? 'Loan Accepted' : 'Loan Denied',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
