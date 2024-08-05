import 'package:flutter/material.dart';
import 'loanperson.dart'; // Ensure this file defines the Person class
import 'loan_result_page.dart';
import '../custom_dropdown.dart';
import '../custom_app_bar.dart';

// Make sure dummyData is available here or pass it as needed
final List<Person> dummyData = [
  // Your dummy data here
];

final Map<String, String> fieldLabels = {
  'income': 'Income',
  'age': 'Age',
  'experience': 'Experience',
  'currentJobYears': 'Current Job Years',
  'currentHouseYears': 'Current House Years',
  'maritalStatus': 'Marital Status',
  'houseOwnership': 'House Ownership',
  'carOwnership': 'Car Ownership',
  'profession': 'Profession',
  'loanStatus': 'Loan Status',
};

class UserInputForm extends StatefulWidget {
  @override
  _UserInputFormState createState() => _UserInputFormState();
}

class _UserInputFormState extends State<UserInputForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _currentJobYearsController =
      TextEditingController();
  final TextEditingController _currentHouseYearsController =
      TextEditingController();
  String? _selectedMaritalStatus;
  String? _selectedHouseOwnership;
  String? _selectedCarOwnership;
  String? _selectedProfession;
  String? _selectedLoanStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backButton: true,
        c: context,
        title: 'Loan Prediction',
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
                _buildTextField(
                    'income',
                    _incomeController,
                    TextInputType.number,
                    'Please enter income',
                    'Enter income'),
                const SizedBox(height: 20),
                _buildTextField('age', _ageController, TextInputType.number,
                    'Please enter age', 'Enter age'),
                const SizedBox(height: 20),
                _buildTextField(
                    'experience',
                    _experienceController,
                    TextInputType.number,
                    'Please enter experience',
                    'Enter experience'),
                const SizedBox(height: 20),
                _buildTextField(
                    'currentJobYears',
                    _currentJobYearsController,
                    TextInputType.number,
                    'Please enter years at current job',
                    'Enter Current Job Years'),
                const SizedBox(height: 20),
                _buildTextField(
                    'currentHouseYears',
                    _currentHouseYearsController,
                    TextInputType.number,
                    'Please enter years at current house',
                    'Enter Current House Years'),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: fieldLabels['maritalStatus']!,
                  items: ['Married', 'Single'],
                  value: _selectedMaritalStatus,
                  onChanged: (value) {
                    setState(() {
                      _selectedMaritalStatus = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: fieldLabels['houseOwnership']!,
                  items: ['Owned', 'Rented'],
                  value: _selectedHouseOwnership,
                  onChanged: (value) {
                    setState(() {
                      _selectedHouseOwnership = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: fieldLabels['carOwnership']!,
                  items: ['Yes', 'No'],
                  value: _selectedCarOwnership,
                  onChanged: (value) {
                    setState(() {
                      _selectedCarOwnership = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: fieldLabels['profession']!,
                  items: ['Engineer', 'Teacher', 'Doctor', 'Chef'],
                  value: _selectedProfession,
                  onChanged: (value) {
                    setState(() {
                      _selectedProfession = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: fieldLabels['loanStatus']!,
                  items: ['Accepted', 'Denied'],
                  value: _selectedLoanStatus,
                  onChanged: (value) {
                    setState(() {
                      _selectedLoanStatus = value;
                    });
                  },
                ),
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
      final userInput = Person(
        income: int.parse(_incomeController.text),
        age: int.parse(_ageController.text),
        experience: int.parse(_experienceController.text),
        currentJobYears: int.parse(_currentJobYearsController.text),
        currentHouseYears: int.parse(_currentHouseYearsController.text),
        maritalStatus: _selectedMaritalStatus ?? '',
        houseOwnership: _selectedHouseOwnership ?? '',
        carOwnership: _selectedCarOwnership ?? '',
        profession: _selectedProfession ?? '',
        loanStatus: _selectedLoanStatus == 'Accepted',
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            userInput: userInput,
            dummyData: dummyData,
          ),
        ),
      );
    }
  }
}
