import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-details';

  @override
  Widget build(BuildContext context) {
    // Getting product id from product item screen via navigator push as argument
    final productId = ModalRoute.of(context).settings.arguments as String;
    // Matching the product id to identify selected product from products provider object
    final loadedProduct = Provider.of<ProductsProvider>(context, listen: false)
        .findbyId(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text('\$${loadedProduct.price}'),
            SizedBox(height: 15),
            Text(
              loadedProduct.description,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
