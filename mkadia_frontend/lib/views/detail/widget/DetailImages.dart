import 'package:flutter/material.dart';

class DetailImages extends StatelessWidget {
  final String image;
  const DetailImages({
    super.key, 
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Image.network(
        image,
        width: double.infinity,
        fit: BoxFit.contain,
      ),
    );
  }
}