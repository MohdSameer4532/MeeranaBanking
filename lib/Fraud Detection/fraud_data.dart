class FraudPerson {
  final String customer;
  final int age;
  final String gender;
  final String zipcodeOri;
  final String merchant;
  final String zipMerchant;
  final String category;
  final double amount;
  final bool fraudDetected;

  FraudPerson({
    required this.customer,
    required this.age,
    required this.gender,
    required this.zipcodeOri,
    required this.merchant,
    required this.zipMerchant,
    required this.category,
    required this.amount,
    this.fraudDetected = false, // Set default value to false
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
      fraudDetected: map['fraudDetected'] ?? false,
    );
  }

  get fraud => null;

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
      'fraudDetected': fraudDetected,
    };
  }
}

List<FraudPerson> getFraudPersons() {
  return [
    FraudPerson(
        customer: 'C1551465414',
        age: 21,
        gender: 'M',
        zipcodeOri: '28007',
        merchant: 'M1823072687',
        zipMerchant: '28007',
        category: 'es_transportation',
        amount: 1.51,
        fraudDetected: false),
    FraudPerson(
        customer: 'C623601481',
        age: 32,
        gender: 'M',
        zipcodeOri: '28007',
        merchant: 'M50039827',
        zipMerchant: '28007',
        category: 'es_health',
        amount: 68.79,
        fraudDetected: true),
    FraudPerson(
        customer: 'C1865204568',
        age: 35,
        gender: 'M',
        zipcodeOri: '28007',
        merchant: 'M1823072687',
        zipMerchant: '28007',
        category: 'es_transportation',
        amount: 20.32,
        fraudDetected: false),
    FraudPerson(
        customer: 'C156162339',
        age: 62,
        gender: 'F',
        zipcodeOri: '28007',
        merchant: 'M85975013',
        zipMerchant: '28007',
        category: 'es_food',
        amount: 32.6,
        fraudDetected: false),
    FraudPerson(
        customer: 'C2092526272',
        age: 56,
        gender: 'F',
        zipcodeOri: '28007',
        merchant: 'M840466850',
        zipMerchant: '28007',
        category: 'es_tech',
        amount: 163.56,
        fraudDetected: true),
    FraudPerson(
        customer: 'C1234567891',
        age: 45,
        gender: 'F',
        zipcodeOri: '28017',
        merchant: 'M123456789',
        zipMerchant: '28017',
        category: 'es_food',
        amount: 65.32,
        fraudDetected: false),
    FraudPerson(
        customer: 'C2345678901',
        age: 26,
        gender: 'M',
        zipcodeOri: '28018',
        merchant: 'M234567890',
        zipMerchant: '28018',
        category: 'es_health',
        amount: 70.10,
        fraudDetected: true),
    FraudPerson(
        customer: 'C3456789012',
        age: 24,
        gender: 'F',
        zipcodeOri: '28019',
        merchant: 'M345678901',
        zipMerchant: '28019',
        category: 'es_travel',
        amount: 90.75,
        fraudDetected: false),
    FraudPerson(
        customer: 'C4567890123',
        age: 33,
        gender: 'M',
        zipcodeOri: '28020',
        merchant: 'M456789012',
        zipMerchant: '28020',
        category: 'es_tech',
        amount: 350.45,
        fraudDetected: true),
    FraudPerson(
        customer: 'C5678901234',
        age: 33,
        gender: 'F',
        zipcodeOri: '28021',
        merchant: 'M567890123',
        zipMerchant: '28021',
        category: 'es_food',
        amount: 42.32,
        fraudDetected: false),
    FraudPerson(
        customer: 'C6789012345',
        age: 55,
        gender: 'M',
        zipcodeOri: '28022',
        merchant: 'M678901234',
        zipMerchant: '28022',
        category: 'es_transportation',
        amount: 78.90,
        fraudDetected: false),
    FraudPerson(
        customer: 'C7890123456',
        age: 28,
        gender: 'F',
        zipcodeOri: '28023',
        merchant: 'M789012345',
        zipMerchant: '28023',
        category: 'es_bills',
        amount: 120.75,
        fraudDetected: true),
    FraudPerson(
        customer: 'C8901234567',
        age: 39,
        gender: 'M',
        zipcodeOri: '28024',
        merchant: 'M890123456',
        zipMerchant: '28024',
        category: 'es_fashion',
        amount: 150.50,
        fraudDetected: true),
    FraudPerson(
        customer: 'C9012345678',
        age: 50,
        gender: 'F',
        zipcodeOri: '28025',
        merchant: 'M901234567',
        zipMerchant: '28025',
        category: 'es_automotive',
        amount: 75.25,
        fraudDetected: false),
    FraudPerson(
        customer: 'C0123456789',
        age: 34,
        gender: 'M',
        zipcodeOri: '28026',
        merchant: 'M012345678',
        zipMerchant: '28026',
        category: 'es_hyper',
        amount: 65.45,
        fraudDetected: false),
    FraudPerson(
        customer: 'C1122334455',
        age: 27,
        gender: 'F',
        zipcodeOri: '28027',
        merchant: 'M112233445',
        zipMerchant: '28027',
        category: 'es_tech',
        amount: 190.85,
        fraudDetected: true),
    FraudPerson(
        customer: 'C2233445566',
        age: 41,
        gender: 'M',
        zipcodeOri: '28028',
        merchant: 'M223344556',
        zipMerchant: '28028',
        category: 'es_contents',
        amount: 90.15,
        fraudDetected: false),
    FraudPerson(
        customer: 'C3344556677',
        age: 55,
        gender: 'F',
        zipcodeOri: '28029',
        merchant: 'M334455667',
        zipMerchant: '28029',
        category: 'es_wellnessandbeauty',
        amount: 130.45,
        fraudDetected: true),
    FraudPerson(
        customer: 'C4455667788',
        age: 63,
        gender: 'M',
        zipcodeOri: '28030',
        merchant: 'M445566778',
        zipMerchant: '28030',
        category: 'es_travel',
        amount: 70.25,
        fraudDetected: false),
    FraudPerson(
        customer: 'C5566778899',
        age: 37,
        gender: 'F',
        zipcodeOri: '28031',
        merchant: 'M556677889',
        zipMerchant: '28031',
        category: 'es_hometools',
        amount: 85.30,
        fraudDetected: false),
  ];
}
