import 'package:flutter/material.dart';
import 'deposit_person.dart';
import 'deposit_feature_comparison_graph.dart';
import 'deposit_categorical_comparison_graph.dart';
import '../custom_app_bar.dart';

class ResultScreen extends StatelessWidget {
  final Person userInput;

  ResultScreen({required this.userInput, required List dummyData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color of the Scaffold
      appBar: CustomAppBar(
        c: context,
        title: 'Deposit Result',
        backButton: true, // Enable back button
        backgroundColor: Color.fromARGB(
            255, 255, 255, 255), // Set the background color of the AppBar
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
                feature: 'marital',
              ),
            ),
            _buildSectionTitle('Personal Loan Comparison'),
            _buildComparisonSection(
              child: CategoricalComparisonGraph(
                dummyData: dummyData,
                userInput: userInput,
                feature: 'personalLoan',
              ),
            ),
            _buildSectionTitle('Housing Loan Comparison'),
            _buildComparisonSection(
              child: CategoricalComparisonGraph(
                dummyData: dummyData,
                userInput: userInput,
                feature: 'housingLoan',
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
            _buildSummaryItem('Age', '${userInput.age}', Icons.cake),
            _buildSummaryItem('Job', userInput.job, Icons.work),
            _buildSummaryItem(
                'Marital Status', userInput.marital, Icons.family_restroom),
            _buildSummaryItem('Education', userInput.education, Icons.school),
            _buildSummaryItem('Balance', '${userInput.balance}', Icons.money),
            _buildSummaryItem(
              'Personal Loan',
              userInput.personalLoan ? 'Yes' : 'No',
              Icons.credit_card,
            ),
            _buildSummaryItem(
              'Housing Loan',
              userInput.housingLoan ? 'Yes' : 'No',
              Icons.home,
            ),
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
      color: userInput.result ? Colors.green[100] : Colors.red[100],
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            Center(
              child: Icon(
                userInput.result ? Icons.thumb_up : Icons.thumb_down,
                size: 50,
                color: userInput.result ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 10),
            Center(
                child: Text(
              userInput.result
                  ? 'Likely to make a deposit'
                  : 'Unlikely to make a deposit',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
          ],
        ),
      ),
    );
  }
}
