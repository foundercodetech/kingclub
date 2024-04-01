import 'package:mahajong/model/termsconditionModel.dart';
import 'package:flutter/material.dart';


class TermsConditionProvider with ChangeNotifier {
  TcModel? _tcData;

  TcModel? get TcData => _tcData;

  void setterms(TcModel condData) {
    _tcData = condData;
    notifyListeners();
  }
}