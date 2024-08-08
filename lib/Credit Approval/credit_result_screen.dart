import 'package:flutter/material.dart';
import 'credit_person.dart';
import 'credit_feature_comparison_graph.dart';
import 'credit_categorical_comparision_graph.dart';
import '../custom_app_bar.dart';

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
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        c: context,
        title: 'Credit Result',
        backButton: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 10),
            _buildProfileItem('Gender', userInput.gender, Icons.person),
            _buildProfileItem('Own Car', userInput.ownCar ? 'Yes' : 'No',
                Icons.directions_car),
            _buildProfileItem('Own Property',
                userInput.ownProperty ? 'Yes' : 'No', Icons.home),
            _buildProfileItem('Number of Children', '${userInput.noOfChildren}',
                Icons.child_care),
            _buildProfileItem('Annual Income', '${userInput.annualIncome}',
                Icons.attach_money),
            _buildProfileItem('Income Type', userInput.incomeType, Icons.work),
            _buildProfileItem(
                'Education Type', userInput.educationType, Icons.school),
            _buildProfileItem(
                'Family Status', userInput.familyStatus, Icons.family_restroom),
            _buildProfileItem(
                'Housing Type', userInput.housingType, Icons.house),
            _buildProfileItem(
                'Years Birth', '${userInput.yearsBirth}', Icons.cake),
            _buildProfileItem('Years Employed', '${userInput.yearsEmployed}',
                Icons.business_center),
            _buildProfileItem('Occupation Type', userInput.occupationType,
                Icons.work_outline),
            _buildProfileItem('Total Family Members',
                '${userInput.totalFamilyMembers}', Icons.groups),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(String label, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blue[900]),
          SizedBox(width: 10),
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
            SizedBox(height: 10),
            Icon(
              userInput.result ? Icons.thumb_up : Icons.thumb_down,
              size: 50,
              color: userInput.result ? Colors.green : Colors.red,
            ),
            SizedBox(height: 10),
            Center(
                child: Text(
              userInput.result
                  ? 'Eligible for Credit'
                  : 'Not Eligible for Credit',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
          ],
        ),
      ),
    );
  }
}
