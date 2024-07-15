import 'package:flutter/material.dart';
import 'fraud_data.dart'; // Import your data file
import 'fraud_result_page.dart'; // Import FraudResultPage

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
    // Dispose controllers when not needed to avoid memory leaks
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
          'Fraud Prediction',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
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
                hintText: 'C1093826151',
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
              value: selectedGender,
              items: ['M', 'F'],
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
                hintText: 'M1931927982',
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
              value: selectedCategory,
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
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 30, 51, 84),
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
                color: Colors.red, // Adjust color as needed
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
      );
    });
  }
}

class CustomDropdown extends StatefulWidget {
  final String label;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;

  const CustomDropdown({
    Key? key,
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[100],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.value ?? 'Select ${widget.label}',
                  style: const TextStyle(fontSize: 16),
                ),
                Icon(_isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[100],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widget.items.map((item) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.onChanged(item);
                      _isExpanded = false;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(item, style: const TextStyle(fontSize: 16)),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
