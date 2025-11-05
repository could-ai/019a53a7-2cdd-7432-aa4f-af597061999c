import 'package:flutter/material.dart';
import '../models/product.dart';

class CartItem {
  final String id;
  final String productId;
  final String name;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
  });
}

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount =>
      _items.values.fold(0, (sum, item) => sum + item.quantity);

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existing) => CartItem(
          id: existing.id,
          productId: existing.productId,
          name: existing.name,
          quantity: existing.quantity + 1,
          price: existing.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: DateTime.now().toString(),
          productId: product.id,
          name: product.name,
          quantity: 1,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  // New method to adjust quantity by delta (+1 or -1)
  void addItemQuantity(String productId, int delta) {
    if (!_items.containsKey(productId)) return;
    final existing = _items[productId]!;
    final newQuantity = existing.quantity + delta;
    if (newQuantity <= 0) {
      _items.remove(productId);
    } else {
      _items.update(
        productId,
        (_) => CartItem(
          id: existing.id,
          productId: existing.productId,
          name: existing.name,
          quantity: newQuantity,
          price: existing.price,
        ),
      );
    }
    notifyListeners();
  }
}
