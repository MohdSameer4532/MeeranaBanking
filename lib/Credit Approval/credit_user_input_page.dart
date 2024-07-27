import 'package:flutter/material.dart';
import 'credit_person.dart';
import 'credit_result_screen.dart';

final Map<String, String> fieldLabels = {
  'gender': 'Gender',
  'ownCar': 'Own Car',
  'ownProperty': 'Own Property',
  'noOfChildren': 'Number of Children',
  'annualIncome': 'Annual Income',
  'incomeType': 'Income Type',
  'educationType': 'Education Type',
  'familyStatus': 'Family Status',
  'housingType': 'Housing Type',
  'daysBirth': 'Days since Birth',
  'daysEmployed': 'Days Employed',
  'occupationType': 'Occupation Type',
  'totalFamilyMembers': 'Total Family Members',
};

class CreditUserInputPage extends StatefulWidget {
  const CreditUserInputPage({Key? key}) : super(key: key);

  @override
  _CreditUserInputPageState createState() => _CreditUserInputPageState();
}

class _CreditUserInputPageState extends State<CreditUserInputPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _noOfChildrenController = TextEditingController();
  final TextEditingController _annualIncomeController = TextEditingController();
  final TextEditingController _daysBirthController = TextEditingController();
  final TextEditingController _daysEmployedController = TextEditingController();
  final TextEditingController _totalFamilyMembersController =
      TextEditingController();

  String? _selectedGender;
  String _selectedOwnCar = '';
  String _selectedOwnProperty = '';
  String? _selectedIncomeType;
  String? _selectedEducationType;
  String? _selectedFamilyStatus;
  String? _selectedHousingType;
  String? _selectedOccupationType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color(0xFF1E3354),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Credit Approval',
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
                _buildCustomDropdown(
                  'gender',
                  ['Male', 'Female'],
                  (value) => setState(() => _selectedGender = value),
                ),
                const SizedBox(height: 20),
                _buildSectionHeader('ownCar'),
                _buildRadioGroup('ownCar'),
                const SizedBox(height: 20),
                _buildSectionHeader('ownProperty'),
                _buildRadioGroup('ownProperty'),
                const SizedBox(height: 20),
                _buildTextField('noOfChildren', _noOfChildrenController,
                    TextInputType.number, 'Please enter number of children'),
                const SizedBox(height: 20),
                _buildTextField('annualIncome', _annualIncomeController,
                    TextInputType.number, 'Please enter annual income'),
                const SizedBox(height: 20),
                _buildCustomDropdown(
                  'incomeType',
                  [
                    'Working',
                    'Commercial Associate',
                    'Pensioner',
                    'State Servant',
                    'Student'
                  ],
                  (value) => setState(() => _selectedIncomeType = value),
                ),
                const SizedBox(height: 20),
                _buildCustomDropdown(
                  'educationType',
                  [
                    'Secondary',
                    'Higher Education',
                    'Incomplete Higher',
                    'Lower Secondary',
                    'Academic Degree'
                  ],
                  (value) => setState(() => _selectedEducationType = value),
                ),
                const SizedBox(height: 20),
                _buildCustomDropdown(
                  'familyStatus',
                  ['Married', 'Single', 'Civil Marriage', 'Separated', 'Widow'],
                  (value) => setState(() => _selectedFamilyStatus = value),
                ),
                const SizedBox(height: 20),
                _buildCustomDropdown(
                  'housingType',
                  [
                    'House/Apartment',
                    'With Parents',
                    'Municipal Apartment',
                    'Rented Apartment',
                    'Office Apartment'
                  ],
                  (value) => setState(() => _selectedHousingType = value),
                ),
                const SizedBox(height: 20),
                _buildTextField('daysBirth', _daysBirthController,
                    TextInputType.number, 'Please enter days since birth'),
                const SizedBox(height: 20),
                _buildTextField('daysEmployed', _daysEmployedController,
                    TextInputType.number, 'Please enter days employed'),
                const SizedBox(height: 20),
                _buildCustomDropdown(
                  'occupationType',
                  [
                    'Laborers',
                    'Core Staff',
                    'Managers',
                    'Drivers',
                    'Sales Staff',
                    'Accountants',
                    'High Skill Tech Staff',
                    'Medicine Staff',
                    'Security Staff',
                    'Cooking Staff',
                    'Cleaning Staff',
                    'Private Service Staff',
                    'Low-skill Laborers',
                    'Waiters/Barmen Staff',
                    'Secretaries',
                    'Realty Agents',
                    'HR Staff',
                    'IT Staff'
                  ],
                  (value) => setState(() => _selectedOccupationType = value),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                    'totalFamilyMembers',
                    _totalFamilyMembersController,
                    TextInputType.number,
                    'Please enter total family members'),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                      backgroundColor: const Color.fromARGB(255, 30, 51, 84),
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
            color: Colors.blueGrey[700],
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
      case 'gender':
        return _selectedGender;
      case 'incomeType':
        return _selectedIncomeType;
      case 'educationType':
        return _selectedEducationType;
      case 'familyStatus':
        return _selectedFamilyStatus;
      case 'housingType':
        return _selectedHousingType;
      case 'occupationType':
        return _selectedOccupationType;
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
            groupValue:
                fieldName == 'ownCar' ? _selectedOwnCar : _selectedOwnProperty,
            onChanged: (value) {
              setState(() {
                if (fieldName == 'ownCar') {
                  _selectedOwnCar = value!;
                } else if (fieldName == 'ownProperty') {
                  _selectedOwnProperty = value!;
                }
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile<String>(
            title: const Text('No'),
            value: 'no',
            groupValue:
                fieldName == 'ownCar' ? _selectedOwnCar : _selectedOwnProperty,
            onChanged: (value) {
              setState(() {
                if (fieldName == 'ownCar') {
                  _selectedOwnCar = value!;
                } else if (fieldName == 'ownProperty') {
                  _selectedOwnProperty = value!;
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
      CreditPerson userInput = CreditPerson(
        gender: _selectedGender ?? '',
        ownCar: _selectedOwnCar == 'yes',
        ownProperty: _selectedOwnProperty == 'yes',
        noOfChildren: int.parse(_noOfChildrenController.text),
        annualIncome: double.parse(_annualIncomeController.text),
        incomeType: _selectedIncomeType ?? '',
        educationType: _selectedEducationType ?? '',
        familyStatus: _selectedFamilyStatus ?? '',
        housingType: _selectedHousingType ?? '',
        daysBirth: int.parse(_daysBirthController.text),
        daysEmployed: int.parse(_daysEmployedController.text),
        occupationType: _selectedOccupationType ?? '',
        totalFamilyMembers: int.parse(_totalFamilyMembersController.text),
        result: false,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ResultScreen(userInput: userInput, dummyData: dummyCreditData),
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
