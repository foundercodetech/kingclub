import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void copyToClipboard(String code, BuildContext context) {
  Clipboard.setData(
    ClipboardData(
      text: code,

    ),
  ).then(
        (value) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
      ),
    ),
  );

}