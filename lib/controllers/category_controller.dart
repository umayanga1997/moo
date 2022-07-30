import 'package:flutter/material.dart';

class Categorycontroller extends ChangeNotifier {
  String catSearchKey = "al";

  void changeSearchKey(String key) {
    catSearchKey = key;
    notifyListeners();
  }
}
