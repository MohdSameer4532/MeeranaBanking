import 'package:flutter/material.dart';
import 'deposit_person.dart';
import 'deposit_feature_comparison_graph.dart';
import 'deposit_categorical_comparison_graph.dart';

class ResultScreen extends StatelessWidget {
  final Person userInput;

  ResultScreen({required this.userInput, required List dummyData});

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
          'Deposit Result',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
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
              ),
            ),
            SizedBox(height: 10),
            _buildSummaryItem('Age', '${userInput.age}'),
            _buildSummaryItem('Job', userInput.job),
            _buildSummaryItem('Marital Status', userInput.marital),
            _buildSummaryItem('Education', userInput.education),
            _buildSummaryItem('Balance', '${userInput.balance}'),
            _buildSummaryItem(
              'Personal Loan',
              userInput.personalLoan ? 'Yes' : 'No',
            ),
            _buildSummaryItem(
              'Housing Loan',
              userInput.housingLoan ? 'Yes' : 'No',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            Text(
              'Prediction Result',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              userInput.result
                  ? 'Likely to make a deposit'
                  : 'Unlikely to make a deposit',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
