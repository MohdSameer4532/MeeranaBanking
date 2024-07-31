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
      appBar: AppBar(title: Text('Result')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserInputSummary(),
              SizedBox(height: 20),
              _buildResultDisplay(),
              SizedBox(height: 20),
              _buildAgeComparisonSection(),
              SizedBox(height: 20),
              _buildBalanceComparisonSection(),
              SizedBox(height: 20),
              _buildEducationComparisonSection(),
              SizedBox(height: 20),
              _buildMaritalStatusComparisonSection(),
              SizedBox(height: 20),
              _buildPersonalLoanComparisonSection(),
              SizedBox(height: 20),
              _buildHousingLoanComparisonSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInputSummary() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User Input Summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Age: ${userInput.age}'),
            Text('Job: ${userInput.job}'),
            Text('Marital Status: ${userInput.marital}'),
            Text('Education: ${userInput.education}'),
            Text('Balance: ${userInput.balance}'),
            Text('Personal Loan: ${userInput.personalLoan ? 'Yes' : 'No'}'),
            Text('Housing Loan: ${userInput.housingLoan ? 'Yes' : 'No'}'),
          ],
        ),
      ),
    );
  }

  Widget _buildResultDisplay() {
    return Card(
      color: userInput.result ? Colors.green[100] : Colors.red[100],
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Prediction Result',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              userInput.result
                  ? 'Likely to make a deposit'
                  : 'Unlikely to make a deposit',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAgeComparisonSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Age Comparison',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Container(
          height: 300,
          child: FeatureComparisonGraph(
            dummyData: dummyData,
            userInput: userInput,
            feature: 'age',
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceComparisonSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Balance Comparison',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Container(
          height: 300,
          child: FeatureComparisonGraph(
            dummyData: dummyData,
            userInput: userInput,
            feature: 'balance',
          ),
        ),
      ],
    );
  }

  Widget _buildEducationComparisonSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Education Comparison',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Container(
          height: 300,
          child: CategoricalComparisonGraph(
            dummyData: dummyData,
            userInput: userInput,
            feature: 'education',
          ),
        ),
      ],
    );
  }

  Widget _buildMaritalStatusComparisonSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Marital Status Comparison',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Container(
          height: 300,
          child: CategoricalComparisonGraph(
            dummyData: dummyData,
            userInput: userInput,
            feature: 'marital',
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalLoanComparisonSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Personal Loan Comparison',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Container(
          height: 300,
          child: CategoricalComparisonGraph(
            dummyData: dummyData,
            userInput: userInput,
            feature: 'personalLoan',
          ),
        ),
      ],
    );
  }

  Widget _buildHousingLoanComparisonSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Housing Loan Comparison',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Container(
          height: 300,
          child: CategoricalComparisonGraph(
            dummyData: dummyData,
            userInput: userInput,
            feature: 'housingLoan',
          ),
        ),
      ],
    );
  }
}
