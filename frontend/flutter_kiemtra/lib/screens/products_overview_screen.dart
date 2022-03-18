import 'package:flutter/material.dart';
import 'package:my_second_app/models/book.dart';
import 'package:my_second_app/providers/books_provider.dart';
import 'package:my_second_app/screens/product_detail_screen.dart';
import 'package:my_second_app/widgets/product_item.dart';
import 'package:provider/provider.dart';

import '../widgets/navbar_drawer.dart';
import '../screens/cart_screen.dart';
import '../models/cart.dart';
import '../widgets/badge.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductsOverviewScreen();
}

class _ProductsOverviewScreen extends State<ProductsOverviewScreen> {
  bool _showFavoritesOnly = false;
  bool _isLoading = false;
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<BooksProvider>(context)
          .fetchAndSetProducts()
          .then((value) => setState(() {
                _isLoading = false;
              }));
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<BooksProvider>(context);
    final products = productsData.items;
    // Book product = Provider.of<Book>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hi Customer',
          style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
        actions: <Widget>[
          // PopupMenuButton(
          //   icon: Icon(Icons.more_vert),
          //   itemBuilder: (ctx) => [
          //     PopupMenuItem(child: Text('Only favorites'), value: FilterOptions.Favorites),
          //     PopupMenuItem(child: Text('Show All'), value: FilterOptions.All,),
          //   ],
          //   onSelected: (FilterOptions selectedValue) {
          //     setState(() {
          //       if (selectedValue == FilterOptions.Favorites) {
          //         _showFavoritesOnly = true;
          //       } else {
          //         _showFavoritesOnly = false;
          //       }
          //     });
          //   },
          // ),
          Consumer<Cart>(
            builder: (ctx, cartData, childWidget) => Badge(
              child: childWidget!,
              value: cartData.itemCount.toString(),
              color: Colors.deepOrangeAccent,
            ),
            child: IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(CartScreen.routeName),
                icon: Icon(Icons.shopping_cart)),
          ),
        ],
      ),
      drawer: NavbarDrawer(),
      body: Container(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            // Padding(
            //   //padding: EdgeInsets.only(left: 25, top: 25),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[Text('')],
            //   ),
            // ),
            Container(
              height: 39,
              margin: EdgeInsets.only(left: 20, top: 18, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[100],
              ),
              child: Stack(
                children: <Widget>[
                  TextField(
                    maxLengthEnforced: true,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 19, right: 50, bottom: 8),
                        border: InputBorder.none,
                        hintText: 'Search Book...!!!',
                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey)),
                  ),
                  Positioned(
                    right: 5,
                    top: 8,
                    width: 25,
                    child: Image.asset('assets/images/icons8-search-30.png'),
                  )
                ],
              ),
            ),
            Container(
              height: 30,
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.only(left: 20),
              child: DefaultTabController(
                length: 2,
                child: TabBar(
                  labelPadding: EdgeInsets.only(right: 15),
                  indicatorPadding: EdgeInsets.all(0),
                  isScrollable: true,
                  labelColor: Colors.black,
                  // indicator: R,
                  tabs: [
                    Tab(
                      child: Container(
                        margin: EdgeInsets.only(top: 2),
                        child: Text('Hots'),
                      ),
                    ),
                    Tab(
                      child: Container(
                        margin: EdgeInsets.only(top: 2),
                        child: Text('Book'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 21),
              height: 200.0,
              child: ListView.builder(
                  padding: EdgeInsets.only(left: 25, right: 8),
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 210,
                      width: 153,
                      margin: EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                          image: DecorationImage(
                              image: AssetImage('assets/images/learning.jpg'))),
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text('Discover Latest Book'),
            ),
            Container(
              margin: EdgeInsets.only(top: 21),
              height: 200.0,
              child: ListView.builder(
                  padding: EdgeInsets.only(left: 25, right: 8),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(
                          ProductDetailScreen.routeName,
                          arguments: products[index].id),
                      child: Container(
                    
                    height: 81,
                    width: MediaQuery.of(context).size.width - 50,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 81,
                          width: 62,
                          margin: EdgeInsets.only(bottom: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                            image: DecorationImage(image: NetworkImage(products[index].imageUrl))
                            //Image.network(products[index].imageUrl, fit: BoxFit.cover,),
                           // DecorationImage(image: AssetImage('assets/images/learning.jpg'))
                          ),
                        ),
                        SizedBox(width: 21,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          
                          children: <Widget>[
                            SizedBox(width: 230,
                              child: Text(
                            products[index].name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: TextStyle(fontWeight: FontWeight.bold,),
                              ),),

                            
                            SizedBox(height: 5,),
                            Text('Admin',),
                            SizedBox(height: 5,),
                             Text(('\$' +(products[index].unitPrice).toString()), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red[700])),

                          ],
                        )
                      ],
                    ),
                    )
                    );
                  }),
            ),
            //Image.asset('assets/images/icons-search.svg')
          ],
        ),
      ),
      // _isLoading ? Center(child: CircularProgressIndicator(),) : ProductsGrid(_showFavoritesOnly),
    );
  }
}
