import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart' show Cart;
import 'package:shop/providers/orders.dart';
import 'package:shop/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalPrice}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6
                              .color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(cart.items.values.toList(), cart.totalPrice);
                      cart.clearCart();
                    },
                    child: Text('ORDER NOW'),
                    splashColor: Theme.of(context).accentColor,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (ctx, index) => CartItem(
                // Adding value.toList() because items is a map and we are using only value not the key
                  cart.items.values.toList()[index].cartId,
                  cart.items.keys.toList()[index],
                  cart.items.values.toList()[index].title,
                  cart.items.values.toList()[index].price,
                  cart.items.values.toList()[index].quantity,
                  cart.items.values.toList()[index].imageUrl
              ),
            ),
          ),
        ],
      ),
    );
  }
}
