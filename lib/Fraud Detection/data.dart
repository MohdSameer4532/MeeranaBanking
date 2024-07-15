class FraudPerson {
  final String customer;
  final int age;
  final String gender;
  final String zipcodeOri;
  final String merchant;
  final String zipMerchant;
  final String category;
  final double amount;

  FraudPerson({
    required this.customer,
    required this.age,
    required this.gender,
    required this.zipcodeOri,
    required this.merchant,
    required this.zipMerchant,
    required this.category,
    required this.amount,
  });

  factory FraudPerson.fromMap(Map<String, dynamic> map) {
    return FraudPerson(
      customer: map['customer'],
      age: map['age'],
      gender: map['gender'],
      zipcodeOri: map['zipcodeOri'],
      merchant: map['merchant'],
      zipMerchant: map['zipMerchant'],
      category: map['category'],
      amount: (map['amount'] is int)
          ? (map['amount'] as int).toDouble()
          : map['amount'],
    );
  }

  get daysBirth => null;

  get status => null;

  Map<String, dynamic> toMap() {
    return {
      'customer': customer,
      'age': age,
      'gender': gender,
      'zipcodeOri': zipcodeOri,
      'merchant': merchant,
      'zipMerchant': zipMerchant,
      'category': category,
      'amount': amount,
    };
  }
}

final List<Map<String, dynamic>> dummyData = [
  {
    'customer': 'C1551465414',
    'age': 21,
    'gender': 'M',
    'zipcodeOri': '28007',
    'merchant': 'M1823072687',
    'zipMerchant': '28007',
    'category': 'es_transportation',
    'amount': 1.51,
  },
  {
    'customer': 'C623601481',
    'age': 32,
    'gender': 'M',
    'zipcodeOri': '28007',
    'merchant': 'M50039827',
    'zipMerchant': '28007',
    'category': 'es_health',
    'amount': 68.79,
  },
  {
    'customer': 'C1865204568',
    'age': 35,
    'gender': 'M',
    'zipcodeOri': '28007',
    'merchant': 'M1823072687',
    'zipMerchant': '28007',
    'category': 'es_transportation',
    'amount': 20.32,
  },
  {
    'customer': 'C156162339',
    'age': 62,
    'gender': 'F',
    'zipcodeOri': '28007',
    'merchant': 'M85975013',
    'zipMerchant': '28007',
    'category': 'es_food',
    'amount': 32.6,
  },
  {
    'customer': 'C2092526272',
    'age': 56,
    'gender': 'F',
    'zipcodeOri': '28007',
    'merchant': 'M840466850',
    'zipMerchant': '28007',
    'category': 'es_tech',
    'amount': 163.56,
  },
  {
    'customer': 'C1234567891',
    'age': 45,
    'gender': 'F',
    'zipcodeOri': '28017',
    'merchant': 'M123456789',
    'zipMerchant': '28017',
    'category': 'es_food',
    'amount': 65.32,
  },
  {
    'customer': 'C2345678901',
    'age': 26,
    'gender': 'M',
    'zipcodeOri': '28018',
    'merchant': 'M234567890',
    'zipMerchant': '28018',
    'category': 'es_health',
    'amount': 70.10,
  },
  {
    'customer': 'C3456789012',
    'age': 24,
    'gender': 'F',
    'zipcodeOri': '28019',
    'merchant': 'M345678901',
    'zipMerchant': '28019',
    'category': 'es_travel',
    'amount': 90.75,
  },
  {
    'customer': 'C4567890123',
    'age': 33,
    'gender': 'M',
    'zipcodeOri': '28020',
    'merchant': 'M456789012',
    'zipMerchant': '28020',
    'category': 'es_tech',
    'amount': 350.45,
  },
  {
    'customer': 'C5678901234',
    'age': 33,
    'gender': 'F',
    'zipcodeOri': '28021',
    'merchant': 'M567890123',
    'zipMerchant': '28021',
    'category': 'es_food',
    'amount': 42.32,
  },
  {
    'customer': 'C6789012345',
    'age': 55,
    'gender': 'M',
    'zipcodeOri': '28022',
    'merchant': 'M678901234',
    'zipMerchant': '28022',
    'category': 'es_transportation',
    'amount': 78.90,
  },
];

List<FraudPerson> getFraudPersons() {
  return dummyData.map((data) => FraudPerson.fromMap(data)).toList();
}
