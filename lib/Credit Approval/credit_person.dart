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
  final int yearsBirth;
  final int yearsEmployed;
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
    required this.yearsBirth,
    required this.yearsEmployed,
    required this.occupationType,
    required this.totalFamilyMembers,
    required this.result,
  });
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
    yearsBirth: 33, // Converted from -12000 days
    yearsEmployed: 5, // Converted from -2000 days
    occupationType: 'Manager',
    totalFamilyMembers: 4,
    result: true,
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
    yearsBirth: 27, // Converted from -10000 days
    yearsEmployed: 4, // Converted from -1500 days
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
    yearsBirth: 41, // Converted from -15000 days
    yearsEmployed: 8, // Converted from -3000 days
    occupationType: 'Doctor',
    totalFamilyMembers: 5,
    result: true,
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
    yearsBirth: 49, // Converted from -18000 days
    yearsEmployed: 3, // Converted from -1000 days
    occupationType: 'Laborers',
    totalFamilyMembers: 1,
    result: false,
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
    yearsBirth: 30, // Converted from -11000 days
    yearsEmployed: 7, // Converted from -2500 days
    occupationType: 'Core staff',
    totalFamilyMembers: 4,
    result: true,
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
    yearsBirth: 34, // Converted from -12500 days
    yearsEmployed: 5, // Converted from -1700 days
    occupationType: 'Waiters/barmen staff',
    totalFamilyMembers: 1,
    result: false,
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
    yearsBirth: 38, // Converted from -14000 days
    yearsEmployed: 6, // Converted from -2200 days
    occupationType: 'High skill tech staff',
    totalFamilyMembers: 3,
    result: true,
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
    yearsBirth: 44, // Converted from -16000 days
    yearsEmployed: 6, // Converted from -2100 days
    occupationType: 'Medicine staff',
    totalFamilyMembers: 4,
    result: true,
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
    yearsBirth: 47, // Converted from -17000 days
    yearsEmployed: 7, // Converted from -2700 days
    occupationType: 'Security staff',
    totalFamilyMembers: 5,
    result: true,
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
    yearsBirth: 52, // Converted from -19000 days
    yearsEmployed: 2, // Converted from -800 days
    occupationType: 'Drivers',
    totalFamilyMembers: 1,
    result: false,
  ),
  CreditPerson(
    gender: 'M',
    ownCar: false,
    ownProperty: true,
    noOfChildren: 1,
    annualIncome: 110000,
    incomeType: 'Working',
    educationType: 'Incomplete higher',
    familyStatus: 'Separated',
    housingType: 'House / apartment',
    yearsBirth: 36,
    yearsEmployed: 8,
    occupationType: 'IT staff',
    totalFamilyMembers: 2,
    result: true,
  ),
  CreditPerson(
    gender: 'F',
    ownCar: true,
    ownProperty: false,
    noOfChildren: 2,
    annualIncome: 140000,
    incomeType: 'Commercial associate',
    educationType: 'Higher education',
    familyStatus: 'Married',
    housingType: 'Municipal apartment',
    yearsBirth: 39,
    yearsEmployed: 10,
    occupationType: 'Accountants',
    totalFamilyMembers: 4,
    result: true,
  ),
  CreditPerson(
    gender: 'M',
    ownCar: true,
    ownProperty: true,
    noOfChildren: 0,
    annualIncome: 250000,
    incomeType: 'Working',
    educationType: 'Higher education',
    familyStatus: 'Single',
    housingType: 'Office apartment',
    yearsBirth: 42,
    yearsEmployed: 15,
    occupationType: 'Managers',
    totalFamilyMembers: 1,
    result: true,
  ),
  CreditPerson(
    gender: 'F',
    ownCar: false,
    ownProperty: false,
    noOfChildren: 1,
    annualIncome: 75000,
    incomeType: 'State servant',
    educationType: 'Secondary education',
    familyStatus: 'Civil marriage',
    housingType: 'Rented apartment',
    yearsBirth: 29,
    yearsEmployed: 3,
    occupationType: 'Low-skill Laborers',
    totalFamilyMembers: 3,
    result: false,
  ),
  CreditPerson(
    gender: 'M',
    ownCar: true,
    ownProperty: false,
    noOfChildren: 3,
    annualIncome: 160000,
    incomeType: 'Working',
    educationType: 'Higher education',
    familyStatus: 'Married',
    housingType: 'House / apartment',
    yearsBirth: 45,
    yearsEmployed: 12,
    occupationType: 'Sales staff',
    totalFamilyMembers: 5,
    result: true,
  ),
];
