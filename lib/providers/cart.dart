import 'package:flutter/material.dart';

class CartItem {
  final String cartId;
  final String title;
  final double price;
  final int quantity;
  final String imageUrl;

  CartItem(
      {@required this.cartId,
      @required this.title,
      @required this.price,
      @required this.quantity,
      this.imageUrl});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalPrice {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title, String imageUrl) {
    if (_items.containsKey(productId)) {
      // Change quantity
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          cartId: existingCartItem.cartId,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
          imageUrl: existingCartItem.imageUrl,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
            cartId: DateTime.now().toString(),
            title: title,
            price: price,
            quantity: 1,
            imageUrl: imageUrl),
      );
    }
    notifyListeners();
  }

  // Remove item from carts
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              cartId: existingCartItem.cartId,
              title: existingCartItem.title,
              price: existingCartItem.price,
              imageUrl: existingCartItem.imageUrl,
              quantity: existingCartItem.quantity - 1));
    } else {
      items.remove(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
