import 'package:flutter/material.dart';
import 'fraud_data.dart';
import 'fraud_result_page.dart';
import '../custom_dropdown.dart';
import '../custom_app_bar.dart';

final Map<String, String> fieldLabels = {
  'age': 'Age',
  'gender': 'Gender',
  'zipcodeOri': 'Zip Code Origin',
  'merchant': 'Merchant',
  'zipMerchant': 'Merchant Zip Code',
  'category': 'Category',
  'amount': 'Amount',
};

class FraudUserInputPage extends StatefulWidget {
  @override
  _FraudUserInputPageState createState() => _FraudUserInputPageState();
}

class _FraudUserInputPageState extends State<FraudUserInputPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _zipcodeOriController = TextEditingController();
  final TextEditingController _merchantController = TextEditingController();
  final TextEditingController _zipMerchantController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String? _selectedGender;
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        backButton: true,
        c: context,
        title: 'Fraud Detection Input',
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                _buildTextField('age', _ageController, TextInputType.number,
                    'Please enter age', 'Enter age'),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: fieldLabels['gender']!,
                  items: ['M', 'F'],
                  value: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                _buildTextField('zipcodeOri', _zipcodeOriController,
                    TextInputType.number, 'Please enter zip code', 'Enter zip code'),
                const SizedBox(height: 20),
                _buildTextField('merchant', _merchantController,
                    TextInputType.text, 'Please enter merchant', 'Enter merchant'),
                const SizedBox(height: 20),
                _buildTextField('zipMerchant', _zipMerchantController,
                    TextInputType.number, 'Please enter merchant zip code', 'Enter merchant zip code'),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: fieldLabels['category']!,
                  items: [
                    'es_transportation',
                    'es_health',
                    'es_food',
                    'es_tech',
                    'es_travel',
                    'es_bills',
                    'es_others'
                  ],
                  value: _selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                _buildTextField('amount', _amountController,
                    TextInputType.number, 'Please enter amount', 'Enter amount'),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 34, 34, 34),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
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

  Widget _buildTextField(String fieldName, TextEditingController controller,
      TextInputType inputType, String validationMessage, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldLabels[fieldName]!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          ),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.grey[800],
          ),
          keyboardType: inputType,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return validationMessage;
            }
            return null;
          },
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      FraudPerson userInput = FraudPerson(
        customer: 'C1234567890', // Placeholder
        age: int.parse(_ageController.text),
        gender: _selectedGender ?? '',
        zipcodeOri: _zipcodeOriController.text,
        merchant: _merchantController.text,
        zipMerchant: _zipMerchantController.text,
        category: _selectedCategory ?? '',
        amount: double.parse(_amountController.text),
        fraudStatus: 'Pending', // Placeholder
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ResultScreen(userInput: userInput, dummyData: []),
        ),
      );

      
    }
  }
}
