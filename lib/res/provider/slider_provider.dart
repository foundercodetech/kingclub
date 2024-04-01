import 'package:mahajong/model/Slider_model.dart';
import 'package:flutter/material.dart';


class SliderProvider with ChangeNotifier {
  List<SliderModel> _sliderList = [];

  List<SliderModel> get sliderList => _sliderList;

  void setSliderList(List<SliderModel> sliders) {
    _sliderList = sliders;
    notifyListeners();
  }
}
