import 'package:flutter/material.dart';
import 'package:mkadia/common/color_extension.dart';
import 'package:mkadia/models/order.dart';
import 'package:mkadia/views/ConfirmationOrder/Widgets/OrderSummaryCard.dart';
import 'package:mkadia/views/ConfirmationOrder/Widgets/PaymentMethodCard.dart';
import 'package:mkadia/views/Delivery/Widgets/DeliveryDetailsCard.dart';
import 'package:mkadia/views/Delivery/Widgets/PaymentDetailsCard.dart';

class DeliveryConfirmationPage extends StatelessWidget {
  final Order order;

  const DeliveryConfirmationPage({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {

    final double totalProducts = double.parse(
      (order.items.fold(0.0, (sum, item) => sum + (item.price * item.quantity))).toStringAsFixed(2)
    );    
    final double tax = double.parse(
      (totalProducts * 0.1).toStringAsFixed(2)
    ); 
    final double deliveryFee = 10; 
    final double totalAmount = double.parse((totalProducts + tax + deliveryFee).toStringAsFixed(2));

    return Scaffold(
      backgroundColor: Colors.white,
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
              icon: Icon(
                Icons.arrow_back_ios, 
                color: TColor.primary, 
              ),
              onPressed: () {
                Navigator.pop(context); 
              },
            ),
            title:  Text(
                "Delivery Confirmation",
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DeliveryDetailsCard(order: order),
            const PaymentMethodCard(),
            OrderSummaryCard(order: order),
            PaymentDetailsCard(
              totalProducts: totalProducts,
              tax: tax,
              deliveryFee: deliveryFee,
              totalAmount: totalAmount,
              order: order,
            ),
          ],
        ),
      ),
    );
  }
}