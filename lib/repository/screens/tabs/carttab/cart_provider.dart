import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];
  final Map<String, int> _quantities = {};
  final int _deliveryCharge = 50;

  List<Map<String, dynamic>> get items => _items;
  int get itemCount => _items.length;
  int get deliveryCharge => _deliveryCharge;

  int getQuantity(String productId) {
    return _quantities[productId] ?? 0;
  }

  void addToCart(Map<String, dynamic> product) {
    final productId = product['id'] as String;
    if (_quantities.containsKey(productId)) {
      _quantities[productId] = (_quantities[productId] ?? 0) + 1;
    } else {
      _items.add(product);
      _quantities[productId] = 1;
    }
    notifyListeners();
  }

  void removeFromCart(Map<String, dynamic> product) {
    final productId = product['id'] as String;
    _items.removeWhere((item) => item['id'] == productId);
    _quantities.remove(productId);
    notifyListeners();
  }

  void increaseQuantity(Map<String, dynamic> product) {
    final productId = product['id'] as String;
    if (_quantities.containsKey(productId)) {
      _quantities[productId] = (_quantities[productId] ?? 0) + 1;
      notifyListeners();
    }
  }

  void decreaseQuantity(Map<String, dynamic> product) {
    final productId = product['id'] as String;
    if (_quantities.containsKey(productId)) {
      if (_quantities[productId] == 1) {
        removeFromCart(product);
      } else {
        _quantities[productId] = (_quantities[productId] ?? 0) - 1;
        notifyListeners();
      }
    }
  }

  int get subtotal {
    int total = 0;
    for (var item in _items) {
      total += (item['price'] as int) * getQuantity(item['id'] as String);
    }
    return total;
  }

  void clearCart() {
    _items.clear();
    _quantities.clear();
    notifyListeners();
  }

  static CartProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_InheritedCartProvider>()?.cart;
  }
}

class _InheritedCartProvider extends InheritedWidget {
  final CartProvider cart;

  const _InheritedCartProvider({
    required this.cart,
    required super.child,
  });

  @override
  bool updateShouldNotify(_InheritedCartProvider oldWidget) => cart != oldWidget.cart;
}