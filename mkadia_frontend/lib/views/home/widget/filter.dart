import 'package:flutter/material.dart';
import 'package:mkadia/models/product.dart';
import 'package:mkadia/views/home/widget/productCard.dart';


class Filter extends StatelessWidget {
  final List<Product> filteredProducts;
  final String categoryName;

  const Filter({
    super.key,
    required this.filteredProducts,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter: $categoryName"),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.78,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            return ProductCard(product: filteredProducts[index]);
          },
        ),
      ),
    );
  }
}
