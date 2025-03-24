import 'package:flutter/material.dart';
import 'package:mkadia/views/Delivery/livreur.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test Livreur Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LivreurPage(),
    );
  }
}
