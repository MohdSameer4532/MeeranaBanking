import 'package:flutter/material.dart';
import 'credit_person.dart';
import 'credit_feature_comparison_graph.dart';

class ResultScreen extends StatelessWidget {
  final CreditPerson userInput;
  final List<CreditPerson> dummyData;

  const ResultScreen({
    super.key, // Adding key parameter
    required this.userInput,
    required this.dummyData,
  }); // Passing key to the superclass constructor

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
            // Navigate back and handle layout adjustment
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Credit Result',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserInputSummary(),
                const SizedBox(height: 20),
                _buildResultDisplay(),
                const SizedBox(height: 20),
                _buildComparisonSection(
                    'Annual Income Comparison', 'annualIncome'),
                const SizedBox(height: 20),
                _buildComparisonSection('Days Birth Comparison', 'daysBirth'),
                const SizedBox(height: 20),
                _buildComparisonSection(
                    'Days Employed Comparison', 'daysEmployed'),
                const SizedBox(height: 20),
                _buildComparisonSection(
                    'Number of Children Comparison', 'noOfChildren'),
                const SizedBox(height: 20),
                _buildComparisonSection(
                    'Total Family Members Comparison', 'totalFamilyMembers'),
                const SizedBox(height: 20),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your Profile',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal)),
            const SizedBox(height: 10),
            _buildProfileItem(Icons.child_friendly, 'Number of Children',
                '${userInput.noOfChildren}'),
            _buildProfileItem(Icons.attach_money, 'Annual Income',
                '${userInput.annualIncome}'),
            _buildProfileItem(
                Icons.cake, 'Days Birth', '${userInput.daysBirth}'),
            _buildProfileItem(Icons.work_history, 'Days Employed',
                '${userInput.daysEmployed}'),
            _buildProfileItem(Icons.group, 'Total Family Members',
                '${userInput.totalFamilyMembers}'),
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
          Icon(icon, color: Colors.teal, size: 20),
          const SizedBox(width: 10),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Prediction Result',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal),
            ),
            const SizedBox(height: 10),
            Icon(
              userInput.result ? Icons.thumb_up : Icons.thumb_down,
              size: 50,
              color: userInput.result ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 10),
            Text(
              userInput.result
                  ? 'Eligible for Credit'
                  : 'Not Eligible for Credit',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal)),
            const SizedBox(height: 10),
            SizedBox(
              height: 300,
              child: FeatureComparisonGraph(
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
