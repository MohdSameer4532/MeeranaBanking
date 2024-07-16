import 'package:flutter/material.dart';
import 'fraud_data.dart'; // Import your data file
import 'fraud_feature_comparison_graph.dart'; // Adjust to your actual graph widget name

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
      appBar: AppBar(
        title: const Text(
          'Fraud Result',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: Color.fromARGB(255, 30, 51, 84),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Fraud Prediction Result',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              _buildUserInputSummary(),
              SizedBox(height: 20),
              _buildFraudDetectionInfo(),
              SizedBox(height: 20),
              _buildComparisonSection('Age Comparison', 'age'),
              SizedBox(height: 20),
              _buildComparisonSection('Amount Comparison', 'amount'),
              SizedBox(height: 20),
              // Add more comparison sections as needed
            ],
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
            Text(
              'Selected Person',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 10),
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
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: const Color.fromARGB(255, 146, 211, 205), size: 20),
          SizedBox(width: 10),
          Text('$label: ', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
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
                SizedBox(
                  width: 10,
                  height: 100,
                ),
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
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
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
            FeatureComparisonGraph(
              dummyData: widget.dummyData,
              userInput: widget.userInput,
              feature: feature,
            ),
          ],
        ),
      ),
    );
  }
}
