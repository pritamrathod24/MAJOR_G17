// import 'package:flutter/material.dart';
// import '../home/cart_tab.dart';
// import '../home/categories_tab.dart';
// import '../home/home_tab.dart';
// import '../home/profile/profile_tab.dart';
//
//
// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({super.key});
//
//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }
//
// class _BottomNavBarState extends State<BottomNavBar> {
//   int _currentIndex = 0;
//   final PageController _pageController = PageController();
//
//   final List<Widget> _tabs = const [
//     Homepage(),
//     CategoriesTab(),
//     CartTab(),
//     ProfileTab(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         physics: const NeverScrollableScrollPhysics(),
//         children: _tabs,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() => _currentIndex = index);
//           _pageController.jumpToPage(index);
//         },
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Theme.of(context).primaryColor,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
//           BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//         ],
//       ),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import 'package:indicraft_major/repository/screens/home/homepage/home_tab.dart';
// import 'package:indicraft_major/repository/screens/home/profile/profile_tab.dart';
//
// import '../tabs/carttab/cartpagescreen.dart';
// import '../tabs/categorytab/categorypagescreen.dart';
//
// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({super.key});
//
//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }
//
// class _BottomNavBarState extends State<BottomNavBar> {
//   int _currentIndex = 0;
//   final PageController _pageController = PageController();
//   final Color _activeColor = const Color(0xFFE67F17); // Your orange color
//
//   // Organized tabs with lazy loading (screens initialize only when needed)
//   final List<Widget> _tabs = [
//     const Homepage(),
//     const CategoriesScreen(),
//     const CartScreen(),
//     const ProfileTab(),
//   ];
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         physics: const NeverScrollableScrollPhysics(),
//         onPageChanged: (index) => setState(() => _currentIndex = index),
//         children: _tabs,
//       ),
//       bottomNavigationBar: _buildCustomNavBar(),
//     );
//   }
//
//   BottomNavigationBar _buildCustomNavBar() {
//     return BottomNavigationBar(
//       currentIndex: _currentIndex,
//       onTap: (index) {
//         setState(() => _currentIndex = index);
//         _pageController.animateToPage(
//           index,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       },
//       type: BottomNavigationBarType.fixed,
//       backgroundColor: Colors.white,
//       selectedItemColor: _activeColor,
//       unselectedItemColor: Colors.grey.shade600,
//       selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
//       elevation: 8,
//       items: [
//         _buildNavItem(Icons.home_outlined, Icons.home, 'Home'),
//         _buildNavItem(Icons.category_outlined, Icons.category, 'Categories'),
//         _buildNavItem(Icons.shopping_cart_outlined, Icons.shopping_cart, 'Cart'),
//         _buildNavItem(Icons.person_outlined, Icons.person, 'Profile'),
//       ],
//     );
//   }
//
//   BottomNavigationBarItem _buildNavItem(
//       IconData icon, IconData activeIcon, String label) {
//     return BottomNavigationBarItem(
//       icon: Icon(icon),
//       activeIcon: Icon(activeIcon),
//       label: label,
//     );
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:indicraft_major/repository/screens/home/homepage/home_tab.dart';
import 'package:indicraft_major/repository/screens/home/profile/profile_tab.dart';

import '../tabs/carttab/cartpagescreen.dart';
import '../tabs/categorytab/categorypagescreen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final Color _activeColor = const Color(0xFFE67F17); // Your orange color

  // Organized tabs with lazy loading (screens initialize only when needed)
  final List<Widget> _tabs = [
    const Homepage(),
    const CategoriesScreen(),
    const CartScreen(),
    const ProfileTab(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) => setState(() => _currentIndex = index),
        children: _tabs,
      ),
      bottomNavigationBar: _buildCustomNavBar(),
    );
  }

  BottomNavigationBar _buildCustomNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() => _currentIndex = index);
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: _activeColor,
      unselectedItemColor: Colors.grey.shade600,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      elevation: 8,
      items: [
        _buildNavItem(Icons.home_outlined, Icons.home, 'Home'),
        _buildNavItem(Icons.category_outlined, Icons.category, 'Categories'),
        _buildNavItem(Icons.shopping_cart_outlined, Icons.shopping_cart, 'Cart'),
        _buildNavItem(Icons.person_outlined, Icons.person, 'Profile'),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(
      IconData icon, IconData activeIcon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: Icon(activeIcon),
      label: label,
    );
  }
}
