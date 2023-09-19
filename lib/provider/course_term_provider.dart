import 'package:flutter/cupertino.dart';

/// todo:重构课表页面后移除
class CourseTermProvider with ChangeNotifier {

  String _term = '';
  String get term => _term;

  setNowTerm(String pTerm) {
    _term = pTerm;
    notifyListeners();
  }
}