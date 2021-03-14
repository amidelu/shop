import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/screens/product_details_screen.dart';

// Single product widget which will show in products Grid View
class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Creating product object by provider and listen false not to rebuild entire widget for favorite state
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          // Setting consumer here to only listen favorite state, declaring false to top provider, not to listen
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).accentColor,
              onPressed: () {
                product.toggleFavoriteStatus();
              },
            ),
          ),
          title: Text(product.title),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {
              cart.addItem(
                  product.id, product.price, product.title, product.imageUrl);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Item added on cart!'),
                  duration: Duration(seconds: 4),
                  action: SnackBarAction(label: 'UNDO', onPressed: () {
                    cart.removeSingleItem(product.id);
                  },),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
