import 'package:flutter/material.dart';
import 'package:mkadia/models/order.dart';

class DeliveryDetailsCard extends StatelessWidget {
  final Order order;

  const DeliveryDetailsCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your order from Mkadia is on its way!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            'Order code: ${order.id}',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 15),

          const Text(
            'Ship to:',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.location_on, size: 20, color: Colors.grey),
              const SizedBox(width: 10),
              Text(
                order.delivery.address,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 15),

          const Text(
            'Ship at:',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.access_time, size: 20, color: Colors.grey),
              const SizedBox(width: 10),
              Text(
                '${order.delivery.estimatedDeliveryTime.hour}:${order.delivery.estimatedDeliveryTime.minute}',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}