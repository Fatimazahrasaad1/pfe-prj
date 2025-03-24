import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _cart = [];
   final List<Map<String, dynamic>> _confirmedItems = []; // Produits confirmés
  bool _isOrderConfirmed = false; // État de la commande

  List<Map<String, dynamic>> get cart => _cart;
  List<Map<String, dynamic>> get confirmedItems => _confirmedItems;
  bool get isOrderConfirmed => _isOrderConfirmed;

  void toggleFavorite(Map<String, dynamic> product, int quantity) async {
    final existingProductIndex = _cart.indexWhere((p) => p['id'].toString() == product['id'].toString());
    if (existingProductIndex != -1) {
      _cart[existingProductIndex]['quantity'] += quantity;
    } else {
      product['quantity'] = quantity;
      product['id'] = product['id'].toString();
      _cart.add(product);
    }
    notifyListeners();
  }

  void incrementQtn(String productId) {
    final productIndex = _cart.indexWhere((p) => p['id'].toString() == productId);
    if (productIndex != -1) {
      _cart[productIndex]['quantity']++;
      notifyListeners();
    }
  }

  void decrementQtn(String productId) {
    final productIndex = _cart.indexWhere((p) => p['id'].toString() == productId);
    if (productIndex != -1) {
      if (_cart[productIndex]['quantity'] > 1) {
        _cart[productIndex]['quantity']--;
      } else {
        _cart.removeAt(productIndex);
      }
      notifyListeners();
    }
  }

  void removeProduct(String productId) {
    _cart.removeWhere((p) => p['id'].toString() == productId);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  // Confirmer la commande
  void confirmOrder() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/orders');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': 1, // Remplacez par l'ID de l'utilisateur connecté
        'items': _cart.map((item) => {
          'product_id': item['id'],
          'quantity': item['quantity'],
          'price': item['price'],
        }).toList(),
      }),
    );

    if (response.statusCode == 201) {
      _confirmedItems.addAll(_cart); // Copier les produits dans la liste confirmée
      _cart.clear(); // Vider le panier (affichage seulement)
      _isOrderConfirmed = true; // Marquer la commande comme confirmée
      notifyListeners();
    } else {
      throw Exception('Failed to confirm order');
    }
  }

  // Réinitialiser la commande
  void resetOrder() {
    _isOrderConfirmed = false;
    notifyListeners();
  }

  // Vider les produits confirmés
  void clearConfirmedItems() {
    _confirmedItems.clear();
    notifyListeners();
  }

  double totalPrice() {
    double total = 0.0;
    for (Map<String, dynamic> element in _cart) {
      total += double.parse(element['price'].toString()) * element['quantity'];
    }
    return double.parse(total.toStringAsFixed(2));
  }

  static CartProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<CartProvider>(context, listen: listen);
  }
}