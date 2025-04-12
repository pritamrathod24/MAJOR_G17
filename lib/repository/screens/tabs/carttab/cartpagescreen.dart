// // import 'package:flutter/material.dart';
// //
// // class CartScreen extends StatefulWidget {
// //   const CartScreen({super.key});
// //
// //   @override
// //   State<CartScreen> createState() => _CartScreenState();
// // }
// //
// // class _CartScreenState extends State<CartScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Your Cart'),
// //         backgroundColor: const Color(0xFFE67F17),
// //       ),
// //       body: const Center(
// //         child: Text('Cart Content'),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:indicraft_major/repository/screens/tabs/carttab/cart_provider.dart';
//
// class CartScreen extends StatelessWidget {
//   const CartScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final cart = CartProvider.of(context);
//     final cartItems = cart?.items ?? [];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Your Cart'),
//         actions: [
//           if (cartItems.isNotEmpty)
//             IconButton(
//               icon: const Icon(Icons.delete),
//               onPressed: () {
//                 cart?.clearCart();
//               },
//             ),
//         ],
//       ),
//       body: cartItems.isEmpty
//           ? const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
//             SizedBox(height: 16),
//             Text('Your cart is empty', style: TextStyle(fontSize: 18)),
//           ],
//         ),
//       )
//           : Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: cartItems.length,
//               itemBuilder: (context, index) {
//                 final item = cartItems[index];
//                 return Dismissible(
//                   key: Key(item['id'] as String),
//                   direction: DismissDirection.endToStart,
//                   background: Container(
//                     color: Colors.red,
//                     alignment: Alignment.centerRight,
//                     padding: const EdgeInsets.only(right: 20),
//                     child: const Icon(Icons.delete, color: Colors.white),
//                   ),
//                   onDismissed: (direction) {
//                     cart?.removeFromCart(item);
//                   },
//                   child: Card(
//                     margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     child: Padding(
//                       padding: const EdgeInsets.all(12),
//                       child: Row(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: Image.asset(
//                               'assets/images/${item['image']}',
//                               width: 80,
//                               height: 80,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   item['name'],
//                                   style: const TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   '₹${item['price']}',
//                                   style: TextStyle(
//                                     color: Colors.deepOrange,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Row(
//                                   children: [
//                                     IconButton(
//                                       icon: const Icon(Icons.remove, size: 18),
//                                       onPressed: () {
//                                         cart?.decreaseQuantity(item);
//                                       },
//                                     ),
//                                     Text(
//                                       '${cart?.getQuantity(item['id'] as String) ?? 0}',
//                                       style: const TextStyle(fontSize: 16),
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(Icons.add, size: 18),
//                                       onPressed: () {
//                                         cart?.increaseQuantity(item);
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.2),
//                   spreadRadius: 2,
//                   blurRadius: 5,
//                   offset: const Offset(0, -2),
//                 ),
//               ],
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text('Subtotal:', style: TextStyle(fontSize: 16)),
//                     Text(
//                       '₹${cart?.subtotal ?? 0}',
//                       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text('Delivery:', style: TextStyle(fontSize: 16)),
//                     Text(
//                       '₹${cart?.deliveryCharge ?? 0}',
//                       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                     Text(
//                       '₹${(cart?.subtotal ?? 0) + (cart?.deliveryCharge ?? 0)}',
//                       style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.deepOrange),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     onPressed: () {},
//                     child: const Text('Proceed to Checkout', style: TextStyle(fontSize: 16)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:indicraft_major/repository/screens/tabs/carttab/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        actions: [
          if (cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => cart.clearCart(),
            ),
        ],
      ),
      body: cartItems.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Your cart is empty', style: TextStyle(fontSize: 18)),
          ],
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Dismissible(
                  key: Key(item['id']),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) => cart.removeFromCart(item),
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/${item['image']}',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item['name']),
                      subtitle: Text('₹${item['price']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => cart.decreaseQuantity(item),
                          ),
                          Text('${cart.getQuantity(item['id'])}'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => cart.increaseQuantity(item),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Subtotal:'),
                    Text('₹${cart.subtotal}'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Delivery:'),
                    Text('₹${cart.deliveryCharge}'),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      '₹${cart.subtotal + cart.deliveryCharge}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Proceed to Checkout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}