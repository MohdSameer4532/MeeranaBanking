import 'package:flutter/material.dart';
import 'fraud_data.dart';
import 'fraud_feature_comparison_graph.dart';
import 'fraud_categorical_comparison.dart';
import '../custom_app_bar.dart';

class ResultScreen extends StatelessWidget {
  final FraudPerson userInput;

  ResultScreen({required this.userInput, required List dummyData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        c: context,
        title: 'Fraud Detection Result',
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
            _buildSectionTitle('Fraud Detection Result'),
            _buildResultDisplay(),
            _buildSectionTitle('Age Comparison'),
            _buildComparisonSection(
              child: FeatureComparisonGraph(
                dummyData: dummyData,
                userInput: userInput,
                feature: 'age',
              ),
            ),
            _buildSectionTitle('Amount Comparison'),
            _buildComparisonSection(
              child: FeatureComparisonGraph(
                dummyData: dummyData,
                userInput: userInput,
                feature: 'amount',
              ),
            ),
            _buildSectionTitle('Gender Comparison'),
            _buildComparisonSection(
              child: CategoricalComparisonGraph(
                dummyData: dummyData,
                userInput: userInput,
                feature: 'gender',
              ),
            ),
            _buildSectionTitle('Category Comparison'),
            _buildComparisonSection(
              child: CategoricalComparisonGraph(
                dummyData: dummyData,
                userInput: userInput,
                feature: 'category',
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
            _buildSummaryItem('Gender', userInput.gender, Icons.person),
            _buildSummaryItem('Zip Code Origin', userInput.zipcodeOri, Icons.location_on),
            _buildSummaryItem('Merchant', userInput.merchant, Icons.store),
            _buildSummaryItem('Merchant Zip Code', userInput.zipMerchant, Icons.location_city),
            _buildSummaryItem('Category', userInput.category, Icons.category),
            _buildSummaryItem('Amount', '${userInput.amount}', Icons.money),
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
      color: userInput.fraudDetected ? Colors.red[100] : Colors.green[100],
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            Center(
              child: Icon(
                userInput.fraudDetected ? Icons.warning : Icons.check_circle,
                size: 50,
                color: userInput.fraudDetected ? Colors.red : Colors.green,
              ),
            ),
            SizedBox(height: 10),
            Center(
                child: Text(
              userInput.fraudDetected
                  ? 'Fraud Detected'
                  : 'No Fraud Detected',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
          ],
        ),
      ),
    );
  }
}
