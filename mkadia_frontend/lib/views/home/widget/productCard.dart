import 'package:flutter/material.dart';
import 'package:mkadia/common/color_extension.dart';
import 'package:mkadia/views/detail/detail.dart';

class ProductCard extends StatelessWidget {
  final dynamic product; 
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Convertir product['id'] en int
        final productId = int.tryParse(product['id'].toString());
        if (productId != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Detail(productId: productId), 
            ),
          );
        } else {
          print('Invalid product ID');
        }
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(31, 232, 228, 228),
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Image.network(
                    product['image_url'], 
                    width: 110,
                    height: 110,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  product['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  product['weight'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  "${product['price']} Mad",
                  style: TextStyle(
                    fontFamily: "ZabalDemo",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: TColor.primaryText,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}