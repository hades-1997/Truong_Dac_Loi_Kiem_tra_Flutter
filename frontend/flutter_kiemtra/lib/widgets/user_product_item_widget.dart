import 'package:flutter/material.dart';
import 'package:my_second_app/providers/books_provider.dart';
import 'package:my_second_app/screens/product_edit_screen.dart';
import 'package:provider/provider.dart';

class UserProductItemWidget extends StatelessWidget {

  final int id;
  final String title;
  final String imageUrl;

  UserProductItemWidget(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl),) ,
      trailing: Container(
        width: 100,
        child: Row(children: [
          IconButton(icon: Icon(Icons.edit), color: Theme.of(context).primaryColor, 
            onPressed: () => Navigator.of(context).pushNamed(ProductEditScreen.routeName, arguments: id),
          ),
          IconButton(icon: Icon(Icons.delete), color: Theme.of(context).errorColor, 
            onPressed: () async {
              try {
                String message = await Provider.of<BooksProvider>(context, listen: false).deleteProduct(id);
                if (message != '') {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),),);
                }
              } catch (error) {
                throw Exception('Deleting failed');
              }
            }
          ),
      ],),) ,
    );
  }

}
