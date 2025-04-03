import 'package:flutter/material.dart';
import 'package:mkadia/provider/UserProvider.dart';
import 'package:provider/provider.dart';

class AdminOrdersPage extends StatelessWidget {
  const AdminOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Panel"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Provider.of<UserProvider>(context, listen: false).logout();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildStatCard("Total Orders", "25"),
          _buildStatCard("Pending Orders", "10"),
          _buildStatCard("Completed Orders", "15"),
          const SizedBox(height: 20),
          _buildOrderItem("Order #1001", "Pending", "Ahmed - Pizza x2", "120 DH"),
          _buildOrderItem("Order #1002", "In Progress", "Fatima - Tajine x1", "85 DH"),
          _buildOrderItem("Order #1003", "Delivered", "Karim - Burger x1", "65 DH"),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(title, style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 5),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(String orderId, String status, String details, String total) {
    Color statusColor = Colors.grey;
    if (status == "Pending") statusColor = Colors.orange;
    if (status == "In Progress") statusColor = Colors.blue;
    if (status == "Delivered") statusColor = Colors.green;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(orderId, style: const TextStyle(fontWeight: FontWeight.bold)),
                Chip(
                  label: Text(status, style: const TextStyle(color: Colors.white)),
                  backgroundColor: statusColor,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(details),
            const SizedBox(height: 8),
            Text(total, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}