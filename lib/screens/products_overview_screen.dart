import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/products_provider.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/screens/drawer_screen.dart';
import 'package:shop/widgets/badge.dart';

import '../providers/product.dart';
import '../widgets/product_item.dart';

enum FavoritesOption { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = '/products-overview';

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _favoriteSelected = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
          print('Then called');
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products Overview'),
        actions: [
          PopupMenuButton(
            onSelected: (FavoritesOption selectedValue) {
              setState(() {
                if (selectedValue == FavoritesOption.Favorites) {
                  _favoriteSelected = true;
                } else {
                  _favoriteSelected = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Favorites only'),
                value: FavoritesOption.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FavoritesOption.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      // Removing products grid to avoid unnecessary appbar build every time
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ProductsGrid(_favoriteSelected),
      drawer: DrawerScreen(),
    );
  }
}

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    // Defining products provider object
    final productsData = Provider.of<ProductsProvider>(context);
    // getting products list from from products provider object by getter
    final products = showFavs ? productsData.favoriteItems : productsData.items;

    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        // Grid column config
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
              value: products[index],
              child: ProductItem(),
            ));
  }
}
