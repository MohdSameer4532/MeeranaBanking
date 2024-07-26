import 'package:flutter/material.dart';
import 'credit_person.dart';
import 'credit_feature_comparison_graph.dart';
import 'credit_categorical_comparision_graph.dart';

class ResultScreen extends StatelessWidget {
  final CreditPerson userInput;
  final List<CreditPerson> dummyData;

  ResultScreen({
    required this.userInput,
    required this.dummyData,
  });

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
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Credit Result',
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
            _buildSectionTitle('Annual Income Comparison'),
            _buildComparisonSection(
              child: FeatureComparisonGraph(
                dummyData: dummyData,
                userInput: userInput,
                feature: 'annualIncome',
              ),
            ),
            _buildSectionTitle('Days Birth Comparison'),
            _buildComparisonSection(
              child: FeatureComparisonGraph(
                dummyData: dummyData,
                userInput: userInput,
                feature: 'daysBirth',
              ),
            ),
            _buildSectionTitle('Days Employed Comparison'),
            _buildComparisonSection(
              child: FeatureComparisonGraph(
                dummyData: dummyData,
                userInput: userInput,
                feature: 'daysEmployed',
              ),
            ),
            _buildSectionTitle('Number of Children Comparison'),
            _buildComparisonSection(
              child: FeatureComparisonGraph(
                dummyData: dummyData,
                userInput: userInput,
                feature: 'noOfChildren',
              ),
            ),
            _buildSectionTitle('Total Family Members Comparison'),
            _buildComparisonSection(
              child: FeatureComparisonGraph(
                dummyData: dummyData,
                userInput: userInput,
                feature: 'totalFamilyMembers',
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
            _buildSectionTitle('Own Car Comparison'),
            _buildComparisonSection(
              child: CategoricalComparisonGraph(
                dummyData: dummyData,
                userInput: userInput,
                feature: 'ownCar',
              ),
            ),
            _buildSectionTitle('Own Property Comparison'),
            _buildComparisonSection(
              child: CategoricalComparisonGraph(
                dummyData: dummyData,
                userInput: userInput,
                feature: 'ownProperty',
              ),
            ),
            _buildSectionTitle('Income Type Comparison'),
            _buildComparisonSection(
              child: CategoricalComparisonGraph(
                dummyData: dummyData,
                userInput: userInput,
                feature: 'incomeType',
              ),
            ),
            _buildSectionTitle('Education Type Comparison'),
            _buildComparisonSection(
              child: CategoricalComparisonGraph(
                dummyData: dummyData,
                userInput: userInput,
                feature: 'educationType',
              ),
            ),
            _buildSectionTitle('Family Status Comparison'),
            _buildComparisonSection(
              child: CategoricalComparisonGraph(
                dummyData: dummyData,
                userInput: userInput,
                feature: 'familyStatus',
              ),
            ),
            _buildSectionTitle('Housing Type Comparison'),
            _buildComparisonSection(
              child: CategoricalComparisonGraph(
                dummyData: dummyData,
                userInput: userInput,
                feature: 'housingType',
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
            _buildProfileItem('Gender', userInput.gender),
            _buildProfileItem('Own Car', userInput.ownCar ? 'Yes' : 'No'),
            _buildProfileItem('Own Property', userInput.ownProperty ? 'Yes' : 'No'),
            _buildProfileItem('Number of Children', '${userInput.noOfChildren}'),
            _buildProfileItem('Annual Income', '${userInput.annualIncome}'),
            _buildProfileItem('Income Type', userInput.incomeType),
            _buildProfileItem('Education Type', userInput.educationType),
            _buildProfileItem('Family Status', userInput.familyStatus),
            _buildProfileItem('Housing Type', userInput.housingType),
            _buildProfileItem('Days Birth', '${userInput.daysBirth}'),
            _buildProfileItem('Days Employed', '${userInput.daysEmployed}'),
            _buildProfileItem('Occupation Type', userInput.occupationType),
            _buildProfileItem('Total Family Members', '${userInput.totalFamilyMembers}'),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              '$label:',
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
            Icon(
              userInput.result ? Icons.thumb_up : Icons.thumb_down,
              size: 50,
              color: userInput.result ? Colors.green : Colors.red,
            ),
            SizedBox(height: 10),
            Text(
              userInput.result ? 'Eligible for Credit' : 'Not Eligible for Credit',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
