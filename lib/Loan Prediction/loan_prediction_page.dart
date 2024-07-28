import 'package:flutter/material.dart';
import '../custom_app_bar.dart'; // Import the CustomAppBar file
import 'loan_result_page.dart'; // Import the LoanResultPage file

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

  Widget _buildCustomDropdown(String fieldName, List<String> items,
      String? selectedValue, void Function(String?) onChanged) {
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
        CustomDropdown(
          label: loanFieldLabels[fieldName]!,
          items: items,
          value: selectedValue,
          onChanged: onChanged,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color of the Scaffold
      appBar: CustomAppBar(
        c: context,
        title: 'Loan Prediction',
        backButton: true, // Enable back button
        backgroundColor: Color.fromARGB(
            255, 255, 255, 255), // Set the background color of the AppBar
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
                _buildCustomDropdown(
                  'maritalStatus',
                  ['Married', 'Single'],
                  _maritalStatus,
                  (value) {
                    setState(() {
                      _maritalStatus = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                _buildCustomDropdown(
                  'houseOwnership',
                  ['Owned', 'Rented'],
                  _houseOwnership,
                  (value) {
                    setState(() {
                      _houseOwnership = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                _buildCustomDropdown(
                  'carOwnership',
                  ['Yes', 'No'],
                  _carOwnership,
                  (value) {
                    setState(() {
                      _carOwnership = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                _buildCustomDropdown(
                  'profession',
                  ['Engineer', 'Teacher', 'Doctor', 'Chef'],
                  _profession,
                  (value) {
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
                      backgroundColor:
                          Color.fromARGB(255, 30, 51, 84), // background color
                      foregroundColor: Colors.white, // text color
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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[100],
            ),
            child: Column(
              children: widget.items.map((item) {
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    widget.onChanged(item);
                    setState(() {
                      _isExpanded = false;
                    });
                  },
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
