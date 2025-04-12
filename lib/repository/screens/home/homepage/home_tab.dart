// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
//
// class Homepage extends StatelessWidget {
//   const Homepage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildHeader(context),
//           _buildFestivalBanner(),
//           _buildCategorySection(),
//           _buildFeaturedProducts(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHeader(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Icon(Icons.location_pin, color: Theme.of(context).primaryColor),
//               const SizedBox(width: 8),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text('DELIVER TO', style: TextStyle(fontSize: 12, color: Colors.grey)),
//                   Text('New York, USA',
//                       style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                         fontWeight: FontWeight.bold,
//                       )),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           TextField(
//             decoration: InputDecoration(
//               hintText: 'Search sarees, handicrafts...',
//               prefixIcon: const Icon(Icons.search),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide.none,
//               ),
//               filled: true,
//               fillColor: Colors.grey[200],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFestivalBanner() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.orange[700]!, Colors.orange[900]!],
//         ),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text('FESTIVAL SALE', style: TextStyle(color: Colors.white, fontSize: 14)),
//                 const Text('30% OFF on Handicrafts',
//                     style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 8),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.orange[800],
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                   ),
//                   onPressed: () {},
//                   child: const Text('Shop Now', style: TextStyle(fontWeight: FontWeight.bold)),
//                 )
//               ],
//             ),
//           ),
//           Image.asset('assets/images/image1.jpg', width: 80, height: 80),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCategorySection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.0),
//           child: Text('Shop By Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         ),
//         const SizedBox(height: 12),
//         _buildCategoryRow(),
//       ],
//     );
//   }
//
//   Widget _buildCategoryRow() {
//     const categories = [
//       {'name': 'Apparel', 'icon': Icons.checkroom, 'color': Colors.purple, 'image': 'image2.jpg'},
//       {'name': 'Handicraft', 'icon': Icons.brush, 'color': Colors.blue, 'image': 'image3.jpg'},
//       {'name': 'Etiquette', 'icon': Icons.emoji_objects, 'color': Colors.green, 'image': 'image4.jpg'},
//       {'name': 'Artisans', 'icon': Icons.people, 'color': Colors.red, 'image': 'image5.jpg'},
//     ];
//
//     return SizedBox(
//       height: 100,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: categories.length,
//         itemBuilder: (context, index) {
//           return InkWell(
//             onTap: () {
//               // Add navigation/functionality
//             },
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: Column(
//                 children: [
//                   Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       color: categories[index]['color'] as Color,
//                       shape: BoxShape.circle,
//                       image: DecorationImage(
//                         image: AssetImage('assets/images/${categories[index]['image']}'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(categories[index]['name'] as String),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildFeaturedProducts() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
//           child: Text('Handpicked for You', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         ),
//         _buildProductGrid(),
//       ],
//     );
//   }
//
//   Widget _buildProductGrid() {
//     final products = [
//       {
//         'name': 'Banarasi Silk Saree',
//         'type': 'Varanasi Weaving',
//         'price': '₹4,299',
//         'rating': '4.8',
//         'image': 'image6.jpg',
//         'category': 'Apparel'
//       },
//       // Add more products with image7.jpg, image8.jpg etc.
//     ];
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: StaggeredGrid.count(
//         crossAxisCount: 2,
//         mainAxisSpacing: 16,
//         crossAxisSpacing: 16,
//         children: [
//           for (final product in products) _buildProductCard(product),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProductCard(Map<String, dynamic> product) {
//     return InkWell(
//       onTap: () {
//         // Add navigation to product detail
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                   child: Image.asset(
//                     'assets/images/${product['image']}',
//                     height: 150,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Positioned(
//                   top: 8,
//                   left: 8,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                     decoration: BoxDecoration(
//                       color: Colors.black.withOpacity(0.6),
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Icon(Icons.star, color: Colors.orange, size: 14),
//                         const SizedBox(width: 4),
//                         Text(
//                           product['rating'],
//                           style: const TextStyle(color: Colors.white, fontSize: 12),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product['name'],
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     product['type'],
//                     style: TextStyle(color: Colors.grey[600], fontSize: 12),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         product['price'],
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.deepOrange,
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.favorite_border, size: 20),
//                         onPressed: () {},
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
//
// class Homepage extends StatelessWidget {
//   const Homepage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildHeader(context),
//           _buildFestivalBanner(),
//           _buildCategorySection(),
//           _buildFeaturedProducts(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHeader(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           // Location Row
//           Row(
//             children: [
//               Icon(Icons.location_pin, color: Theme.of(context).primaryColor),
//               const SizedBox(width: 8),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text('DELIVER TO', style: TextStyle(fontSize: 12, color: Colors.grey)),
//                   Text('New York, USA',
//                       style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                         fontWeight: FontWeight.bold,
//                       )),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           // Search Bar
//           TextField(
//             decoration: InputDecoration(
//               hintText: 'Search sarees, handicrafts...',
//               prefixIcon: const Icon(Icons.search),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide.none,
//               ),
//               filled: true,
//               fillColor: Colors.grey[200],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFestivalBanner() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.orange[700]!, Colors.orange[900]!],
//         ),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                 const Text('FESTIVAL SALE', style: TextStyle(color: Colors.white, fontSize: 14)),
//             const Text('30% OFF on Handicrafts',
//                 style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 foregroundColor: Colors.orange[800],
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//               ),
//               onPressed: () {},
//               child: const Text('Shop Now', style: TextStyle(fontWeight: FontWeight.bold))),
//               ],
//             ),
//           ),
//           Image.asset('assets/images/image1.jpg', width: 80, height: 80), // Festival offer image
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCategorySection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.0),
//           child: Text('Shop By Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         ),
//         const SizedBox(height: 12),
//         _buildCategoryRow(),
//       ],
//     );
//   }
//
//   Widget _buildCategoryRow() {
//     final categories = [
//       {'name': 'Apparel', 'icon': Icons.checkroom, 'color': Colors.purple, 'image': 'image2.jpg'},
//       {'name': 'Handicraft', 'icon': Icons.brush, 'color': Colors.blue, 'image': 'image3.jpg'},
//       {'name': 'Etiquette', 'icon': Icons.emoji_objects, 'color': Colors.green, 'image': 'image4.jpg'},
//       {'name': 'Artisans', 'icon': Icons.people, 'color': Colors.red, 'image': 'image5.jpg'},
//     ];
//
//     return SizedBox(
//       height: 100,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: categories.length,
//         itemBuilder: (context, index) {
//           return InkWell(
//             onTap: () {
//               // Handle category tap
//             },
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: Column(
//                 children: [
//                   Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       color: categories[index]['color'] as Color,
//                       borderRadius: BorderRadius.circular(30),
//                       image: DecorationImage(
//                         image: AssetImage('assets/images/${categories[index]['image']}'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(categories[index]['name'] as String),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildFeaturedProducts() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
//           child: Text('Handpicked for You', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         ),
//         _buildProductGrid(),
//       ],
//     );
//   }
//
//   Widget _buildProductGrid() {
//     final products = [
//       {
//         'name': 'Banarasi Silk Saree',
//         'description': 'Handwoven pure silk with zari work',
//         'price': '₹4,299',
//         'rating': '4.8',
//         'image': 'image6.jpg',
//         'category': 'Apparel'
//       },
//       {
//         'name': 'Madhubani Painting',
//         'description': 'Traditional art from Bihar',
//         'price': '₹2,999',
//         'rating': '4.7',
//         'image': 'image7.jpg',
//         'category': 'Handicraft'
//       },
//       {
//         'name': 'Brass Pooja Set',
//         'description': '5-piece ritual utensils',
//         'price': '₹1,499',
//         'rating': '4.9',
//         'image': 'image8.jpg',
//         'category': 'Etiquette'
//       },
//       {
//         'name': 'Blue Pottery',
//         'description': 'Jaipur specialty ceramic vase',
//         'price': '₹1,799',
//         'rating': '4.6',
//         'image': 'image9.jpg',
//         'category': 'Handicraft'
//       },
//       {
//         'name': 'Kashmiri Shawl',
//         'description': 'Pashmina wool with embroidery',
//         'price': '₹3,499',
//         'rating': '4.5',
//         'image': 'image10.jpg',
//         'category': 'Apparel'
//       },
//       {
//         'name': 'Wooden Chess Set',
//         'description': 'Hand-carved rosewood pieces',
//         'price': '₹2,899',
//         'rating': '4.4',
//         'image': 'image11.jpg',
//         'category': 'Handicraft'
//       },
//     ];
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: StaggeredGrid.count(
//         crossAxisCount: 2,
//         mainAxisSpacing: 16,
//         crossAxisSpacing: 16,
//         children: [
//           for (final product in products) _buildProductCard(product),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProductCard(Map<String, dynamic> product) {
//     return InkWell(
//       onTap: () {
//         // Navigate to product detail
//       },
//       child: Card(
//         elevation: 2,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product Image
//             ClipRRect(
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//               child: Image.asset(
//                 'assets/images/${product['image']}',
//                 height: 150,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             // Product Details
//             Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product['name'],
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     product['description'],
//                     style: TextStyle(
//                       color: Colors.grey[600],
//                       fontSize: 12,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         product['price'],
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.deepOrange,
//                           fontSize: 16,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           const Icon(Icons.star, color: Colors.amber, size: 16),
//                           const SizedBox(width: 4),
//                           Text(product['rating']),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../tabs/carttab/cart_provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          _buildFestivalBanner(),
          _buildCategorySection(),
          _buildFeaturedProducts(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.location_pin, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('DELIVER TO', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text('New York, USA',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search sarees, handicrafts...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFestivalBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange[700]!, Colors.orange[900]!],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                const Text('FESTIVAL SALE', style: TextStyle(color: Colors.white, fontSize: 14)),
            const Text('30% OFF on Handicrafts',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.orange[800],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                onPressed: () {},
                child: const Text('Shop Now', style: TextStyle(fontWeight: FontWeight.bold)),
              )
              ],
            ),
          ),
          Image.asset('assets/images/image1.jpg', width: 80, height: 80),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Shop By Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 12),
        _buildCategoryRow(),
      ],
    );
  }

  Widget _buildCategoryRow() {
    const categories = [
      {'name': 'Apparel', 'icon': Icons.checkroom, 'color': Colors.purple, 'image': 'image2.jpg'},
      {'name': 'Handicraft', 'icon': Icons.brush, 'color': Colors.blue, 'image': 'image3.jpg'},
      {'name': 'Etiquette', 'icon': Icons.emoji_objects, 'color': Colors.green, 'image': 'image4.jpg'},
      {'name': 'Artisans', 'icon': Icons.people, 'color': Colors.red, 'image': 'image5.jpg'},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: categories[index]['color'] as Color,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/${categories[index]['image']}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(categories[index]['name'] as String),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedProducts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Text('Handpicked for You', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        _buildProductGrid(context),
      ],
    );
  }

  Widget _buildProductGrid(BuildContext context) {
    final products = [
      {
        'id': '1',
        'name': 'Banarasi Silk Saree',
        'type': 'Varanasi Weaving',
        'price': 4299,
        'rating': '4.8',
        'image': 'image6.jpg',
        'category': 'Apparel'
      },
      {
        'id': '2',
        'name': 'Madhubani Painting',
        'type': 'Traditional Art',
        'price': 2999,
        'rating': '4.7',
        'image': 'image7.jpg',
        'category': 'Handicraft'
      },
      {
        'id': '3',
        'name': 'Brass Pooja Set',
        'type': '5-piece utensils',
        'price': 1499,
        'rating': '4.9',
        'image': 'image8.jpg',
        'category': 'Etiquette'
      },
      {
        'id': '4',
        'name': 'Blue Pottery Vase',
        'type': 'Jaipur specialty',
        'price': 1799,
        'rating': '4.6',
        'image': 'image9.jpg',
        'category': 'Handicraft'
      },
      {
        'id': '5',
        'name': 'Kashmiri Shawl',
        'type': 'Pashmina wool',
        'price': 3499,
        'rating': '4.5',
        'image': 'image10.jpg',
        'category': 'Apparel'
      },
      {
        'id': '6',
        'name': 'Wooden Chess Set',
        'type': 'Hand-carved',
        'price': 2899,
        'rating': '4.4',
        'image': 'image11.jpg',
        'category': 'Handicraft'
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          for (final product in products) _buildProductCard(context, product),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> product) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    'assets/images/${product['image']}',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          product['rating'],
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product['type'],
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹${product['price']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite_border, size: 20),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      CartProvider.of(context)?.addToCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${product['name']} added to cart'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 30),
                      padding: const EdgeInsets.symmetric(vertical: 4),
                    ),
                    child: const Text('Add to Cart'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}