import 'package:flutter/material.dart';
import '../models/book.dart';
import 'package:http/http.dart' as httpClient;
import 'dart:convert';

class BooksProvider with ChangeNotifier {
  List<Book> _items = [];
  // getter
  List<Book> get items {
    return [..._items];
  }

  Book findById(int id) {
    return _items.firstWhere((element) => element.id == id);
  }

  List<Book> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  // setter
  Future<void> addProduct(Book book) async {
    Uri url = Uri.parse('http://10.0.2.2:8080/api/book');

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final response = await httpClient.post(url,
          headers: headers,
          body: json.encode({
            'name': book.name,
            'author': book.author,
            'description': book.description,
            'unitPrice': book.unitPrice,
            'imageUrl': book.imageUrl,
            'isFavorite': book.isFavorite,
            'unitsInStock': 100,
            'active': true,
            'category': {"id": 4, "categoryName": "PROGRAMMING"}
          }));

      // print(json.decode(response.body));
      final res = json.decode(response.body);
      Book newProduct = Book(
          name: res['name'],
          author:res['author'],
          description: res['description'],
          unitPrice: res['unitPrice'],
          imageUrl: res['imageUrl'],
          id: res['id']);
      _items.add(newProduct);
      // print(json.encode(newProduct));
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(int id, Book newBook) async {
    int prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      Uri url = Uri.parse('http://10.0.2.2:8080/api/books/$id');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

      try {
        await httpClient.put(url,
            headers: headers,
            body: json.encode({
              'name': newBook.name,
              'author': newBook.author,
              'description': newBook.description,
              'unitPrice': newBook.unitPrice,
              'imageUrl': newBook.imageUrl,
              'favorite': newBook.isFavorite,
              'unitsInStock': 100,
              'active': true,
              'category': {"id": 4, "categoryName": "PROGRAMMING"}
            }));

        _items[prodIndex] = newBook;
        notifyListeners();
      } catch (error) {
        throw error;
      }
    } else {
      print("problem with updating product");
    }
  }

  Future<String> deleteProduct(int id) async {
    Uri url = Uri.parse('http://10.0.2.2:8080/api/books/$id');

    String message = '';
    try {
      final response = await httpClient.delete(url);
      print(response);
      if (response.statusCode == 204) {
        _items.removeWhere((element) => element.id == id);
        notifyListeners();
      } else {
        // print(json.decode(response.body));
        message = json.decode(response.body)['message'];
      }
      return message;
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetProducts() async {
    Uri url = Uri.parse(
        'http://10.0.2.2:8080/api/books/search/findByCategoryId?id=4');
    try {
      final response = await httpClient.get(url);
      print(json.decode(response.body)['_embedded']['books']);
      final extractedData =
          json.decode(response.body)['_embedded']['books'] as List<dynamic>;
      final List<Book> loadProducts = [];
      extractedData.forEach((element) {
        // print(element);
        loadProducts.add(Book(
          id: element['id'],
          name: element['name'],
          author: element['author'],
          description: element['description'],
          unitPrice: element['unitPrice'],
          imageUrl: element['imageUrl'],
          isFavorite: element['favorite'],
        ));
      });
      _items = loadProducts;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
