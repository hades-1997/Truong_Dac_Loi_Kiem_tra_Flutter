import 'package:flutter/material.dart';
import 'package:my_second_app/models/cart.dart';
import 'package:provider/provider.dart';

import '../providers/books_provider.dart';
import '../models/book.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Colors.white,
      minimumSize: Size(88, 44),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      backgroundColor: Colors.deepOrange[200],
    );
  @override
  Widget build(BuildContext context) {
    int productId = ModalRoute.of(context)!.settings.arguments as int;
    Cart cart = Provider.of<Cart>(context, listen: false);

    Book loadedProduct =
        Provider.of<BooksProvider>(context, listen: false).findById(productId);

    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 12, right: 12, bottom: 20),
        height: 49,
        color: Colors.transparent,
        child: TextButton( 
          onPressed: () {
                cart.addItem(loadedProduct.id, loadedProduct.unitPrice, loadedProduct.name, loadedProduct.imageUrl);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added item to cart!'),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(label: 'UNDO', onPressed: () => cart.removeSingleItem(loadedProduct.id),),
                  ),
                );
              },
          child: Text('Buy Books Nows', style: TextStyle(color: Colors.white),),
          style: flatButtonStyle,
          
         ),
      ),
        //appBar: AppBar(title: Text(loadedProduct.name),),
        body: SafeArea(
      child: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.deepOrangeAccent[200],
              expandedHeight: MediaQuery.of(context).size.height * 0.5,
              flexibleSpace: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 35,
                      top: 35,
                      child: Container(
                        height: 32,
                        width: 32,

                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(5),
                        //    image: DecorationImage(
                        //       image: AssetImage('assets/images/back-arrow.png')),
                        // ),
                      ),
                    ),
                    Align(
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(loadedProduct.imageUrl))),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverList(delegate: SliverChildListDelegate(
              [
                Padding(padding: EdgeInsets.only(top: 7, left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    Text(loadedProduct.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),),
                    SizedBox(height: 5,),
                    Text(loadedProduct.author + '- 18/03/2022', style: TextStyle(fontSize: 13,),),
                    SizedBox(height: 5,),
                    Text('\$'+(loadedProduct.unitPrice).toString(), style: TextStyle(fontSize: 23, color: Colors.red[200],fontWeight: FontWeight.bold),),
                  ],)  
                ),
                Container(
                  height: 28,
                  margin: EdgeInsets.only(top: 23, bottom: 36),
                  padding: EdgeInsets.only(left: 12),
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
                        child: Text('Description'),
                      ),
                    ),
                    Tab(
                      child: Container(
                        margin: EdgeInsets.only(top: 2),
                        child: Text('Rates'),
                      ),
                      
                    ),
                  ],
                ),
              ),
                ),
                Padding(padding: EdgeInsets.only(left: 12,right: 12, bottom: 25,),
                child: Text(loadedProduct.description, style: TextStyle(fontSize: 18),),)
              ]
            ))
          ],
        ),
      ),
    ));
  }
}
