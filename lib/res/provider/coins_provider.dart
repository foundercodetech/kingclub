import 'package:mahajong/model/coin_model.dart';
import 'package:flutter/material.dart';


class CoinProvider with ChangeNotifier {
  List<CoinModel> _Coinsdata = [];

  List<CoinModel> get CoinData => _Coinsdata;

  void setCoins(List<CoinModel> datacoin) {
    _Coinsdata = datacoin;
    notifyListeners();
  }

  // CoinModel? _Coinsdata;
  //
  // CoinModel? get CoinData => _Coinsdata;
  //
  // void setCoins(CoinModel datacoin) {
  //   _Coinsdata = datacoin;
  //   notifyListeners();
  // }
}