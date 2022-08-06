import 'package:flutter/material.dart';

class SearchController extends ChangeNotifier {
  String? searchKey;

  void changeSearchValue(String value) {
    searchKey = value;
    notifyListeners();
  }
}
