import 'package:flutter/material.dart';
import 'package:mkadia/provider/AdresseProvider.dart';
import 'package:mkadia/provider/BottomNavProvider.dart';
import 'package:mkadia/provider/PasswordProvider.dart';
import 'package:mkadia/provider/PayementManager.dart';
import 'package:mkadia/provider/UserProvider.dart'; // Assurez-vous que c'est exactement "UserProvider"import 'package:mkadia/provider/provi_confidentialit%C3%A9.dart';
import 'package:mkadia/provider/searchProvider.dart';
import 'package:mkadia/views/login/home.dart';
import 'package:mkadia/provider/OrderProvider.dart';
import 'package:mkadia/provider/cartProvider.dart';
import 'package:provider/provider.dart';
import 'package:mkadia/provider/provi_confidentialité.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => BottomNavProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => OrderProvider()),
          ChangeNotifierProvider(create: (_) => SearchProvider()),
          ChangeNotifierProvider(create: (_) => AdresseProvider()),
          ChangeNotifierProvider(create: (_) => PrivacySettingsProvider()),
          ChangeNotifierProvider(create: (_) => PasswordProvider()),
          ChangeNotifierProvider(create: (_) => PaymentManager()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Zabal',
          ),
          home: const HomeScreen(),
        ),
      );
}
