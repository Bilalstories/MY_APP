// lib/models/application.dart

class Application {
  final String trackingNumber;
  final String serviceName;
  final String status;

  const Application({
    required this.trackingNumber,
    required this.serviceName,
    required this.status,
  });
}