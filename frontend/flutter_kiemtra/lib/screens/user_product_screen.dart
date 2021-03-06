import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/navbar_drawer.dart';
import '../widgets/user_product_item_widget.dart';
import '../providers/books_provider.dart';
import '../screens/product_edit_screen.dart';

class UserProductScreen extends StatelessWidget {

  static const routeName = '/user-product';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<BooksProvider>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<BooksProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your books'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: () => Navigator.of(context).pushNamed(ProductEditScreen.routeName),)
        ],
      ),
      drawer: NavbarDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(itemCount: productsData.items.length, itemBuilder: (ctx, idx) => Column(children: [
            UserProductItemWidget(productsData.items[idx].id, productsData.items[idx].name, productsData.items[idx].imageUrl),
            Divider(),
          ],),),
        ),
      ),
    );
  }

}
