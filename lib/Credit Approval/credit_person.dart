class CreditPerson {
  final String gender;
  final bool ownCar;
  final bool ownProperty;
  final int noOfChildren;
  final double annualIncome;
  final String incomeType;
  final String educationType;
  final String familyStatus;
  final String housingType;
  final int daysBirth;
  final int daysEmployed;
  final String occupationType;
  final int totalFamilyMembers;
  final bool result;

  CreditPerson({
    required this.gender,
    required this.ownCar,
    required this.ownProperty,
    required this.noOfChildren,
    required this.annualIncome,
    required this.incomeType,
    required this.educationType,
    required this.familyStatus,
    required this.housingType,
    required this.daysBirth,
    required this.daysEmployed,
    required this.occupationType,
    required this.totalFamilyMembers,
    required this.result,
  });

  get education => null;

  get maritalStatus => null;
}

List<CreditPerson> dummyCreditData = [
  CreditPerson(
    gender: 'M',
    ownCar: true,
    ownProperty: false,
    noOfChildren: 2,
    annualIncome: 120000,
    incomeType: 'Working',
    educationType: 'Higher education',
    familyStatus: 'Married',
    housingType: 'House / apartment',
    daysBirth: -12000,
    daysEmployed: -2000,
    occupationType: 'Manager',
    totalFamilyMembers: 4,
    result: true, // Added result
  ),
  CreditPerson(
    gender: 'F',
    ownCar: false,
    ownProperty: true,
    noOfChildren: 1,
    annualIncome: 100000,
    incomeType: 'Commercial associate',
    educationType: 'Secondary education',
    familyStatus: 'Single',
    housingType: 'Rented apartment',
    daysBirth: -10000,
    daysEmployed: -1500,
    occupationType: 'Sales staff',
    totalFamilyMembers: 2,
    result: false,
  ),
  CreditPerson(
    gender: 'M',
    ownCar: true,
    ownProperty: true,
    noOfChildren: 3,
    annualIncome: 150000,
    incomeType: 'State servant',
    educationType: 'Higher education',
    familyStatus: 'Married',
    housingType: 'Municipal apartment',
    daysBirth: -15000,
    daysEmployed: -3000,
    occupationType: 'Doctor',
    totalFamilyMembers: 5,
    result: true, // Added result
  ),
  CreditPerson(
    gender: 'F',
    ownCar: false,
    ownProperty: false,
    noOfChildren: 0,
    annualIncome: 80000,
    incomeType: 'Pensioner',
    educationType: 'Incomplete higher',
    familyStatus: 'Widow',
    housingType: 'Co-op apartment',
    daysBirth: -18000,
    daysEmployed: -1000,
    occupationType: 'Laborers',
    totalFamilyMembers: 1,
    result: false, // Added result
  ),
  CreditPerson(
    gender: 'M',
    ownCar: true,
    ownProperty: true,
    noOfChildren: 2,
    annualIncome: 200000,
    incomeType: 'Working',
    educationType: 'Higher education',
    familyStatus: 'Civil marriage',
    housingType: 'Office apartment',
    daysBirth: -11000,
    daysEmployed: -2500,
    occupationType: 'Core staff',
    totalFamilyMembers: 4,
    result: true, // Added result
  ),
  CreditPerson(
    gender: 'F',
    ownCar: false,
    ownProperty: false,
    noOfChildren: 0,
    annualIncome: 95000,
    incomeType: 'Commercial associate',
    educationType: 'Secondary education',
    familyStatus: 'Single',
    housingType: 'House / apartment',
    daysBirth: -12500,
    daysEmployed: -1700,
    occupationType: 'Waiters/barmen staff',
    totalFamilyMembers: 1,
    result: false, // Added result
  ),
  CreditPerson(
    gender: 'M',
    ownCar: true,
    ownProperty: true,
    noOfChildren: 1,
    annualIncome: 180000,
    incomeType: 'State servant',
    educationType: 'Higher education',
    familyStatus: 'Married',
    housingType: 'With parents',
    daysBirth: -14000,
    daysEmployed: -2200,
    occupationType: 'High skill tech staff',
    totalFamilyMembers: 3,
    result: true, // Added result
  ),
  CreditPerson(
    gender: 'F',
    ownCar: false,
    ownProperty: true,
    noOfChildren: 2,
    annualIncome: 130000,
    incomeType: 'Working',
    educationType: 'Higher education',
    familyStatus: 'Married',
    housingType: 'Rented apartment',
    daysBirth: -16000,
    daysEmployed: -2100,
    occupationType: 'Medicine staff',
    totalFamilyMembers: 4,
    result: true, // Added result
  ),
  CreditPerson(
    gender: 'M',
    ownCar: true,
    ownProperty: true,
    noOfChildren: 3,
    annualIncome: 170000,
    incomeType: 'Commercial associate',
    educationType: 'Higher education',
    familyStatus: 'Civil marriage',
    housingType: 'House / apartment',
    daysBirth: -17000,
    daysEmployed: -2700,
    occupationType: 'Security staff',
    totalFamilyMembers: 5,
    result: true, // Added result
  ),
  CreditPerson(
    gender: 'F',
    ownCar: false,
    ownProperty: false,
    noOfChildren: 0,
    annualIncome: 85000,
    incomeType: 'Pensioner',
    educationType: 'Incomplete higher',
    familyStatus: 'Widow',
    housingType: 'Co-op apartment',
    daysBirth: -19000,
    daysEmployed: -800,
    occupationType: 'Drivers',
    totalFamilyMembers: 1,
    result: false, // Added result
  ),
];
