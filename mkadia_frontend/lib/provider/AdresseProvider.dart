import 'package:flutter/material.dart';

class AdresseProvider extends ChangeNotifier {
  String _address = '123 Rue Exemple';
  String _city = 'Paris';
  String _postalCode = '75001';

  String get address => _address;
  String get city => _city;
  String get postalCode => _postalCode;

  void updateAdresse(String address, String city, String postalCode) {
    _address = address;
    _city = city;
    _postalCode = postalCode;
    notifyListeners(); // Notifie l'UI des changements
  }
}