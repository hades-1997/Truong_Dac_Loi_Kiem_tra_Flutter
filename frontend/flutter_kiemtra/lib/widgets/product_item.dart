import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../screens/product_detail_screen.dart';
import '../models/cart.dart';

class ProductItem extends StatelessWidget {

  // final String imageUrl;
  // final String name;
  // final int id;
  //
  // ProductItem({required this.imageUrl, required this.name, required this.id});

  @override
  Widget build(BuildContext context) {

    Book product = Provider.of<Book>(context, listen: false);
    Cart cart = Provider.of<Cart>(context, listen: false);

    return GestureDetector(
      // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ProductDetailScreen(name))),
      onTap: () => Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments: product.id),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: Image.network(product.imageUrl, fit: BoxFit.cover,),
          footer: GridTileBar(
            title: Text(product.name, textAlign: TextAlign.center,),
            backgroundColor: Colors.black54,
            leading: Consumer<Book>(builder: (ctx, product, child) =>
                IconButton(icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border), 
                color: Theme.of(context).accentColor, onPressed: () => product.toggleFavoriteStatus(),),),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Theme.of(context).accentColor,
              onPressed: () {
                cart.addItem(product.id, product.unitPrice, product.name, product.imageUrl);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added item to cart!'),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(label: 'UNDO', onPressed: () => cart.removeSingleItem(product.id),),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

}
