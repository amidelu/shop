import 'package:flutter/material.dart';
import 'package:shop/providers/cart.dart';

class OrderItems {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItems(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItems> _orders = [];

  List<OrderItems> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      // index 0 means last added cart item will be added first
      0,
      OrderItems(
          id: DateTime.now().toString(),
          amount: total,
          products: cartProducts,
          dateTime: DateTime.now()),
    );
    notifyListeners();
  }
}
