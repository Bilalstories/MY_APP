// lib/models/category.dart

import 'package:flutter/material.dart';

class Service {
  final String name;
  final double price;
  final List<dynamic> fields;

  const Service({
    required this.name,
    required this.price,
    this.fields = const [],
  });
}

class Category {
  final String name;
  final String iconUrl;
  final List<Service> services;

  const Category({
    required this.name,
    required this.iconUrl,
    required this.services,
  });
}