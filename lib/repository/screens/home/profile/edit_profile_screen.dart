import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  final Map<String, dynamic> userData;
  final VoidCallback onSave;

  const EditProfileScreen({
    super.key,
    required this.userData,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // Save to Firebase
              onSave();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              initialValue: userData['name'],
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            // Add other editable fields
          ],
        ),
      ),
    );
  }
}