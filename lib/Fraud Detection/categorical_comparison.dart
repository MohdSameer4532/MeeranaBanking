import 'package:flutter/material.dart';

class CategoricalComparison extends StatelessWidget {
  final String title;
  final String userValue;
  final String datasetValue;
  final Color color;

  CategoricalComparison({
    required this.title,
    required this.userValue,
    required this.datasetValue,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildComparisonItem('Your Value', userValue),
              _buildComparisonItem('Dataset Average', datasetValue),
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 200, // Adjust height based on your requirement
            width: double.infinity,
            // Placeholder for your categorical comparison visualization
            child: Placeholder(
              color: color,
              strokeWidth: 2.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }
}
