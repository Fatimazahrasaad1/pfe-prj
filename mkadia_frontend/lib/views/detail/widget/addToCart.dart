import 'package:flutter/material.dart';
import 'package:mkadia/common/color_extension.dart';
import 'package:mkadia/provider/cartProvider.dart';

class AddToCart extends StatefulWidget {
  final Map<String, dynamic> product; 
  const AddToCart({super.key, required this.product});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        children: [
          // fond transparent 
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.8),
                    Colors.white.withOpacity(0.9),
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Contenu du bouton AddToCart
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Boutons de quantité
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: TColor.primaryText,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (currentIndex > 1) {
                            setState(() {
                              currentIndex--;
                            });
                          }
                        },
                        iconSize: 18,
                        icon: Icon(
                          Icons.remove,
                          color: TColor.primaryText,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        currentIndex.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: TColor.primaryText,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 5),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            currentIndex++;
                          });
                        },
                        iconSize: 18,
                        icon: Icon(
                          Icons.add,
                          color: TColor.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    provider.toggleFavorite(widget.product, currentIndex);

                    showDialog(
                      context: context,
                      barrierDismissible: false, // Empêche de fermer en cliquant à l'extérieur
                      builder: (BuildContext context) {
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.of(context).pop();
                        });

                        return Dialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: TColor.primaryText,
                                  size: 50,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "Successfully added!",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 55,
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                      color: TColor.primaryText,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: TColor.primary,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Add to Cart",
                          style: TextStyle(
                            color: TColor.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}