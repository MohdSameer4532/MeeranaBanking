import 'package:flutter/material.dart';
import 'credit_person.dart';
import 'credit_result_screen.dart';
import '../custom_app_bar.dart';
import '../custom_dropdown.dart';

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
  'yearsBirth': 'Age',
  'yearsEmployed': 'years Employed',
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
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        c: context,
        title: 'Credit Approval',
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
                CustomDropdown(
                  label: fieldLabels['gender']!,
                  items: ['Male', 'Female'],
                  value: _selectedGender,
                  onChanged: (value) => setState(() => _selectedGender = value),
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
                CustomDropdown(
                  label: fieldLabels['incomeType']!,
                  items: [
                    'Working',
                    'Commercial Associate',
                    'Pensioner',
                    'State Servant',
                    'Student'
                  ],
                  value: _selectedIncomeType,
                  onChanged: (value) =>
                      setState(() => _selectedIncomeType = value),
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: fieldLabels['educationType']!,
                  items: [
                    'Secondary',
                    'Higher Education',
                    'Incomplete Higher',
                    'Lower Secondary',
                    'Academic Degree'
                  ],
                  value: _selectedEducationType,
                  onChanged: (value) =>
                      setState(() => _selectedEducationType = value),
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: fieldLabels['familyStatus']!,
                  items: [
                    'Married',
                    'Single',
                    'Civil Marriage',
                    'Separated',
                    'Widow'
                  ],
                  value: _selectedFamilyStatus,
                  onChanged: (value) =>
                      setState(() => _selectedFamilyStatus = value),
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: fieldLabels['housingType']!,
                  items: [
                    'House/Apartment',
                    'With Parents',
                    'Municipal Apartment',
                    'Rented Apartment',
                    'Office Apartment'
                  ],
                  value: _selectedHousingType,
                  onChanged: (value) =>
                      setState(() => _selectedHousingType = value),
                ),
                const SizedBox(height: 20),
                _buildTextField('yearsBirth', _daysBirthController,
                    TextInputType.number, 'Please enter age'),
                const SizedBox(height: 20),
                _buildTextField('yearsEmployed', _daysEmployedController,
                    TextInputType.number, 'Please enter years employed'),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: fieldLabels['occupationType']!,
                  items: [
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
                  value: _selectedOccupationType,
                  onChanged: (value) =>
                      setState(() => _selectedOccupationType = value),
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
                          fontSize: 16, fontWeight: FontWeight.normal),
                      backgroundColor: Color.fromARGB(255, 34, 34, 34),
                    ),
                    child: const Text('Submit',
                        style: TextStyle(color: Colors.white)),
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
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter ${fieldLabels[fieldName]}',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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

  Widget _buildSectionHeader(String fieldName) {
    return Text(
      fieldLabels[fieldName]!,
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
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
        yearsBirth: int.parse(_daysBirthController.text),
        yearsEmployed: int.parse(_daysEmployedController.text),
        occupationType: _selectedOccupationType ?? '',
        totalFamilyMembers: int.parse(_totalFamilyMembersController.text),
        result: true,
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
