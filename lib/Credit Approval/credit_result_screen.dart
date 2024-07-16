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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, const Color.fromARGB(255, 209, 230, 228)],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserInputSummary(),
                SizedBox(height: 20),
                _buildResultDisplay(),
                SizedBox(height: 20),
                _buildComparisonSection('Annual Income Comparison', 'annualIncome'),
                SizedBox(height: 20),
                _buildComparisonSection('Days Birth Comparison', 'daysBirth'),
                SizedBox(height: 20),
                _buildComparisonSection('Days Employed Comparison', 'daysEmployed'),
                SizedBox(height: 20),
                _buildComparisonSection('Number of Children Comparison', 'noOfChildren'),
                SizedBox(height: 20),
                _buildComparisonSection('Total Family Members Comparison', 'totalFamilyMembers'),
                SizedBox(height: 20),
                _buildComparisonSection('Gender Comparison', 'gender'),
                SizedBox(height: 20),
                _buildComparisonSection('Own Car Comparison', 'ownCar'),
                SizedBox(height: 20),
                _buildComparisonSection('Own Property Comparison', 'ownProperty'),
                SizedBox(height: 20),
                _buildComparisonSection('Income Type Comparison', 'incomeType'),
                SizedBox(height: 20),
                _buildComparisonSection('Education Type Comparison', 'educationType'),
                SizedBox(height: 20),
                _buildComparisonSection('Family Status Comparison', 'familyStatus'),
                SizedBox(height: 20),
                _buildComparisonSection('Housing Type Comparison', 'housingType'),
                 
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInputSummary() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your Profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[900])),
            SizedBox(height: 10),
            _buildProfileItem(Icons.person, 'Gender', userInput.gender),
            _buildProfileItem(Icons.car_rental, 'Own Car', userInput.ownCar ? 'Yes' : 'No'),
            _buildProfileItem(Icons.home, 'Own Property', userInput.ownProperty ? 'Yes' : 'No'),
            _buildProfileItem(Icons.child_friendly, 'Number of Children', '${userInput.noOfChildren}'),
            _buildProfileItem(Icons.attach_money, 'Annual Income', '${userInput.annualIncome}'),
            _buildProfileItem(Icons.work, 'Income Type', userInput.incomeType),
            _buildProfileItem(Icons.school, 'Education Type', userInput.educationType),
            _buildProfileItem(Icons.family_restroom, 'Family Status', userInput.familyStatus),
            _buildProfileItem(Icons.home_work, 'Housing Type', userInput.housingType),
            _buildProfileItem(Icons.cake, 'Days Birth', '${userInput.daysBirth}'),
            _buildProfileItem(Icons.work_history, 'Days Employed', '${userInput.daysEmployed}'),
            _buildProfileItem(Icons.work_outline, 'Occupation Type', userInput.occupationType),
            _buildProfileItem(Icons.group, 'Total Family Members', '${userInput.totalFamilyMembers}'),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue[900], size: 20),
          SizedBox(width: 10),
          Text('$label: ', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildResultDisplay() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: userInput.result ? Colors.green.shade100 : Colors.red.shade100,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Prediction Result',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[900]),
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonSection(String title, String feature) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue[900])),
            SizedBox(height: 10),
            Container(
              height: 300,
              child: feature == 'annualIncome' ||
                      feature == 'daysBirth' ||
                      feature == 'daysEmployed' ||
                      feature == 'noOfChildren' ||
                      feature == 'totalFamilyMembers'
                  ? FeatureComparisonGraph(
                      dummyData: dummyData,
                      userInput: userInput,
                      feature: feature,
                    )
                  : CategoricalComparisonGraph(
                      dummyData: dummyData,
                      userInput: userInput,
                      feature: feature,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
