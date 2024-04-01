import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ChooseImage {
  static Future<String?> chooseImageAndConvertToString(
      ImageSource imageSource) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: imageSource,
      imageQuality: 50,
      maxHeight: 500,
      maxWidth: 500,
    );

    if (pickedFile != null) {
      final bytes = File(pickedFile.path).readAsBytesSync();
      return base64Encode(bytes);
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
      return null;
    }
  }
}