import 'package:flutter/material.dart';
import 'package:mkadia/provider/cartProvider.dart';
import 'package:mkadia/views/home/widget/navbar.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Validation de la commande'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _placeOrder(context);
          },
          child: const Text('Confirmer la commande'),
        ),
      ),
    );
  }

  void _placeOrder(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.confirmOrder(); // Confirmer la commande via l'API

    // Naviguer vers la page de confirmation
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const BottomNavBar()),
    );
  }
}