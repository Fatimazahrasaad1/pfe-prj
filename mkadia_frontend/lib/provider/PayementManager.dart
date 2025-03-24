import 'package:flutter/material.dart';

class PaymentInfo {
  String cardNumber;
  String expiryDate;
  String cvv;
  String name;
  String address;
  String city;
  String country;
  String? applePayID;
  String? googlePayID;
  String? paypalEmail;

  PaymentInfo({
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.name,
    required this.address,
    required this.city,
    required this.country,
    this.applePayID,
    this.googlePayID,
    this.paypalEmail,
  });

  PaymentInfo copyWith({
    String? cardNumber,
    String? expiryDate,
    String? cvv,
    String? name,
    String? address,
    String? city,
    String? country,
    String? applePayID,
    String? googlePayID,
    String? paypalEmail,
  }) {
    return PaymentInfo(
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
      name: name ?? this.name,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      applePayID: applePayID ?? this.applePayID,
      googlePayID: googlePayID ?? this.googlePayID,
      paypalEmail: paypalEmail ?? this.paypalEmail,
    );
  }
}

class PaymentManager extends ChangeNotifier {
  PaymentInfo _paymentInfo = PaymentInfo(
    cardNumber: '',
    expiryDate: '',
    cvv: '',
    name: '',
    address: '',
    city: '',
    country: '',
  );

  String _selectedPaymentMethod = 'Carte de Crédit';

  PaymentInfo get paymentInfo => _paymentInfo;
  String get selectedPaymentMethod => _selectedPaymentMethod;

  void setSelectedPaymentMethod(String method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }

  void updatePaymentInfo(PaymentInfo newInfo) {
    _paymentInfo = newInfo;
    notifyListeners();
  }

  void savePaymentInfo(BuildContext context) {
    print('Informations de paiement sauvegardées: $_paymentInfo');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Informations de paiement sauvegardées avec succès!')),
    );
  }
}