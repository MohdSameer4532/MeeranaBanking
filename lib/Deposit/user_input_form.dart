import 'package:flutter/material.dart';
import 'person.dart';
import 'result_screen.dart';

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

  String _selectedJob = 'Select Job';
  String? _selectedMaritalStatus;
  String? _selectedEducation;
  String _selectedHousingLoan = 'no';
  String _selectedPersonalLoan = 'no';
  String? _selectedPreviousCampaignOutcome;

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
          'Deposit Prediction',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
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
                _buildCustomDropdown('job', [
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
                ]),
                const SizedBox(height: 20),
                _buildCustomDropdown(
                    'maritalStatus', ['Single', 'Married', 'Divorced']),
                const SizedBox(height: 20),
                _buildCustomDropdown('education',
                    ['Primary', 'Secondary', 'Tertiary', 'Unknown']),
                const SizedBox(height: 20),
                _buildTextField('balance', _balanceController,
                    TextInputType.number, 'Please enter balance'),
                const SizedBox(height: 20),
                _buildRadioGroup('personalLoan', 'Personal Loan'),
                const SizedBox(height: 20),
                _buildRadioGroup('housingLoan', 'Housing Loan'),
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
                _buildCustomDropdown('previousCampaignOutcome',
                    ['Success', 'Failure', 'Other', 'Unknown']),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
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

  Widget _buildTextField(String fieldName, TextEditingController controller,
      TextInputType inputType, String validationMessage) {
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

  Widget _buildCustomDropdown(String fieldName, List<String> items) {
    String? selectedValue;
    switch (fieldName) {
      case 'job':
        selectedValue = _selectedJob;
        break;
      case 'maritalStatus':
        selectedValue = _selectedMaritalStatus;
        break;
      case 'education':
        selectedValue = _selectedEducation;
        break;
      case 'previousCampaignOutcome':
        selectedValue = _selectedPreviousCampaignOutcome;
        break;
    }

    return CustomDropdown(
      label: fieldLabels[fieldName]!,
      items: items,
      value: selectedValue,
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
              _selectedPreviousCampaignOutcome = value!;
              break;
          }
        });
      },
    );
  }

  Widget _buildRadioGroup(String fieldName, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Row(
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
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Person userInput = Person(
        age: int.parse(_ageController.text),
        job: _selectedJob == 'Select Job' ? '' : _selectedJob,
        marital: _selectedMaritalStatus ?? '',
        education: _selectedEducation ?? '',
        balance: int.parse(_balanceController.text),
        personalLoan: _selectedPersonalLoan == 'yes',
        housingLoan: _selectedHousingLoan == 'yes',
        result: false,
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
