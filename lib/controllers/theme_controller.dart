import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  bool isDark = false;

  ThemeController({required this.isDark}) : super();

  void changeTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}
