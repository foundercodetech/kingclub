import 'package:mahajong/model/promotion_count_model.dart';
import 'package:flutter/material.dart';


class PromotionCountProvider with ChangeNotifier {
  PromotionCountModel? _countData;

  PromotionCountModel? get countData => _countData;

  void setUser(PromotionCountModel countData) {
    _countData = countData;
    notifyListeners();
  }
}