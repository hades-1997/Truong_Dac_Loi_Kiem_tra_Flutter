import 'package:flutter/material.dart';
import '../screens/order_screen.dart';
import '../screens/user_product_screen.dart';

class NavbarDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(child: Column(children: <Widget>[
      AppBar(title: Text('Navigation'),),
      Divider(),
      ListTile(title: Text('Shop'), leading: Icon(Icons.shop), onTap: () => Navigator.of(context).pushReplacementNamed('/'),),
      Divider(),
      ListTile(title: Text('Orders'), leading: Icon(Icons.payment), onTap: () => Navigator.of(context).pushReplacementNamed(OrderScreen.routeName),),
      Divider(),
      ListTile(title: Text('Manage Product'), leading: Icon(Icons.edit), onTap: () => Navigator.of(context).pushReplacementNamed(UserProductScreen.routeName),),
    ],),);
  }

}
