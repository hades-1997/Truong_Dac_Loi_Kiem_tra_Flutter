import 'package:flutter/material.dart';
import 'package:http/http.dart' as httpClient;
import 'dart:convert';

class Book with ChangeNotifier {
  int id;
  String name;
  String author;
  String description;
  double unitPrice;
  String imageUrl;
  bool isFavorite;

  Book(
      {required this.id,
      required this.name,
      required this.author,
      required this.description,
      required this.unitPrice,
      required this.imageUrl,
      this.isFavorite = false,});

  Map toJson() => {
        'id': id,
        'name': name,
        'author': author,
        'description': description,
        'unitPrice': unitPrice,
        'imageUrl': imageUrl,
        'isFavorite': isFavorite,
      };

  Future<void> toggleFavoriteStatus() {
    Uri url = Uri.parse('http://10.0.2.2:8080/api/books/$id');
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    return httpClient
        .put(url,
            headers: headers,
            body: json.encode({
              'name': this.name,
              'author': author,
              'description': this.description,
              'unitPrice': this.unitPrice,
              'imageUrl': this.imageUrl,
              'favorite': !this.isFavorite,
              'unitsInStock': 100,
              'active': true,
              'category': {"id": 4, "categoryName": "PROGRAMMING"}
            }))
        .then((response) {
      if (response.statusCode == 200) {
        isFavorite = !isFavorite;
        notifyListeners();
      } else {
        try {
          print(json.decode(response.body));
        } on FormatException catch (e) {
          print('Message return is not a valid JSON format');
        }
      }
    }).catchError((error) => throw error);
  }
}
