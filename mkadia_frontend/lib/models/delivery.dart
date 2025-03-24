import 'package:mkadia/models/driver.dart';

enum DeliveryStatus {
  preparing,
  inTransit,
  delivered,
}

class Delivery {
  final String id;
  final String orderId;
  final DeliveryStatus status;
  final DateTime estimatedDeliveryTime;
  final Driver driver;
  final String address; 
  final String? notes;

  Delivery({
    required this.id,
    required this.orderId,
    required this.status,
    required this.estimatedDeliveryTime,
    required this.driver,
    required this.address, 
    this.notes,
  });
}
final List<Delivery> deliveries = [
  Delivery(
    id: "DL001",
    orderId: "ORD123",
    status: DeliveryStatus.inTransit,
    estimatedDeliveryTime: DateTime.now().add(const Duration(hours: 2)),
    driver: drivers[0],
    address: "123 Rue de l'Exemple, Ville", 
    notes: "Leave at the front door.",
  ),
  Delivery(
    id: "DL002",
    orderId: "ORD124",
    status: DeliveryStatus.preparing,
    estimatedDeliveryTime: DateTime.now().add(const Duration(hours: 3)),
    driver: drivers[1],
    address: "456 Avenue des Tests, Ville", 
    notes: "Call upon arrival.",
  ),
];
