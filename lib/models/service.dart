// lib/models/service.dart

import 'form_model.dart';

class Service {
  final String name;
  final int price;
  final FormModel? form; // नया फ़ील्ड

  Service({
    required this.name,
    required this.price,
    this.form, // form को optional बनाया गया है
  });
}