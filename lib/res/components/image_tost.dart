import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui' as ui;

class ImageToast {
  static void show({
    required String imagePath, // Path to your image asset
    required BuildContext context,
    double? widths, // Custom width, pass null if you don't want to set a custom width
    double? heights, // Custom width, pass null if you don't want to set a custom width
  }) {
    FToast fToast = FToast();

    // Initialize FToast with the provided context
    fToast.init(context);

    fToast.showToast(
      child:  Container(
        width: widths ?? MediaQuery.of(context).size.width,
        height:heights?? MediaQuery.of(context).size.height * 3.18,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(imagePath),
          ),
        ),
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }
}