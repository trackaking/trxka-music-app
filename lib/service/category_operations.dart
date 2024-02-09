import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../shared/constants.dart';

class CategoryOperations {
  CategoryOperations._() {}

  static Future<List<Category>> getCategories() async {
    final storage = FlutterSecureStorage();
    List<Category> result = [];

    String? token = await storage.read(key: "token") as String;

    var headers = {
      'access-token': token,
      "Accept": "application/json",
      'Content-Type': 'application/json; charset=UTF-8',
    };
    try {
      final response = await http.get(
        Uri.parse("${Constants.serverUrl}category/all"),
        headers: headers,
      );

      var jsonData = jsonDecode(response.body);
      for (var song in jsonData) {
        Category newCategory = Category(
          categoryId: song["categoryid"],
          categoryName: song["categoryname"],
          categoryImg: song["categoryimg"],
          catgoryGenre: song["categorygenre"],
        );
        result.add(newCategory);
      }
    } catch (error) {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      debugPrint(error.toString());
      throw Exception('Failed to load categories');
    }

    return result;
  }

/*
  static List<Category> getCategories() {
    return <Category>[
      Category(
        'Kendrick',
        'https://tse3.mm.bing.net/th?id=OIF.roPSye1bVeJOy5JlG%2byJ3A&pid=Api&P=0&h=180',
      ),
      Category(
        'Drake',
        'https://tse2.mm.bing.net/th?id=OIP.jAXEVWr0KYQ6vOkUNCbywAAAAA&pid=Api&P=0&h=180',
      ),
      Category(
        'Chief Keef',
        'https://tse1.mm.bing.net/th?id=OIP.doDsxhYYOjG7_HWxiTa4eQHaFj&pid=Api&P=0&h=180',
      ),
      Category(
        'Gunna',
        'https://tse3.mm.bing.net/th?id=OIP.2Pt2ecoPJFqnOvp9LdCtTAHaHA&pid=Api&P=0&h=180',
      ),
      Category(
        'Playboi Carti',
        'https://townsquare.media/site/812/files/2017/04/PLAYBOI-CARTI1.jpg?w=980&q=75',
      ),
      Category(
        'Future',
        'https://tse1.mm.bing.net/th?id=OIP.l9vE-BnkstbhMzyVU9pQYAHaHa&pid=Api&P=0&h=180',
      )
    ];
  }
  */
}
