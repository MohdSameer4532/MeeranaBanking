import 'package:flutter/material.dart';
import 'deposit_person.dart';
import 'deposit_resultscreen.dart';
import '../custom_app_bar.dart';

final Map<String, String> fieldLabels = {
  'age': 'Age',
  'job': 'Job',
  'maritalStatus': 'Marital Status',
  'education': 'Education',
  'balance': 'Balance',
  'personalLoan': 'Personal Loan',
  'housingLoan': 'Housing Loan',
  'campaign': 'Campaign',
  'daysSincePreviousContact': 'Days since previous contact',
  'previousContacts': 'Previous contacts',
  'previousCampaignOutcome': 'Outcome of previous campaign',
};

class UserInputForm extends StatefulWidget {
  @override
  _UserInputFormState createState() => _UserInputFormState();
}

class _UserInputFormState extends State<UserInputForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _campaignController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _previousContactsController =
      TextEditingController();
  String? _selectedJob;
  String? _selectedMaritalStatus;
  String? _selectedEducation;
  String _selectedHousingLoan = '';
  String _selectedPersonalLoan = '';
  String? _selectedPreviousCampaignOutcome;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color of the Scaffold
      appBar: CustomAppBar(
        c: context,
        title: 'Deposit Prediction',
        backButton: true, // Enable back button
        backgroundColor: Color.fromARGB(
            255, 30, 51, 84), // Set the background color of the AppBar
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
                    'Please enter age'),
                const SizedBox(height: 20),
                _buildCustomDropdown(
                  'job',
                  [
                    'Admin',
                    'Blue-collar',
                    'Entrepreneur',
                    'Housemaid',
                    'Management',
                    'Retired',
                    'Self-employed',
                    'Services',
                    'Student',
                    'Technician',
                    'Unemployed'
                  ],
                  (value) => setState(() => _selectedJob = value),
                ),
                const SizedBox(height: 20),
                _buildCustomDropdown(
                  'maritalStatus',
                  ['Single', 'Married', 'Divorced'],
                  (value) => setState(() => _selectedMaritalStatus = value),
                ),
                const SizedBox(height: 20),
                _buildCustomDropdown(
                  'education',
                  ['Primary', 'Secondary', 'Tertiary', 'Unknown'],
                  (value) => setState(() => _selectedEducation = value),
                ),
                const SizedBox(height: 20),
                _buildTextField('balance', _balanceController,
                    TextInputType.number, 'Please enter balance'),
                const SizedBox(height: 20),
                _buildSectionHeader('personalLoan'),
                _buildRadioGroup('personalLoan'),
                const SizedBox(height: 20),
                _buildSectionHeader('housingLoan'),
                _buildRadioGroup('housingLoan'),
                const SizedBox(height: 20),
                _buildTextField('campaign', _campaignController,
                    TextInputType.number, 'Please enter a campaign number'),
                const SizedBox(height: 20),
                _buildTextField('daysSincePreviousContact', _daysController,
                    TextInputType.number, 'Please enter number of days'),
                const SizedBox(height: 20),
                _buildTextField('previousContacts', _previousContactsController,
                    TextInputType.number, 'Please enter number of contacts'),
                const SizedBox(height: 20),
                _buildCustomDropdown(
                  'previousCampaignOutcome',
                  ['Success', 'Failure', 'Other', 'Unknown'],
                  (value) =>
                      setState(() => _selectedPreviousCampaignOutcome = value),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      backgroundColor: Color(0xFF1E3354),
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
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
      TextInputType inputType, String validationMessage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldLabels[fieldName]!,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter ${fieldLabels[fieldName]}',
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

  Widget _buildCustomDropdown(
      String fieldName, List<String> items, Function(String?) onChanged) {
    return CustomDropdown(
      label: fieldLabels[fieldName]!,
      items: items,
      value: _getSelectedValueForField(fieldName),
      onChanged: onChanged,
    );
  }

  String? _getSelectedValueForField(String fieldName) {
    switch (fieldName) {
      case 'job':
        return _selectedJob;
      case 'maritalStatus':
        return _selectedMaritalStatus;
      case 'education':
        return _selectedEducation;
      case 'previousCampaignOutcome':
        return _selectedPreviousCampaignOutcome;
      default:
        return null;
    }
  }

  Widget _buildSectionHeader(String fieldName) {
    return Text(
      fieldLabels[fieldName]!,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildRadioGroup(String fieldName) {
    return Row(
      children: [
        Expanded(
          child: RadioListTile<String>(
            title: const Text('Yes'),
            value: 'yes',
            groupValue: fieldName == 'housingLoan'
                ? _selectedHousingLoan
                : _selectedPersonalLoan,
            onChanged: (value) {
              setState(() {
                if (fieldName == 'housingLoan') {
                  _selectedHousingLoan = value!;
                } else if (fieldName == 'personalLoan') {
                  _selectedPersonalLoan = value!;
                }
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile<String>(
            title: const Text('No'),
            value: 'no',
            groupValue: fieldName == 'housingLoan'
                ? _selectedHousingLoan
                : _selectedPersonalLoan,
            onChanged: (value) {
              setState(() {
                if (fieldName == 'housingLoan') {
                  _selectedHousingLoan = value!;
                } else if (fieldName == 'personalLoan') {
                  _selectedPersonalLoan = value!;
                }
              });
            },
          ),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Person userInput = Person(
        age: int.parse(_ageController.text),
        job: _selectedJob ?? '',
        marital: _selectedMaritalStatus ?? '',
        education: _selectedEducation ?? '',
        balance: int.parse(_balanceController.text),
        personalLoan: _selectedPersonalLoan == 'yes',
        housingLoan: _selectedHousingLoan == 'yes',
        result: true, // Placeholder for result calculation
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
