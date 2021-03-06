import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/books_provider.dart';
import '../widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {

  final bool _showFavoriteOnly;

  ProductsGrid(this._showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<BooksProvider>(context);
    final products = _showFavoriteOnly ? productsData.favoriteItems : productsData.items;
//_showFavoriteOnly ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      

      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, 
        childAspectRatio: 3/2, 
        crossAxisSpacing: 10,
         mainAxisSpacing: 10
        ),
      itemBuilder: (ctx, idx) =>
        ChangeNotifierProvider.value(value: products[idx], child: ProductItem(),),
        // ChangeNotifierProvider(create: (c) => products[idx], child: ProductItem(),),
        // ProductItem(
        //   imageUrl: products[idx].imageUrl,
        //   name: products[idx].name,
        //   id: products[idx].id
        // ),
      itemCount: products.length,
    );
  }

}
