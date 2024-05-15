import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'mlodel/MainResponse.dart';
import 'mlodel/Products.dart';

import 'package:http/http.dart' as http;
class ProductProvider with ChangeNotifier {
  List<Product>? _products = [];

  List<Product>? get products => _products;

  Future<void> fetchProducts(int page) async {
    try {
      final response = await http.post(
        Uri.parse('https://my-store.in/v2/products/api/getProductsList'),
        headers: {'appid': '2IPbyrCUM7s5JZhnB9fxFAD6'},
        body: {'page': page.toString()},
      );

      if (response.statusCode == 200) {
        print('data:${response.body}');
        final jsonData = json.decode(response.body);
        var data=MainResponse.fromJson(jsonData);
        var fetchedProducts=data.list;
        _products = fetchedProducts;
        notifyListeners();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      throw Exception('Failed to load products: $error');
    }
  }
}