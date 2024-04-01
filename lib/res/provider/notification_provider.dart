import 'package:mahajong/model/notification_model.dart';
import 'package:flutter/material.dart';


class NotificationProvider with ChangeNotifier {
  NotificationModel? _NotificationData;

  NotificationModel? get NotificationData => _NotificationData;

  void setnotification(NotificationModel notidata) {
    _NotificationData = notidata;
    notifyListeners();
  }
}