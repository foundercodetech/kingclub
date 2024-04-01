
import 'package:flutter/material.dart';

class Constants {
  static const RandomColorModel greenGradient  = RandomColorModel(
    gradient: LinearGradient(
      colors: [Color.fromARGB(255, 2, 173, 102), Color.fromARGB(255, 0, 128, 0)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
  );
  static  RandomColorModel redGradient  = RandomColorModel(
    gradient: LinearGradient(
      colors: [Colors.red.withOpacity(0.7), Colors.deepOrange.withOpacity(0.7)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
  );
}

class RandomColorModel {
  final LinearGradient gradient;

  const RandomColorModel({required this.gradient});
}
