import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-3ffaa-default-rtdb.firebaseio.com';

  final List<Product> products = [];

  //TODO: Hacer Fetch the productos
}
