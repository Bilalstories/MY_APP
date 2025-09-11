import '../models/category.dart';

final List<Category> categories = [
  Category(
    name: "Banks",
    iconUrl: "assets/icons/bank.png",
    services: [
      Service(
        name: "Bank Account Opening",
        fee: 100.0,
        fields: [
          {'key': 'name', 'label': 'Full Name', 'type': 'text'},
          {'key': 'aadhaar', 'label': 'Aadhaar Number', 'type': 'text'},
          {'key': 'mobile', 'label': 'Mobile Number', 'type': 'text'},
        ],
      ),
      Service(
        name: "ATM Card Apply",
        fee: 50.0,
        fields: [
          {'key': 'account', 'label': 'Account Number', 'type': 'text'},
          {'key': 'address', 'label': 'Address', 'type': 'text'},
        ],
      ),
    ],
  ),
];
