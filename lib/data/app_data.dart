// lib/data/app_data.dart

import '../models/category.dart';

final List<Category> allCategories = [
  Category(
    name: 'Aadhaar',
    iconUrl: 'fingerprint',
    services: [
      Service(name: 'Aadhaar Update', price: 200, fields: [
        {'type': 'text', 'label': 'Aadhaar Number'},
        {'type': 'date', 'label': 'Date of Birth'},
      ]),
      Service(name: 'New Aadhaar Card', price: 500, fields: [
        {'type': 'text', 'label': 'Full Name'},
        {'type': 'text', 'label': 'Father\'s Name'},
      ]),
    ],
  ),
  Category(
    name: 'PAN',
    iconUrl: 'credit_card',
    services: [
      Service(name: 'New PAN Card', price: 150, fields: [
        {'type': 'text', 'label': 'Full Name'},
        {'type': 'text', 'label': 'Father\'s Name'},
      ]),
      Service(name: 'PAN Correction', price: 100, fields: [
        {'type': 'text', 'label': 'Old PAN Number'},
      ]),
    ],
  ),
  Category(
    name: 'Ration',
    iconUrl: 'local_grocery_store',
    services: [
      Service(name: 'Ration Card Application', price: 180, fields: [
        {'type': 'text', 'label': 'Applicant Name'},
        {'type': 'text', 'label': 'Family Members'},
      ]),
    ],
  ),
  Category(
    name: 'Land',
    iconUrl: 'map',
    services: [
      Service(name: 'Land Record Check', price: 300, fields: [
        {'type': 'text', 'label': 'Land Area'},
        {'type': 'text', 'label': 'Owner Name'},
      ]),
    ],
  ),
  Category(
    name: 'Voter ID',
    iconUrl: 'how_to_vote',
    services: [
      Service(name: 'Voter ID Registration', price: 250, fields: [
        {'type': 'text', 'label': 'Name'},
      ]),
    ],
  ),
];

final List<Category> quickServices = [
  Category(name: 'Aadhaar', iconUrl: 'fingerprint', services: []),
  Category(name: 'PAN', iconUrl: 'credit_card', services: []),
  Category(name: 'Ration', iconUrl: 'local_grocery_store', services: []),
  Category(name: 'Land', iconUrl: 'map', services: []),
];