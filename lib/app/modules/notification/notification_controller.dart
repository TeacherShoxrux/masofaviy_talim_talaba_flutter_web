import 'package:flutter/material.dart';

enum NotifyType { success, error, warning, info }

class NotificationController extends ChangeNotifier {
  String? message;
  NotifyType? type;

  void show(String msg, NotifyType t,[int duration=3]) {
    message = msg;
    type = t;
    notifyListeners();

    Future.delayed(Duration(seconds: duration), () {
      clear();
      notifyListeners();
    });
  }

  void clear() {
    message = null;
    type = null;
  }
}
