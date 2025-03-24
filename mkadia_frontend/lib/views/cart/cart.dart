import 'package:flutter/material.dart';
import 'package:mkadia/common/color_extension.dart';
import 'package:mkadia/provider/cartProvider.dart';
import 'package:mkadia/views/cart/checkOut.dart';
import 'package:mkadia/views/home/widget/navbar.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
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
              "My Cart",
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
      backgroundColor: Colors.white,
      body: Consumer<CartProvider>(
        builder: (context, provider, child) {
          final finalList = provider.cart;

          return finalList.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img/panier.png',
                        width: 300,
                        height: 300,
                      ),
                      const SizedBox(height: 20),
                      const Column(
                        children: [
                          Text(
                            "Your Cart is empty",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text(
                            "Today is good day for you ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            "to make a choice ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: finalList.length,
                        itemBuilder: (context, index) {
                          final cartItems = finalList[index];
                          return Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: Image.network(cartItems['image_url']), // Utiliser l'URL de l'image
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cartItems['name'] ?? 'Nom non disponible',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 16),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            (cartItems['category'] != null && cartItems['category'] is Map) 
                                                ? cartItems['category']['name'] ?? 'Non catégorisé'
                                                : 'Non catégorisé',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.grey),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            "${cartItems['price']} MAD",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 35,
                                right: 35,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        provider.removeProduct(cartItems['id'].toString()); // Assurez-vous que c'est une chaîne
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 25),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey.shade200,
                                          width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 10),
                                          IconButton(
                                            icon: Icon(Icons.add),
                                            onPressed: () {
                                              provider.incrementQtn(cartItems['id'].toString()); // Assurez-vous que c'est une chaîne
                                            },
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            cartItems['quantity'].toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                          ),
                                          const SizedBox(width: 10),
                                          IconButton(
                                            icon: Icon(Icons.remove),
                                            onPressed: () {
                                              provider.decrementQtn(cartItems['id'].toString()); // Assurez-vous que c'est une chaîne
                                            },
                                          ),
                                          const SizedBox(width: 10),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                    CheckoutBox(),
                  ],
                );
        },
      ),
    );
  }
}