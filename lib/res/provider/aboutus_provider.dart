import 'package:mahajong/model/aboutus_model.dart';
import 'package:flutter/material.dart';


class AboutusProvider with ChangeNotifier {
  AboutusModel? _aboutusData;

  AboutusModel? get aboutusData => _aboutusData;

  void setUser(AboutusModel userData) {
    _aboutusData = userData;
    notifyListeners();
  }
}