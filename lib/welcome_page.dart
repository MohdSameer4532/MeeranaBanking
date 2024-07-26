import 'package:flutter/material.dart';
import 'Deposit/deposit_general_analytics.dart';
import 'Loan Prediction/loan_general_analytics.dart';
import 'Credit Approval/credit_home_page.dart';
import 'Fraud Detection/fraud_general_analysis.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  String _getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning,';
    } else if (hour < 18) {
      return 'Good Afternoon,';
    } else {
      return 'Good Evening,';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const SizedBox(height: 20),
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
                      Icons.account_balance_wallet,
                      Colors.blue,
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DepositPredictionPage()),
                      ),
                    ),
                    _buildFeatureButton(
                      'Loan\nPrediction',
                      Icons.attach_money,
                      Colors.green,
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoanGeneralAnalyticsPage()),
                      ),
                    ),
                    _buildFeatureButton(
                      'Credit\nApproval',
                      Icons.credit_card,
                      Colors.orange,
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreditHomePage()),
                      ),
                    ),
                    _buildFeatureButton(
                      'Fraud\nDetection',
                      Icons.security,
                      Colors.red,
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FraudGeneralAnalyticsPage()),
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
      String text, IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: color,
        backgroundColor: color.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 8),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: color, fontSize: 14),
          ),
        ],
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
