import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:indicraft_major/repository/screens/home/profile/address_card.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  String _addressType = 'Home';
  bool _isDefault = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  Future<void> _addAddress() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .collection('addresses')
            .add({
          'name': _nameController.text,
          'phone': _phoneController.text,
          'address': _addressController.text,
          'city': _cityController.text,
          'state': _stateController.text,
          'pincode': _pincodeController.text,
          'type': _addressType,
          'isDefault': _isDefault,
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Clear form after submission
        _formKey.currentState!.reset();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Address added successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _setDefaultAddress(String addressId) async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      // Remove default from all addresses
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .collection('addresses')
          .get();

      for (var doc in snapshot.docs) {
        transaction.update(doc.reference, {'isDefault': false});
      }

      // Set new default
      transaction.update(
        FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .collection('addresses')
            .doc(addressId),
        {'isDefault': true},
      );
    });
  }

  Future<void> _deleteAddress(String addressId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('addresses')
        .doc(addressId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipping Addresses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddAddressDialog(context),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .collection('addresses')
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
                  Image.asset('assets/images/empty_address.jpg', width: 150),
                  const SizedBox(height: 20),
                  const Text('No addresses saved yet'),
                  TextButton(
                    onPressed: () => _showAddAddressDialog(context),
                    child: const Text('Add Your First Address'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final address = snapshot.data!.docs[index];
              final data = address.data() as Map<String, dynamic>;

              return AddressCard(
                name: data['name'],
                phone: data['phone'],
                address: data['address'],
                city: data['city'],
                state: data['state'],
                pincode: data['pincode'],
                type: data['type'],
                isDefault: data['isDefault'] ?? false,
                onSetDefault: () => _setDefaultAddress(address.id),
                onEdit: () => _showEditAddressDialog(context, address.id, data),
                onDelete: () => _deleteAddress(address.id),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _showAddAddressDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Address'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'Full Address'),
                  maxLines: 3,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _cityController,
                        decoration: const InputDecoration(labelText: 'City'),
                        validator: (value) => value!.isEmpty ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _stateController,
                        decoration: const InputDecoration(labelText: 'State'),
                        validator: (value) => value!.isEmpty ? 'Required' : null,
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: _pincodeController,
                  decoration: const InputDecoration(labelText: 'Pincode'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _addressType,
                  items: ['Home', 'Work', 'Other']
                      .map((type) => DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  ))
                      .toList(),
                  onChanged: (value) => setState(() => _addressType = value!),
                  decoration: const InputDecoration(labelText: 'Address Type'),
                ),
                SwitchListTile(
                  title: const Text('Set as default address'),
                  value: _isDefault,
                  onChanged: (value) => setState(() => _isDefault = value),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _addAddress();
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditAddressDialog(
      BuildContext context, String addressId, Map<String, dynamic> data) async {
    final nameController = TextEditingController(text: data['name']);
    final phoneController = TextEditingController(text: data['phone']);
    final addressController = TextEditingController(text: data['address']);
    final cityController = TextEditingController(text: data['city']);
    final stateController = TextEditingController(text: data['state']);
    final pincodeController = TextEditingController(text: data['pincode']);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Address'),
        content: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                ),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: 'Full Address'),
                  maxLines: 3,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: cityController,
                        decoration: const InputDecoration(labelText: 'City'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: stateController,
                        decoration: const InputDecoration(labelText: 'State'),
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: pincodeController,
                  decoration: const InputDecoration(labelText: 'Pincode'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user?.uid)
                  .collection('addresses')
                  .doc(addressId)
                  .update({
                'name': nameController.text,
                'phone': phoneController.text,
                'address': addressController.text,
                'city': cityController.text,
                'state': stateController.text,
                'pincode': pincodeController.text,
              });
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );

    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    pincodeController.dispose();
  }
}