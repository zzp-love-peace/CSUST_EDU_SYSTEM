import 'package:flutter/cupertino.dart';

class CourseTermProvider with ChangeNotifier {

  String _term = '';
  String get term => _term;

  setNowTerm(String pTerm) {
    _term = pTerm;
    notifyListeners();
  }
}