import 'package:flutter/material.dart';
import 'package:mkadia/provider/PayementManager.dart';
import 'package:provider/provider.dart';

class PaymentSavePage extends StatelessWidget {
  final PaymentManager paymentManager;

  PaymentSavePage({required this.paymentManager});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: paymentManager,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Méthodes de Paiement'),
          backgroundColor: Colors.green,
        ),
        backgroundColor: Colors.green[50],
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<PaymentManager>(
            builder: (context, paymentManager, child) {
              return Column(
                children: [
                  _buildPaymentOption(context, 'Carte de Crédit', 'assets/icons/creditcard.png'),
                  SizedBox(height: 10),
                  _buildPaymentOption(context, 'PayPal', 'assets/icons/paypal.png'),
                  SizedBox(height: 10),
                  _buildPaymentOption(context, 'Apple Pay', 'assets/icons/apple-pay.png'),
                  SizedBox(height: 10),
                  _buildPaymentOption(context, 'Google Pay', 'assets/icons/google-pay.png'),
                  SizedBox(height: 20),
                  _buildPaymentFields(paymentManager), // Ajout du champ ID selon la sélection
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      paymentManager.savePaymentInfo(context);
                    },
                    child: Text('Enregistrer'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentFields(PaymentManager manager) {
    switch (manager.selectedPaymentMethod) {
      case 'Carte de Crédit':
        return Column(
          children: [
            _buildTextField('Numéro de carte', manager.paymentInfo.cardNumber, (value) {
              manager.updatePaymentInfo(manager.paymentInfo.copyWith(cardNumber: value));
            }),
            _buildTextField('Date d\'expiration (MM/AA)', manager.paymentInfo.expiryDate, (value) {
              manager.updatePaymentInfo(manager.paymentInfo.copyWith(expiryDate: value));
            }),
            _buildTextField('CVV', manager.paymentInfo.cvv, (value) {
              manager.updatePaymentInfo(manager.paymentInfo.copyWith(cvv: value));
            }, obscureText: true),
          ],
        );
      case 'PayPal':
        return _buildTextField('E-mail PayPal', manager.paymentInfo.paypalEmail ?? '', (value) {
          manager.updatePaymentInfo(manager.paymentInfo.copyWith(paypalEmail: value));
        });
      case 'Apple Pay':
        return _buildTextField('ID Apple Pay', manager.paymentInfo.applePayID ?? '', (value) {
          manager.updatePaymentInfo(manager.paymentInfo.copyWith(applePayID: value));
        });
      case 'Google Pay':
        return _buildTextField('ID Google Pay', manager.paymentInfo.googlePayID ?? '', (value) {
          manager.updatePaymentInfo(manager.paymentInfo.copyWith(googlePayID: value));
        });
      default:
        return Container();
    }
  }

  Widget _buildPaymentOption(BuildContext context, String method, String iconPath) {
    return GestureDetector(
      onTap: () {
        Provider.of<PaymentManager>(context, listen: false).setSelectedPaymentMethod(method);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Image.asset(iconPath, height: 40),
              SizedBox(width: 20),
              Text(
                method,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String value, Function(String) onChanged, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: TextEditingController(text: value),
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: onChanged,
      ),
    );
  }
}