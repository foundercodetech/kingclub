import 'package:mahajong/model/colorprediction_model.dart';
import 'package:flutter/material.dart';


class ColorPredictionProvider with ChangeNotifier {
  List<ColorPredictionModel> _ResultListColor = [];

  List<ColorPredictionModel> get ResultListColorlist => _ResultListColor;

  void setColorResultList(List<ColorPredictionModel> colorlist) {
    _ResultListColor = colorlist;
    notifyListeners();
  }
}
