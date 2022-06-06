import 'package:flutter/material.dart';
import 'package:project_final/models/product.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  ProductsResponse product;

  ProductFormProvider(this.product);

  updateAvailability(bool value){
    print(value);
    this.product.available = value;
    notifyListeners();
  }

  updateSecondHand(bool value){
    print(value);
    this.product.secondHand = value;
    notifyListeners();
  }



  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
