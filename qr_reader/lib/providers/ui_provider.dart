import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _selectedMenuOpt = 0;

  // Getter
  int get selectedMenuOpt {
    return this._selectedMenuOpt;
  }

  // Setter
  set selectedMenuOpt(int index) {
    this._selectedMenuOpt = index;
    notifyListeners();
  }
}
