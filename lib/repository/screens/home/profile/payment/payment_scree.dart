import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:indicraft_major/repository/screens/home/profile/payment/payment_card.dart';

import 'add_payment_dialog.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> _addPaymentMethod(Map<String, dynamic> paymentData) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .collection('paymentMethods')
          .add({
        ...paymentData,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add payment: ${e.toString()}')),
      );
    }
  }

  Future<void> _setDefaultPayment(String paymentId) async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      // Remove default from all payments
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .collection('paymentMethods')
          .get();

      for (var doc in snapshot.docs) {
        transaction.update(doc.reference, {'isDefault': false});
      }

      // Set new default
      transaction.update(
        FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .collection('paymentMethods')
            .doc(paymentId),
        {'isDefault': true},
      );
    });
  }

  Future<void> _deletePayment(String paymentId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('paymentMethods')
        .doc(paymentId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddPaymentDialog(context),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .collection('paymentMethods')
            .orderBy('isDefault', descending: true)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data?.docs.isEmpty ?? true) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/empty_payments.png', width: 150),
                  const SizedBox(height: 20),
                  const Text('No payment methods saved'),
                  TextButton(
                    onPressed: () => _showAddPaymentDialog(context),
                    child: const Text('Add Payment Method'),
                  ),
                ],
              ),

            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final payment = snapshot.data!.docs[index];
              final data = payment.data() as Map<String, dynamic>;

              return PaymentCard(
                cardType: data['cardType'],
                last4Digits: data['last4Digits'],
                expiryDate: data['expiryDate'],
                cardHolder: data['cardHolder'],
                isDefault: data['isDefault'] ?? false,
                onSetDefault: () => _setDefaultPayment(payment.id),
                onDelete: () => _deletePayment(payment.id),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _showAddPaymentDialog(BuildContext context) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => const AddPaymentDialog(),
    );

    if (result != null) {
      await _addPaymentMethod(result);
    }
  }
}