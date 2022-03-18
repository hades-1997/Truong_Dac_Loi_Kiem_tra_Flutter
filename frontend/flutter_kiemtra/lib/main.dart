import 'package:flutter/material.dart';
import 'package:my_second_app/screens/product_edit_screen.dart';
import 'package:my_second_app/screens/user_product_screen.dart';
import './models/cart.dart';
import './screens/cart_screen.dart';
import 'package:provider/provider.dart';

import 'providers/books_provider.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/order_screen.dart';
import './models/order.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => BooksProvider(),),
        ChangeNotifierProvider(create: (BuildContext context) => Cart(),),
        ChangeNotifierProvider(create: (BuildContext context) => Orders(),),
      ],
      child: MaterialApp(
        // title: 'Hi Customer',
        theme: ThemeData(
         // primarySwatch: Colors.white,
        accentColor: Colors.deepOrangeAccent,
        // colorScheme: const ColorScheme.dark(
        //   primary: Color(0xffbb86fc),
        //   primaryVariant: Colors.white,
        //   // secondary: Color(0xffcf6679),
        //   // secondaryVariant: Color(0xff03dac6),
        //   // surface: Color(0xffcf6679),
        //   background: Colors.white,
        //   // error: Color(0xffcf6679),
        //   onPrimary: Colors.black,
        //   // onSecondary: Colors.black,
        //   // onSurface: Colors.white,
        //   // onBackground: Colors.white,
        //   // onError: Colors.black,
        //   brightness: Brightness.light,
        // ),
         // accentColor: Colors.deepOrangeAccent,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
          UserProductScreen.routeName: (ctx) => UserProductScreen(),
          ProductEditScreen.routeName: (ctx) => ProductEditScreen(),
        },
      ),
    );
  }
}

