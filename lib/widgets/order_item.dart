import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart' as ord;

class OrderItems extends StatefulWidget {
  final ord.OrderItems order;

  OrderItems(this.order);

  @override
  _OrderItemsState createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text('\$${widget.order.amount}'),
          subtitle: Text(
            DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
          ),
          trailing: IconButton(
            icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            onPressed: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
          ),
        ),
        if (_expanded)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            height: min(widget.order.products.length * 20 + 15.0, 100),
            child: ListView(
                children: widget.order.products
                    .map((prod) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(prod.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            Text('${prod.quantity} x \$${prod.price}'),
                          ],
                        ))
                    .toList()),
          ),
      ]),
    );
  }
}
