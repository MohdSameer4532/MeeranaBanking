class LoanPerson {
  final double income;
  final double age;
  final double experience;
  final double currentJobYears;
  final double currentHouseYears;
  final String maritalStatus;
  final String houseOwnership;
  final String carOwnership;
  final String profession;
  final String loanStatus;

  LoanPerson({
    required this.income,
    required this.age,
    required this.experience,
    required this.currentJobYears,
    required this.currentHouseYears,
    required this.maritalStatus,
    required this.houseOwnership,
    required this.carOwnership,
    required this.profession,
    required this.loanStatus,
  });

  factory LoanPerson.fromMap(Map<String, dynamic> map) {
    return LoanPerson(
      income: (map['income'] ?? 0).toDouble(),
      age: (map['age'] ?? 0).toDouble(),
      experience: (map['experience'] ?? 0).toDouble(),
      currentJobYears: (map['currentJobYears'] ?? 0).toDouble(),
      currentHouseYears: (map['currentHouseYears'] ?? 0).toDouble(),
      maritalStatus: map['maritalStatus'] ?? '',
      houseOwnership: map['houseOwnership'] ?? '',
      carOwnership: map['carOwnership'] ?? '',
      profession: map['profession'] ?? '',
      loanStatus: map['loanStatus'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'income': income,
      'age': age,
      'experience': experience,
      'currentJobYears': currentJobYears,
      'currentHouseYears': currentHouseYears,
      'maritalStatus': maritalStatus,
      'houseOwnership': houseOwnership,
      'carOwnership': carOwnership,
      'profession': profession,
      'loanStatus': loanStatus,
    };
  }
}

final List<Map<String, dynamic>> dummyData = [
  {
    'income': 55000,
    'age': 35,
    'experience': 10,
    'currentJobYears': 5,
    'currentHouseYears': 4,
    'maritalStatus': 'Married',
    'houseOwnership': 'Owned',
    'carOwnership': 'Yes',
    'profession': 'Engineer',
    'loanStatus': 'Accepted',
  },
  {
    'income': 48000,
    'age': 29,
    'experience': 6,
    'currentJobYears': 2,
    'currentHouseYears': 1,
    'maritalStatus': 'Single',
    'houseOwnership': 'Rented',
    'carOwnership': 'No',
    'profession': 'Teacher',
    'loanStatus': 'Denied',
  },
  {
    'income': 62000,
    'age': 40,
    'experience': 15,
    'currentJobYears': 7,
    'currentHouseYears': 5,
    'maritalStatus': 'Married',
    'houseOwnership': 'Owned',
    'carOwnership': 'Yes',
    'profession': 'Doctor',
    'loanStatus': 'Accepted',
  },
  {
    'income': 47000,
    'age': 32,
    'experience': 8,
    'currentJobYears': 3,
    'currentHouseYears': 3,
    'maritalStatus': 'Single',
    'houseOwnership': 'Rented',
    'carOwnership': 'No',
    'profession': 'Chef',
    'loanStatus': 'Denied',
  },
  {
    'income': 75000,
    'age': 45,
    'experience': 20,
    'currentJobYears': 10,
    'currentHouseYears': 8,
    'maritalStatus': 'Married',
    'houseOwnership': 'Owned',
    'carOwnership': 'Yes',
    'profession': 'Engineer',
    'loanStatus': 'Accepted',
  },
  {
    'income': 54000,
    'age': 28,
    'experience': 5,
    'currentJobYears': 3,
    'currentHouseYears': 2,
    'maritalStatus': 'Single',
    'houseOwnership': 'Rented',
    'carOwnership': 'No',
    'profession': 'Teacher',
    'loanStatus': 'Denied',
  },
  {
    'income': 68000,
    'age': 38,
    'experience': 12,
    'currentJobYears': 6,
    'currentHouseYears': 4,
    'maritalStatus': 'Married',
    'houseOwnership': 'Owned',
    'carOwnership': 'Yes',
    'profession': 'Doctor',
    'loanStatus': 'Accepted',
  },
  {
    'income': 45000,
    'age': 30,
    'experience': 7,
    'currentJobYears': 4,
    'currentHouseYears': 3,
    'maritalStatus': 'Single',
    'houseOwnership': 'Rented',
    'carOwnership': 'No',
    'profession': 'Chef',
    'loanStatus': 'Denied',
  },
  {
    'income': 72000,
    'age': 42,
    'experience': 18,
    'currentJobYears': 9,
    'currentHouseYears': 6,
    'maritalStatus': 'Married',
    'houseOwnership': 'Owned',
    'carOwnership': 'Yes',
    'profession': 'Engineer',
    'loanStatus': 'Accepted',
  },
  {
    'income': 51000,
    'age': 31,
    'experience': 6,
    'currentJobYears': 3,
    'currentHouseYears': 2,
    'maritalStatus': 'Single',
    'houseOwnership': 'Rented',
    'carOwnership': 'No',
    'profession': 'Teacher',
    'loanStatus': 'Denied',
  },
];

List<LoanPerson> getLoanPersons() {
  return dummyData.map((data) => LoanPerson.fromMap(data)).toList();
}
