import 'package:flutter/material.dart';
import 'package:plateron/models/product_item_model.dart';

import '../models/cart_item_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  double get totalAmount => _cartItems.fold(
      0, (total, current) => total + current.product.price * current.quantity);

  void addToCart(ProductItem item) {
    if (_cartItems.any((element) => element.product.id == item.id)) {
      _cartItems
          .firstWhere((element) => element.product.id == item.id)
          .quantity++;
    } else {
      _cartItems.add(CartItem(product: item));
    }
    notifyListeners();
  }

  bool isProductInCart(ProductItem item) {
    return _cartItems.any((element) => element.product.id == item.id) &&
        getQuantity(item) > 0;
  }

  int getQuantity(ProductItem product) {
    return _cartItems
        .where((element) => element.product.id == product.id)
        .fold(0, (total, current) => total + current.quantity);
  }

  void decreaseQuantity(ProductItem product) {
    if (isProductInCart(product) && getQuantity(product) > 0) {
      cartItems
          .firstWhere((element) => element.product.id == product.id)
          .quantity--;
      if (getQuantity(product) == 0) {
        removeItem(product);
      }
      notifyListeners();
    }
  }

  void removeItem(ProductItem product) {
    _cartItems.removeWhere((element) => element.product.id == product.id);
    notifyListeners();
  }

  int getTotalQuantity() {
    return _cartItems.fold(0, (total, current) => total + current.quantity);
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
