import 'package:flutter/material.dart';
import 'package:mkadia/views/Delivery/TrackingPage.dart';
import 'package:mkadia/views/home/widget/navbar.dart';

class NavigationButtons extends StatelessWidget {
  const NavigationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DeliveryTrackingPage(),
                ),
              );
            },
            child: const Text('Suivre la livraison'),
          ),
          const SizedBox(height: 10),
          TextButton(
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
        ],
      ),
    );
  }
}