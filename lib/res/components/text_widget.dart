import 'package:mahajong/res/aap_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textWidget({
  required String text,
  double fontSize = 12,
  FontWeight fontWeight = FontWeight.normal,
  Color color = Colors.black,
  TextAlign textAlign = TextAlign.start,
  bool strikethrough = false,
  int? maxLines,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: maxLines != null ? TextOverflow.ellipsis : null,
    style: GoogleFonts.lato(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      decoration: strikethrough ? TextDecoration.lineThrough : null,
    ),
  );
}