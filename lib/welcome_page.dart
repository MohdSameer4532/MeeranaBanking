// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'Deposit/deposit_general_analytics.dart';
import 'Loan Prediction/loan_general_analytics.dart';
import 'Credit Approval/credit_home_page.dart';
import 'Fraud Detection/fraud_general_analysis.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1E3354),
          leading: Icon(Icons.account_balance,
              color: Colors.white, size: 28), // Bank icon added here
          title: const Text(
            'Meerana Banking Engine',
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.normal,
              fontSize: 16,
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 30),
                const Icon(
                  Icons.account_balance,
                  size: 80,
                  color: Colors.black54,
                ),
                const SizedBox(
                    height: 30), // Add space between icon and buttons
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(
                            height: 30), // Add more space before the buttons
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            childAspectRatio: 2, // Adjust this for button shape
                            children: [
                              _buildButton(
                                'Deposit Prediction',
                                Icons.account_balance_wallet,
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DepositPredictionPage(),
                                    ),
                                  );
                                },
                              ),
                              _buildButton(
                                'Loan Prediction',
                                Icons.attach_money,
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          LoanGeneralAnalyticsPage(),
                                    ),
                                  );
                                },
                              ),
                              _buildButton(
                                'Credit Approval',
                                Icons.credit_card,
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CreditHomePage(), // Add navigation
                                    ),
                                  );
                                },
                              ),
                              _buildButton(
                                'Fraud Detection',
                                Icons.warning,
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FraudGeneralAnalyticsPage(), // Add navigation
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 30, 51, 84),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        textStyle: const TextStyle(
          fontSize: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side:
              const BorderSide(color: Colors.white, width: 1), // Add this line
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30),
          const SizedBox(height: 10),
          Text(text, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: WelcomePage(),
  ));
}
