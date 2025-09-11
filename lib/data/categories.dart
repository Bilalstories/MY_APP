import '../models/category.dart';

final categories = [
  Category(
    name: 'Aadhar Card Services',
    iconUrl: '',
    services: [
      Service(name: 'New Aadhar Card', price: 250.0),
      Service(name: 'Aadhar Name Correction', price: 900.0),
      Service(name: 'Aadhar Card Name Correction (wife name, spelling etc.)', price: 900.0),
      Service(name: 'Aadhar Card Address Update', price: 120.0),
      Service(name: 'C/O Update', price: 120.0),
      Service(name: 'Aadhar Pan Link Status', price: 20.0),
      Service(name: 'Link Your Aadhar Pan', price: 1100.0),
    ],
  ),
  Category(
    name: 'Bank Accounts',
    iconUrl: '',
    services: [
      Service(name: 'Airtel Payment Bank', price: 300.0),
      Service(name: 'FI Bank - Zero Chargeable Bank', price: 100.0),
      Service(name: 'SBI Zero Balance Bank Account', price: 300.0),
      Service(name: 'Zero Balance Kotak Bank Account', price: 300.0),
      Service(name: 'Union Bank Account', price: 100.0),
      Service(name: 'Jupiter Bank Account - Zero Balance Account', price: 100.0),
      Service(name: 'Kotak Mahindra Bank - 811', price: 300.0),
      Service(name: 'Axis Amaze Bank Account Zero Balance', price: 300.0),
      Service(name: 'Bank Of Baroda Account', price: 100.0),
    ],
  ),
  // ... Add all your other categories in the same format
];
