import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  final String cardType;
  final String last4Digits;
  final String expiryDate;
  final String cardHolder;
  final bool isDefault;
  final VoidCallback onSetDefault;
  final VoidCallback onDelete;

  const PaymentCard({
    super.key,
    required this.cardType,
    required this.last4Digits,
    required this.expiryDate,
    required this.cardHolder,
    required this.isDefault,
    required this.onSetDefault,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  _getCardIcon(cardType),
                  width: 40,
                  height: 40,
                ),
                if (isDefault)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'DEFAULT',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '•••• •••• •••• $last4Digits',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('Expires ${expiryDate}'),
                const SizedBox(width: 16),
                Text(cardHolder),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                if (!isDefault)
                  TextButton(
                    onPressed: onSetDefault,
                    child: const Text('Set as Default'),
                  ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getCardIcon(String type) {
    switch (type.toLowerCase()) {
      case 'visa':
        return 'assets/images/visa.png';
      case 'mastercard':
        return 'assets/images/mastercard.png';
      case 'amex':
        return 'assets/images/amex.png';
      case 'rupay':
        return 'assets/images/rupay.png';
      default:
        return 'assets/images/credit_card.png';
    }
  }
}