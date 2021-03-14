import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/add_edit_product_screen.dart';
import '../providers/products_provider.dart';
import '../widgets/user_product_items.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-products-screen';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Product'),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddEditProductScreen.routeName);
              })
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
              itemCount: productData.items.length,
              itemBuilder: (_, i) => UserProductItems(
                    productData.items[i].id,
                    productData.items[i].title,
                    productData.items[i].imageUrl,
                  )),
        ),
      ),
    );
  }
}
