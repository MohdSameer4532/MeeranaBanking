import 'package:flutter/material.dart';
import 'Deposit/deposit_general_analytics.dart';
import 'Loan Prediction/loan_general_analytics.dart';
import 'Credit Approval/credit_general_analytics.dart';
import 'Fraud Detection/fraud_general_analysis.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  String _getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning,';
    } else if (hour < 17) {
      return 'Good Afternoon,';
    } else {
      return 'Good Evening,';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set overall background color to white
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  _getGreetingMessage(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Admin!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Image.asset('assets/banking_illustration.png',
                      height: 200),
                ),
                const SizedBox(
                    height: 80), // Increased space to move buttons down
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                  children: [
                    _buildFeatureButton(
                      'Deposit\nPrediction',
                      'assets/deps.png',
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DepositPredictionPage(),
                        ),
                      ),
                    ),
                    _buildFeatureButton(
                      'Loan\nPrediction',
                      'assets/loan.png',
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoanGeneralAnalyticsPage(),
                        ),
                      ),
                    ),
                    _buildFeatureButton(
                      'Credit\nApproval',
                      'assets/cred.png',
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreditHomePage(),
                        ),
                      ),
                    ),
                    _buildFeatureButton(
                      'Fraud\nDetection',
                      'assets/fraud.png',
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FraudGeneralAnalyticsPage(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureButton(
      String text, String assetPath, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0D000000), // Shadow color with opacity
            offset: const Offset(0, 5),
            blurRadius: 30,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(assetPath, height: 32), // Use your PNG icon
            const SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: const WelcomePage(),
    theme: ThemeData(
      primaryColor: const Color(0xFF1E3354),
      fontFamily: 'Roboto',
    ),
  ));
}
