import 'package:mahajong/model/termsconditionModel.dart';
import 'package:flutter/material.dart';


class PrivacyPolicyProvider with ChangeNotifier {
  TcModel? _ppData;

  TcModel? get PpData => _ppData;

  void setPrivacy(TcModel privacyData) {
    _ppData = privacyData;
    notifyListeners();
  }
}