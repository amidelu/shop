import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/screens/drawer_screen.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order-screen';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (ctx, i) => OrderItems(orderData.orders[i]),
      ),
      drawer: DrawerScreen(),
    );
  }
}
