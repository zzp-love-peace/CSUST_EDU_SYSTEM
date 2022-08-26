import 'package:flutter/cupertino.dart';

class ThemeColorProvider with ChangeNotifier {
  String _themeColor = 'blue';

  String get themeColor => _themeColor;

  setTheme(String themeColor) {
    _themeColor = themeColor;
    notifyListeners();
  }
}
