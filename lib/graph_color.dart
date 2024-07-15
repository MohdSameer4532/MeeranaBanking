import 'package:flutter/material.dart';

class GraphColors {
  static const Map<String, Color> education = {
    'unknown': Colors.grey,
    'primary': Colors.blue,
    'secondary': Colors.green,
    'tertiary': Colors.orange,
  };

  static const Map<String, Color> marital = {
    'single': Colors.purple,
    'married': Colors.red,
    'divorced': Colors.teal,
    'unknown': Colors.grey,
  };

  static const Map<String, Color> loan = {
    'Yes': Colors.deepOrange,
    'No': Colors.indigo,
  };

  static Color getEducationColor(String education) {
    return GraphColors.education[education.toLowerCase()] ?? Colors.grey;
  }

  static Color getMaritalColor(String marital) {
    return GraphColors.marital[marital.toLowerCase()] ?? Colors.grey;
  }

  static Color getLoanColor(bool hasLoan) {
    return GraphColors.loan[hasLoan ? 'Yes' : 'No'] ?? Colors.grey;
  }
}