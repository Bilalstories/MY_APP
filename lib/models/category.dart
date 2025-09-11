class Service {
  final String name;
  final double fee;
  // fields: list of maps like { 'key': 'field_key', 'label': 'Label', 'type': 'text' }
  final List<Map<String, dynamic>> fields;

  Service({
    required this.name,
    required this.fee,
    this.fields = const [],
  });
}

class Category {
  final String name;
  final String iconUrl;
  final List<Service> services;

  Category({
    required this.name,
    required this.iconUrl,
    required this.services,
  });
}
