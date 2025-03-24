import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mkadia/common/color_extension.dart';
import 'package:intl/intl.dart';
import 'package:mkadia/provider/cartProvider.dart';
import 'package:mkadia/views/cart/cart.dart';
import 'package:provider/provider.dart';

class PromoDetailsPage extends StatelessWidget {
  final Map<String, dynamic> promotion;

  const PromoDetailsPage({Key? key, required this.promotion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Convertir les champs en nombres avec gestion des erreurs
    double minPurchaseAmount;
    double discount;

    try {
      minPurchaseAmount = double.parse(promotion['min_purchase_amount'].toString());
    } catch (e) {
      minPurchaseAmount = 0.0; // Valeur par défaut
    }

    try {
      discount = double.parse(promotion['value'].toString());
    } catch (e) {
      discount = 0.0; // Valeur par défaut
    }

    // Exemple de comparaison
    if (minPurchaseAmount > 0) {
      print('Montant minimum d\'achat requis: $minPurchaseAmount');
    } else {
      print('Pas de montant minimum d\'achat');
    }

    // Formatage des dates
    DateTime startDate = DateTime.parse(promotion['start_date']);
    DateTime endDate = DateTime.parse(promotion['end_date']);
    String formattedStartDate = DateFormat('dd/MM/yyyy').format(startDate);
    String formattedEndDate = DateFormat('dd/MM/yyyy').format(endDate);

    // Texte de réduction en fonction du type
    String discountText = '';
    switch (promotion['type']) {
      case 'percentage':
        discountText = '$discount% de réduction';
        break;
      case 'fixed_amount':
        discountText = '$discount DH de réduction';
        break;
      case 'free_shipping':
        discountText = 'Livraison gratuite';
        break;
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
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              "Promotion Details",
              style: TextStyle(
                color: TColor.primary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    final finalList = cartProvider.cart;
                    return IconButton(
                      icon: Stack(
                        children: [
                          const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                            size: 38,
                          ),
                          if (finalList.isNotEmpty)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.all(0.25),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 15,
                                  minHeight: 15,
                                ),
                                child: Text(
                                  finalList.length.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Cart()),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  ClipRRect(
                    borderRadius: BorderRadius.circular(15), 
                    child: Image.network(
                      promotion['image_url'],
                      height: 200,
                      fit: BoxFit.cover, 
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    promotion['title'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  
                  const SizedBox(height: 5),
                  
                  // Description
                  if (promotion['description'] != null)
                    Text(
                      promotion['description'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                  
                  const SizedBox(height: 15),
                  
                  // Détails de la promotion
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Détails de l\'offre',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          
                          const Divider(),
                          
                          // Type de réduction
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.discount, color: Colors.amber),
                            title: Text(discountText),
                          ),
                          
                          // Montant minimum d'achat
                          if (minPurchaseAmount > 0)
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.shopping_cart, color: Colors.amber),
                              title: Text('Achat minimum: $minPurchaseAmount DH'),
                            ),
                          
                          // Période de validité
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.date_range, color: Colors.amber),
                            title: Text('Valable du $formattedStartDate au $formattedEndDate'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Code promo
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Code Promo',
                          style: TextStyle(
                            fontSize: 16,
                            color: TColor.primaryText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal:14, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[400]!),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                promotion['code'],
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              
                              const SizedBox(width: 10),
                              
                              IconButton(
                                icon: const Icon(Icons.copy),
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(text: promotion['code']));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Code copié dans le presse-papiers'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}