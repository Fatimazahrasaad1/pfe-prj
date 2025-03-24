import 'package:flutter/material.dart';
import 'package:mkadia/models/order.dart';

class OrderProvider with ChangeNotifier {
  Order? _currentOrder;

  // Getters
  Order? get currentOrder => _currentOrder;

  // Définir une commande
  void setOrder(Order order) {
    _currentOrder = order;
    notifyListeners();
  }

  // Vider la commande actuelle
  void clearOrder() {
    _currentOrder = null;
    notifyListeners();
  }
}