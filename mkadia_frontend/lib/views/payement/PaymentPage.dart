import 'package:flutter/material.dart';
import 'package:mkadia/provider/PayementManager.dart';

class PaymentPage extends StatelessWidget {
  final PaymentManager paymentManager;

  const PaymentPage({super.key, required this.paymentManager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paiement'),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Adresse de Livraison',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  '${paymentManager.paymentInfo.address}, ${paymentManager.paymentInfo.city}, ${paymentManager.paymentInfo.country}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const Divider(),
            const SizedBox(height: 16),

            Text(
              'Méthode de Paiement',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),

            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sélectionnez une méthode de paiement:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 10,
                      children: ['Carte de Crédit', 'PayPal', 'Apple Pay', 'Google Pay'].map((method) {
                        return ElevatedButton(
                          onPressed: () {
                            paymentManager.setSelectedPaymentMethod(method);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: paymentManager.selectedPaymentMethod == method ? Colors.green : Colors.grey[300],
                            foregroundColor: paymentManager.selectedPaymentMethod == method ? Colors.white : Colors.black,
                          ),
                          child: Text(method),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            if (paymentManager.selectedPaymentMethod == 'Carte de Crédit') ...[
              _buildCreditCardForm(paymentManager),
            ] else if (paymentManager.selectedPaymentMethod == 'PayPal') ...[
              _buildPayPalForm(paymentManager),
            ] else if (paymentManager.selectedPaymentMethod == 'Apple Pay') ...[
              _buildApplePayForm(paymentManager),
            ] else if (paymentManager.selectedPaymentMethod == 'Google Pay') ...[
              _buildGooglePayForm(paymentManager),
            ],

            const SizedBox(height: 16),

            // Bouton aligné à droite
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    paymentManager.savePaymentInfo(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Confirmer et Payer', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreditCardForm(PaymentManager paymentManager) {
    return Column(
      children: [
        TextFormField(
          initialValue: paymentManager.paymentInfo.name,
          decoration: const InputDecoration(labelText: 'Nom sur la carte'),
          onChanged: (value) => paymentManager.updatePaymentInfo(paymentManager.paymentInfo.copyWith(name: value)),
        ),
        TextFormField(
          initialValue: paymentManager.paymentInfo.cardNumber,
          decoration: const InputDecoration(labelText: 'Numéro de carte'),
          keyboardType: TextInputType.number,
          onChanged: (value) => paymentManager.updatePaymentInfo(paymentManager.paymentInfo.copyWith(cardNumber: value)),
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: paymentManager.paymentInfo.expiryDate,
                decoration: const InputDecoration(labelText: 'Date d\'expiration'),
                onChanged: (value) => paymentManager.updatePaymentInfo(paymentManager.paymentInfo.copyWith(expiryDate: value)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                initialValue: paymentManager.paymentInfo.cvv,
                decoration: const InputDecoration(labelText: 'CVV'),
                obscureText: true,
                onChanged: (value) => paymentManager.updatePaymentInfo(paymentManager.paymentInfo.copyWith(cvv: value)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPayPalForm(PaymentManager paymentManager) {
    return Column(
      children: [
        TextFormField(
          initialValue: paymentManager.paymentInfo.paypalEmail,
          decoration: const InputDecoration(labelText: 'E-mail PayPal'),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => paymentManager.updatePaymentInfo(paymentManager.paymentInfo.copyWith(paypalEmail: value)),
        ),
      ],
    );
  }

  Widget _buildApplePayForm(PaymentManager paymentManager) {
    return Column(
      children: [
        TextFormField(
          initialValue: paymentManager.paymentInfo.applePayID,
          decoration: const InputDecoration(labelText: 'Apple Pay ID'),
          keyboardType: TextInputType.text,
          onChanged: (value) => paymentManager.updatePaymentInfo(paymentManager.paymentInfo.copyWith(applePayID: value)),
        ),
      ],
    );
  }

  Widget _buildGooglePayForm(PaymentManager paymentManager) {
    return Column(
      children: [
        TextFormField(
          initialValue: paymentManager.paymentInfo.googlePayID,
          decoration: const InputDecoration(labelText: 'Google Pay ID'),
          keyboardType: TextInputType.text,
          onChanged: (value) => paymentManager.updatePaymentInfo(paymentManager.paymentInfo.copyWith(googlePayID: value)),
        ),
      ],
    );
  }
}