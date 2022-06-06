import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_final/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier{
  final String _baseUrl = 'flutter-varios-3ffaa-default-rtdb.firebaseio.com';
  final List<ProductsResponse> products = [];
  late ProductsResponse? selectedProduct;
  bool isLoading = true;

  //Hacer fetch de productos
  ProductsService(){
    loadProducts();
  }

  Future<List<ProductsResponse>> loadProducts() async{
    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);
    productsMap.forEach((key, value) { 
      final tempProduct = ProductsResponse.fromMap(value);
      tempProduct.id = key;
      this.products.add(tempProduct);
    });

    this.isLoading = false;
    notifyListeners();

    return this.products;
  }
}