import 'package:mahajong/model/user_profile_model.dart';
import 'package:flutter/material.dart';


class ProfileProvider with ChangeNotifier {
  UserProfile? _userData;

  UserProfile? get userData => _userData;

  void setUser(UserProfile userData) {
    _userData = userData;
    notifyListeners();
  }
}