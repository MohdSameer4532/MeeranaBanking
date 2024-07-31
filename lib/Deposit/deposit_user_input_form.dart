import 'package:flutter/material.dart';
import 'deposit_person.dart';
import 'deposit_resultscreen.dart';
import '../custom_app_bar.dart';

// Extracted label texts
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
  String _selectedJob = '';
  String _selectedMaritalStatus = '';
  String _selectedEducation = '';
  String _selectedHousingLoan = '';
  String _selectedPersonalLoan = '';

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
                _buildTextField('age', _ageController, TextInputType.number,
                    'Please enter age'),
                const SizedBox(height: 20),
                _buildDropdownField(
                  'job',
                  const [
                    DropdownMenuItem(value: 'admin.', child: Text('Admin')),
                    DropdownMenuItem(
                        value: 'blue-collar', child: Text('Blue-collar')),
                    DropdownMenuItem(
                        value: 'entrepreneur', child: Text('Entrepreneur')),
                    DropdownMenuItem(
                        value: 'housemaid', child: Text('Housemaid')),
                    DropdownMenuItem(
                        value: 'management', child: Text('Management')),
                    DropdownMenuItem(value: 'retired', child: Text('Retired')),
                    DropdownMenuItem(
                        value: 'self-employed', child: Text('Self-employed')),
                    DropdownMenuItem(
                        value: 'services', child: Text('Services')),
                    DropdownMenuItem(value: 'student', child: Text('Student')),
                    DropdownMenuItem(
                        value: 'technician', child: Text('Technician')),
                    DropdownMenuItem(
                        value: 'unemployed', child: Text('Unemployed')),
                  ],
                  'Please select a job',
                ),
                const SizedBox(height: 20),
                _buildDropdownField(
                  'maritalStatus',
                  const [
                    DropdownMenuItem(value: 'single', child: Text('Single')),
                    DropdownMenuItem(value: 'married', child: Text('Married')),
                    DropdownMenuItem(
                        value: 'divorced', child: Text('Divorced')),
                  ],
                  'Please select marital status',
                ),
                const SizedBox(height: 20),
                _buildDropdownField(
                  'education',
                  const [
                    DropdownMenuItem(value: 'primary', child: Text('Primary')),
                    DropdownMenuItem(
                        value: 'secondary', child: Text('Secondary')),
                    DropdownMenuItem(
                        value: 'tertiary', child: Text('Tertiary')),
                    DropdownMenuItem(value: 'unknown', child: Text('Unknown')),
                  ],
                  'Please select education level',
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
                _buildDropdownField(
                  'previousCampaignOutcome',
                  const [
                    DropdownMenuItem(value: 'success', child: Text('Success')),
                    DropdownMenuItem(value: 'failure', child: Text('Failure')),
                    DropdownMenuItem(value: 'other', child: Text('Other')),
                    DropdownMenuItem(value: 'unknown', child: Text('Unknown')),
                  ],
                  'Please select the outcome of the previous campaign',
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
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

  Widget _buildTextField(String fieldName, TextEditingController controller,
      TextInputType inputType, String validationMessage) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: fieldLabels[fieldName],
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
    );
  }

  Widget _buildDropdownField(String fieldName,
      List<DropdownMenuItem<String>> items, String validationMessage) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: fieldLabels[fieldName],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      items: items,
      onChanged: (value) {
        setState(() {
          switch (fieldName) {
            case 'job':
              _selectedJob = value!;
              break;
            case 'maritalStatus':
              _selectedMaritalStatus = value!;
              break;
            case 'education':
              _selectedEducation = value!;
              break;
            case 'previousCampaignOutcome':
              break;
          }
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationMessage;
        }
        return null;
      },
    );
  }

  Widget _buildSectionHeader(String fieldName) {
    return Text(
      fieldLabels[fieldName]!,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey[700],
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
        job: _selectedJob,
        marital: _selectedMaritalStatus,
        education: _selectedEducation,
        balance: int.parse(_balanceController.text),
        personalLoan: _selectedPersonalLoan == 'yes',
        housingLoan: _selectedHousingLoan == 'yes',
        result: false, // Placeholder for result calculation
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
