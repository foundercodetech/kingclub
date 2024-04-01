import 'package:mahajong/model/withdrawhistory_model.dart';
import 'package:flutter/material.dart';


class WithdrawHistoryProvider with ChangeNotifier {
  List<WithdrawModel> _withdrawList = [];

  List<WithdrawModel> get withdrawlist => _withdrawList;

  void setwithdrawList(List<WithdrawModel> withdraws) {
    _withdrawList = withdraws;
    notifyListeners();
  }
}
