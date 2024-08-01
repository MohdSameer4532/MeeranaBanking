import 'package:flutter/material.dart';
import 'welcome_page.dart'; // Import the WelcomePage widget

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate splash screen delay
    Future.delayed(const Duration(seconds: 1), () {
      // Navigate to WelcomePage after delay
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo and text
            Column(
              children: [
                Image.asset(
                  'assets/logt.png', // Replace with your logo asset path
                  height: 120, // Adjust height as needed
                ),
                SizedBox(height: 10),
                Text(
                  'Meerana Banking Engine',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Loading indicator
            CircularProgressIndicator(
              color: Colors.black, // Customize progress indicator color
            ),
            SizedBox(height: 20),
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
