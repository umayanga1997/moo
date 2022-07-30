import 'package:flutter/material.dart';

class LanguageController extends ChangeNotifier {
  String lanSearchKey = "al";

  void changeSearchKey(String key) {
    lanSearchKey = key;
    notifyListeners();
  }
}
