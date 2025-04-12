// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../services/auth_service.dart';
//
// class ProfileTab extends StatelessWidget {
//   const ProfileTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Profile'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.edit),
//             onPressed: () {
//               // Navigate to edit profile screen
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             // Profile Photo Section
//             Stack(
//               alignment: Alignment.bottomRight,
//               children: [
//                 CircleAvatar(
//                   radius: 60,
//                   backgroundImage: user?.photoURL != null
//                       ? NetworkImage(user!.photoURL!)
//                       : const AssetImage('assets/images/default_profile.png') as ImageProvider,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.orange,
//                     shape: BoxShape.circle,
//                     border: Border.all(color: Colors.white, width: 2),
//                   ),
//                   child: IconButton(
//                     icon: const Icon(Icons.camera_alt, color: Colors.white),
//                     onPressed: () {
//                       // Add photo upload functionality
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//
//             // User Information
//             Card(
//               elevation: 3,
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   children: [
//                     _buildProfileItem(
//                       icon: Icons.person,
//                       title: 'Username',
//                       value: user?.displayName ?? 'Not set',
//                     ),
//                     const Divider(),
//                     _buildProfileItem(
//                       icon: Icons.email,
//                       title: 'Email',
//                       value: user?.email ?? 'No email',
//                     ),
//                     const Divider(),
//                     _buildProfileItem(
//                       icon: Icons.phone,
//                       title: 'Phone',
//                       value: user?.phoneNumber ?? 'Not provided',
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//
//             // Account Actions
//             Card(
//               elevation: 3,
//               child: Column(
//                 children: [
//                   ListTile(
//                     leading: const Icon(Icons.lock),
//                     title: const Text('Change Password'),
//                     onTap: () {
//                       // Navigate to password change screen
//                     },
//                   ),
//                   const Divider(height: 0),
//                   ListTile(
//                     leading: const Icon(Icons.history),
//                     title: const Text('Order History'),
//                     onTap: () {
//                       // Navigate to order history
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 30),
//
//             // Logout Button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton.icon(
//                 icon: const Icon(Icons.logout),
//                 label: const Text('Logout'),
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 15),
//                   backgroundColor: Colors.red[50],
//                   foregroundColor: Colors.red,
//                 ),
//                 onPressed: () async {
//                   await _showLogoutDialog(context);
//                 },
//               ),
//             ),
//
//             // Login Provider Info
//             if (user?.providerData.isNotEmpty ?? false)
//               Padding(
//                 padding: const EdgeInsets.only(top: 20),
//                 child: Text(
//                   'Logged in via ${user?.providerData[0].providerId.replaceAll('.com', '')}',
//                   style: TextStyle(
//                     color: Colors.grey[600],
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProfileItem({
//     required IconData icon,
//     required String title,
//     required String value,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Icon(icon, color: Colors.orange),
//           const SizedBox(width: 15),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   color: Colors.grey,
//                 ),
//               ),
//               const SizedBox(height: 2),
//               Text(
//                 value,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _showLogoutDialog(BuildContext context) async {
//     return showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Logout Confirmation'),
//         content: const Text('Are you sure you want to logout?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () async {
//               Navigator.pop(context);
//               await logout(context);
//             },
//             child: const Text(
//               'Logout',
//               style: TextStyle(color: Colors.red),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indicraft_major/repository/screens/home/profile/payment/payment_scree.dart';
import 'package:indicraft_major/repository/screens/home/profile/reviews_screeen.dart';
import '../../services/auth_service.dart';
import 'address_screen.dart';
import 'edit_profile_screen.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final User? user = FirebaseAuth.instance.currentUser;
  late Future<DocumentSnapshot> _userData;
  int _orderCount = 0;
  int _addressCount = 0;
  int _reviewCount = 0;

  @override
  void initState() {
    super.initState();
    _userData = _fetchUserData();
    _loadCounts();
  }

  Future<DocumentSnapshot> _fetchUserData() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
  }

  Future<void> _loadCounts() async {
    final orders = await FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: user?.uid)
        .get();

    final addresses = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('addresses')
        .get();

    final reviews = await FirebaseFirestore.instance
        .collection('reviews')
        .where('userId', isEqualTo: user?.uid)
        .get();

    setState(() {
      _orderCount = orders.size;
      _addressCount = addresses.size;
      _reviewCount = reviews.size;
    });
  }

  Future<void> _updateProfilePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Upload to Firebase Storage and update profile
      // (Implementation depends on your storage setup)
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: _userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final userData = snapshot.data?.data() as Map<String, dynamic>? ?? {};

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Profile Header
                _buildProfileHeader(userData),
                const SizedBox(height: 24),

                // Profile Sections
                _buildProfileCard(
                  title: 'My Orders',
                  subtitle: 'Already have $_orderCount orders',
                  icon: Icons.shopping_bag,
                  onTap: () {}
                  // => Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (_) => const OrdersScreen()),
                  // ),
                ),
                _buildProfileCard(
                  title: 'Shipping Addresses',
                  subtitle: '$_addressCount addresses',
                  icon: Icons.location_on,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddressScreen()),
                  ),
                ),
                _buildProfileCard(
                  title: 'Payment Methods',
                  subtitle: userData['paymentMethod'] ?? 'Add payment method',
                  icon: Icons.credit_card,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PaymentScreen()),
                  ),
                ),
                _buildProfileCard(
                  title: 'Promocodes',
                  subtitle: 'You have special promocodes',
                  icon: Icons.local_offer,
                  onTap: () {},
                ),
                _buildProfileCard(
                  title: 'My Reviews',
                  subtitle: 'Reviews for $_reviewCount items',
                  icon: Icons.star,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ReviewsScreen()),
                  ),
                ),
                _buildProfileCard(
                  title: 'Settings',
                  subtitle: 'Notifications, password',
                  icon: Icons.settings,
                  onTap: () {},
                ),

                // Logout Button
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.red[50],
                      foregroundColor: Colors.red,
                    ),
                    onPressed: () => _confirmLogout(context),
                    child: const Text('Logout'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(Map<String, dynamic> userData) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: user?.photoURL != null
                  ? NetworkImage(user!.photoURL!)
                  : const AssetImage('assets/default_avatar.png') as ImageProvider,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              child: GestureDetector(
                onTap: _updateProfilePhoto,
                child: const Icon(Icons.edit, size: 20, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          userData['name'] ?? 'No Name',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          user?.email ?? 'No email',
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EditProfileScreen(
                userData: userData,
                onSave: () => setState(() {
                  _userData = _fetchUserData();
                }),
              ),
            ),
          ),
          child: const Text('Edit Profile'),
        ),
      ],
    );
  }

  Widget _buildProfileCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await logout1(context);
      // Navigate to login screen and clear stack
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/LoginPage',
            (route) => false,
      );
    }
  }
}