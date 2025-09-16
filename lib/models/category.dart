// lib/models/category.dart

import 'package:flutter/material.dart';
import 'package:my_app/models/form_model.dart';

class Category {
  const Category({
    required this.name,
    required this.iconData,
    required this.services,
  });

  final String name;
  final IconData iconData;
  final List<Service> services;
}

class Service {
  const Service({
    required this.name,
    required this.price,
    required this.form,
  });

  final String name;
  final int price;
  final FormModel form;
}