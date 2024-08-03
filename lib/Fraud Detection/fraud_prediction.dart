import 'package:flutter/material.dart';
import 'fraud_data.dart'; // Import your data file
import 'fraud_result_page.dart'; // Import FraudResultPage
import '../custom_app_bar.dart';
import '../custom_dropdown.dart';

class FraudPredictionPage extends StatefulWidget {
  @override
  _FraudPredictionPageState createState() => _FraudPredictionPageState();
}

class _FraudPredictionPageState extends State<FraudPredictionPage> {
  final List<FraudPerson> data = getFraudPersons();
  FraudPerson? selectedPerson;
  String predictionResult = "";

  final TextEditingController customerController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController zipCodeOriController = TextEditingController();
  final TextEditingController merchantController = TextEditingController();
  final TextEditingController zipMerchantController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  String? selectedGender;
  String? selectedCategory;

  @override
  void dispose() {
    customerController.dispose();
    ageController.dispose();
    zipCodeOriController.dispose();
    merchantController.dispose();
    zipMerchantController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void predictFraud() {
    if (selectedPerson != null) {
      setState(() {
        predictionResult =
            selectedPerson!.amount > 100 ? "High Fraud Risk" : "Low Fraud Risk";
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FraudResultPage(
            userInput: selectedPerson!,
            dummyData: data,
          ),
        ),
      );
    } else {
      setState(() {
        predictionResult = "Please fill in all details";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        c: context,
        title: 'Fraud Detection',
        backButton: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10),
            TextField(
              controller: customerController,
              onChanged: (value) {
                updateSelectedPerson();
              },
              decoration: InputDecoration(
                labelText: 'Customer',
                hintText: 'C1551465414',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: ageController,
              onChanged: (value) {
                updateSelectedPerson();
              },
              decoration: InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              keyboardType: TextInputType.number,
              maxLength: 2,
            ),
            SizedBox(height: 10),
            CustomDropdown(
              label: 'Gender',
              items: ['M', 'F'],
              value: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                  updateSelectedPerson();
                });
              },
            ),
            SizedBox(height: 10),
            TextField(
              controller: zipCodeOriController,
              onChanged: (value) {
                updateSelectedPerson();
              },
              decoration: InputDecoration(
                labelText: 'Zip Code Origin',
                hintText: '28007',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              keyboardType: TextInputType.number,
              maxLength: 5,
            ),
            SizedBox(height: 10),
            TextField(
              controller: merchantController,
              onChanged: (value) {
                updateSelectedPerson();
              },
              decoration: InputDecoration(
                labelText: 'Merchant',
                hintText: 'M1823072687',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: zipMerchantController,
              onChanged: (value) {
                updateSelectedPerson();
              },
              decoration: InputDecoration(
                labelText: 'Zip Merchant',
                hintText: '28007',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              keyboardType: TextInputType.number,
              maxLength: 5,
            ),
            SizedBox(height: 10),
            CustomDropdown(
              label: 'Category',
              items: [
                'es_transportation',
                'es_health',
                'es_otherservices',
                'es_food',
                'es_barsandrestaurants',
                'es_sportsandtoys',
                'es_hotelservices',
                'es_bills',
                'es_automotive',
                'es_leisure',
                'es_travel',
                'es_hometools',
                'es_wellnessandbeauty',
                'es_tech',
                'es_contents',
                'es_fashion',
                'es_hyper'
              ],
              value: selectedCategory,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                  updateSelectedPerson();
                });
              },
            ),
            SizedBox(height: 10),
            TextField(
              controller: amountController,
              onChanged: (value) {
                updateSelectedPerson();
              },
              decoration: InputDecoration(
                labelText: 'Amount',
                hintText: '100.0',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              keyboardType: TextInputType.number,
              maxLength: 10,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedPerson != null) {
                  predictFraud();
                } else {
                  setState(() {
                    predictionResult = "Please fill in all details";
                  });
                }
              },
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 0, 0),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(height: 20),
            Text(
              predictionResult,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void updateSelectedPerson() {
    setState(() {
      selectedPerson = FraudPerson(
        customer: customerController.text,
        age: int.tryParse(ageController.text) ?? 0,
        gender: selectedGender ?? '',
        zipcodeOri: zipCodeOriController.text,
        merchant: merchantController.text,
        zipMerchant: zipMerchantController.text,
        category: selectedCategory ?? '',
        amount: double.tryParse(amountController.text) ?? 0.0,
        fraudDetected:
            false, // Default value; actual detection logic can be added
      );
    });
  }
}
