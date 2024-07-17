import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(const BankPredictionApp());
}

class BankPredictionApp extends StatelessWidget {
  const BankPredictionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bank Prediction',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
