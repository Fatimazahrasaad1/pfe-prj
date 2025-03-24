import 'package:flutter/material.dart';
import 'package:mkadia/common/color_extension.dart';
import 'package:mkadia/models/product.dart';
import 'package:mkadia/provider/cartProvider.dart';
import 'package:mkadia/views/cart/cart.dart';
import 'package:mkadia/views/home/searchPage.dart';
import 'package:provider/provider.dart';

class SearchLoc extends StatelessWidget {
  const SearchLoc({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    final finalList = provider.cart;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Barre de recherche
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: GestureDetector(
                  onTap: () {
                    // Naviguer vers la page de recherche
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchPage(),
                      ),
                    );
                  },
                  child: TextField(
                    enabled: false, // Désactive la saisie directe
                    decoration: InputDecoration(
                      hintText: 'Search in Mkadia',
                      hintStyle: TextStyle(color: TColor.placeholder),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            // Icône du panier
            IconButton(
              icon: Stack(
                children: [
                  const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 38),
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
            ),
          ],
        ),
        const SizedBox(height: 15),

        // Affichage de la localisation
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on,
              color: Colors.white,
              size: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Current Location',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    fontFamily: "Montserrat",
                    color: TColor.secondaryText,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 4),

        // Affichage de "Safi.Marrakech" avec du padding
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Safi.Marrakech',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                fontFamily: "Montserrat",
                color: TColor.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}