class Service {
  final String name;
  final double price;

  Service({required this.name, required this.price});
}

class Category {
  final String name;
  final String iconUrl;
  final List<Service> services;

  Category({required this.name, required this.iconUrl, required this.services});
}
