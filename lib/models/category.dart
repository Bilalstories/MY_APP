import 'package:flutter/material.dart';

class Service {
  final String name;
  final double price;
  final double fee; // Add this property
  final List<dynamic> fields; // Add this property

  Service({required this.name, required this.price, this.fee = 0.0, this.fields = const []});
}

class Category {
  final String name;
  final String iconUrl;
  final List<Service> services;

  Category({required this.name, required this.iconUrl, required this.services});
}