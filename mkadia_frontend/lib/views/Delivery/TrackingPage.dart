import 'package:flutter/material.dart';
import 'package:mkadia/common/color_extension.dart';
import 'package:mkadia/models/delivery.dart';
import 'package:mkadia/provider/OrderProvider.dart';
import 'package:mkadia/provider/cartProvider.dart';
import 'package:mkadia/views/Delivery/ConfirmationPage.dart';
import 'package:mkadia/views/home/widget/navbar.dart';
import 'package:provider/provider.dart';

class DeliveryTrackingPage extends StatelessWidget {
  const DeliveryTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final delivery = orderProvider.currentOrder?.delivery;

    if (delivery == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Suivi de Livraison'),
        ),
        body: const Center(
          child: Text('Aucune livraison trouvée.'),
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          child: AppBar(
            toolbarHeight: 80,
            backgroundColor: TColor.primaryText,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Suivi de Livraison",
              style: TextStyle(
                color: TColor.primary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Espace réservé pour la carte
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Center(
                child: Text(
                  'Carte (espace réservé)',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Informations sur l'état de la commande
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'État de la commande',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          _getDeliveryStatusIcon(delivery.status),
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _getDeliveryStatusText(delivery.status),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Contact du livreur
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Contact du livreur',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      leading: const Icon(Icons.person, color: Colors.grey),
                      title: Text(delivery.driver.name),
                      subtitle: Text(delivery.driver.phone),
                    ),
                  ],
                ),
              ),
            ),

            // Boutons de navigation
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BottomNavBar(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text('Retour à l\'accueil'),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      // Récupérer l'order actuel
                      final order = orderProvider.currentOrder;
                      final cartProvider = Provider.of<CartProvider>(context, listen: false);

                       if (order != null) {
                        // Réinitialiser la commande actuelle
                        orderProvider.clearOrder();
                        // Vider les produits confirmés
                        cartProvider.clearConfirmedItems();
                        // Naviguer vers la page de confirmation de livraison sans pouvoir revenir
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeliveryConfirmationPage(order: order),
                          )
                        );
                      } else {
                        // Afficher un message d'erreur si l'order est null
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Aucune commande trouvée.')),
                        );
                      }
                    },
                    child: const Text('Confirmer la livraison'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Méthode pour obtenir l'icône en fonction de l'état de la livraison
  IconData _getDeliveryStatusIcon(DeliveryStatus status) {
    switch (status) {
      case DeliveryStatus.preparing:
        return Icons.timer;
      case DeliveryStatus.inTransit:
        return Icons.directions_bike;
      case DeliveryStatus.delivered:
        return Icons.check_circle;
      default:
        return Icons.error;
    }
  }

  // Méthode pour obtenir le texte en fonction de l'état de la livraison
  String _getDeliveryStatusText(DeliveryStatus status) {
    switch (status) {
      case DeliveryStatus.preparing:
        return 'En préparation';
      case DeliveryStatus.inTransit:
        return 'En cours de livraison';
      case DeliveryStatus.delivered:
        return 'Livré';
      default:
        return 'Statut inconnu';
    }
  }
}