import 'package:mkadia/models/delivery.dart';
import 'package:mkadia/models/product.dart';

class Order {
  final String id;
  final List<Product> items;
  final double totalAmount;
  final DateTime orderDate;
  final Delivery delivery;

  Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    required this.delivery,
  });
}