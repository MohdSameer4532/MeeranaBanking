import 'package:flutter/material.dart';
import '../custom_app_bar.dart';
import 'loan_result_page.dart';
import '../custom_dropdown.dart';

final Map<String, String> loanFieldLabels = {
  'income': 'Income',
  'age': 'Age',
  'experience': 'Experience',
  'currentJobYears': 'Current Job Years',
  'currentHouseYears': 'Current House Years',
  'maritalStatus': 'Marital Status',
  'houseOwnership': 'House Ownership',
  'carOwnership': 'Car Ownership',
  'profession': 'Profession',
};

class LoanPredictionPage extends StatefulWidget {
  const LoanPredictionPage({Key? key}) : super(key: key);

  @override
  _LoanPredictionPageState createState() => _LoanPredictionPageState();
}

class _LoanPredictionPageState extends State<LoanPredictionPage> {
  final _formKey = GlobalKey<FormState>();

  final _incomeController = TextEditingController();
  final _ageController = TextEditingController();
  final _experienceController = TextEditingController();
  final _currentJobYearsController = TextEditingController();
  final _currentHouseYearsController = TextEditingController();
  String? _maritalStatus;
  String? _houseOwnership;
  String? _carOwnership;
  String? _profession;

  @override
  void dispose() {
    _incomeController.dispose();
    _ageController.dispose();
    _experienceController.dispose();
    _currentJobYearsController.dispose();
    _currentHouseYearsController.dispose();
    super.dispose();
  }

  void _predictLoanRisk() {
    if (_formKey.currentState!.validate()) {
      final double income = double.tryParse(_incomeController.text) ?? 0;
      final int age = int.tryParse(_ageController.text) ?? 0;
      final int experience = int.tryParse(_experienceController.text) ?? 0;
      final int currentJobYears =
          int.tryParse(_currentJobYearsController.text) ?? 0;
      final int currentHouseYears =
          int.tryParse(_currentHouseYearsController.text) ?? 0;

      String predictionResult;
      if (income > 50000 &&
          age > 30 &&
          experience > 5 &&
          currentJobYears > 3 &&
          currentHouseYears > 2) {
        predictionResult = 'Loan Approved';
      } else {
        predictionResult = 'Loan Denied';
      }

      Map<String, dynamic> userInputData = {
        'income': income,
        'age': age,
        'experience': experience,
        'currentJobYears': currentJobYears,
        'currentHouseYears': currentHouseYears,
        'maritalStatus': _maritalStatus,
        'houseOwnership': _houseOwnership,
        'carOwnership': _carOwnership,
        'profession': _profession,
      };

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoanResultPage(
            predictionResult: predictionResult,
            userInputData: userInputData,
          ),
        ),
      );
    }
  }

  Widget _buildTextField(String fieldName, TextEditingController controller,
      TextInputType inputType, String validationMessage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loanFieldLabels[fieldName]!,
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
            hintText: 'Enter ${loanFieldLabels[fieldName]}',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.grey[100],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        c: context,
        title: 'Loan Prediction',
        backButton: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
                _buildTextField('income', _incomeController,
                    TextInputType.number, 'Please enter income'),
                const SizedBox(height: 20),
                _buildTextField('age', _ageController, TextInputType.number,
                    'Please enter age'),
                const SizedBox(height: 20),
                _buildTextField('experience', _experienceController,
                    TextInputType.number, 'Please enter experience'),
                const SizedBox(height: 20),
                _buildTextField('currentJobYears', _currentJobYearsController,
                    TextInputType.number, 'Please enter current job years'),
                const SizedBox(height: 20),
                _buildTextField(
                    'currentHouseYears',
                    _currentHouseYearsController,
                    TextInputType.number,
                    'Please enter current house years'),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: loanFieldLabels['maritalStatus']!,
                  items: ['Married', 'Single'],
                  value: _maritalStatus,
                  onChanged: (value) {
                    setState(() {
                      _maritalStatus = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: loanFieldLabels['houseOwnership']!,
                  items: ['Owned', 'Rented'],
                  value: _houseOwnership,
                  onChanged: (value) {
                    setState(() {
                      _houseOwnership = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: loanFieldLabels['carOwnership']!,
                  items: ['Yes', 'No'],
                  value: _carOwnership,
                  onChanged: (value) {
                    setState(() {
                      _carOwnership = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: loanFieldLabels['profession']!,
                  items: ['Engineer', 'Teacher', 'Doctor', 'Chef'],
                  value: _profession,
                  onChanged: (value) {
                    setState(() {
                      _profession = value;
                    });
                  },
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _predictLoanRisk,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 34, 34, 34),
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
}
