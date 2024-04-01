import 'package:mahajong/model/ContactUsmodel.dart';

import 'package:flutter/material.dart';


class ContactUsProvider with ChangeNotifier {
  Contactusmodel? _contactusData;

  Contactusmodel? get ContactusData => _contactusData;

  void setCu(Contactusmodel contactData) {
    _contactusData = contactData;
    notifyListeners();
  }
}