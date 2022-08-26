import 'package:flutter/cupertino.dart';

class UnreadMsgProvider with ChangeNotifier {

  bool _hasNewMsg = false;
  bool get hasNewMsg => _hasNewMsg;

  setHasNewMsg(bool flag) {
    _hasNewMsg = flag;
    notifyListeners();
  }
}