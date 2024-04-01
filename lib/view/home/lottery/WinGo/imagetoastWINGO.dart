import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mahajong/generated/assets.dart';
import 'dart:ui' as ui;

import 'package:mahajong/res/components/text_widget.dart';



class ImageToastWingo {
  static void show({
    // required String imagePath, // Path to your image asset
    required String text, // Path to your image asset
    required String subtext, // Path to your image asset
    required String subtext1, // Path to your image asset
    required String subtext2, // Path to your image asset
    required BuildContext context,
    double? widths, // Custom width, pass null if you don't want to set a custom width
    double? heights, // Custom width, pass null if you don't want to set a custom width
  }) {
    FToast fToast = FToast();

    // Initialize FToast with the provided context
    fToast.init(context);

    fToast.showToast(
      child:  Container(
        width: widths ?? 300,
        height:heights?? 300,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(Assets.imagesLosstoast),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height:15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textWidget(
                  text: "Win Go: ",
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textWidget(
                  text: subtext2=='1'
                      ?'1 Min'
                      :subtext2=='2'
                      ?'3 Min'
                      :subtext2=='3'
                      ?'5 Min'
                      :'10 Min',
                  fontSize: 14,
                  color: Colors.indigo.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(height:15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textWidget(
                  text: "Game S.No: ",
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textWidget(
                  text: text,
                  fontSize: 14,
                  color:Colors.indigo.shade900,
                  fontWeight: FontWeight.w900,
                ),
              ],
            ),
            SizedBox(height: 60,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                textWidget(
                  text: "Total Bet Amount:",
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textWidget(
                  text: subtext,
                  fontSize: 12,
                  color: Colors.indigo.shade900,
                  fontWeight: FontWeight.w900,
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                textWidget(
                  text: "Total Win Amount:",
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textWidget(
                  text: subtext1,
                  fontSize: 12,
                  color: Colors.indigo.shade900,
                  fontWeight: FontWeight.w900,
                ),
              ],
            ),
            // ListTile(
            //   leading: textWidget(
            //     text: "Game S.No.:",
            //     fontSize: 12,
            //     color: Colors.black,
            //     fontWeight: FontWeight.bold,
            //   ),
            //   trailing: textWidget(
            //     text: text,
            //     fontSize: 12,
            //     color: AppColors.secondaryTextColor,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // ListTile(
            //   leading: textWidget(
            //     text: "Total Bet Amount:",
            //     fontSize: 12,
            //     color: Colors.black,
            //     fontWeight: FontWeight.bold,
            //   ),
            //   trailing: textWidget(
            //     text: subtext,
            //     fontSize: 12,
            //     color: AppColors.secondaryTextColor,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // ListTile(
            //   leading: textWidget(
            //     text: "Total Win Amount:",
            //     fontSize: 12,
            //     color: Colors.black,
            //     fontWeight: FontWeight.bold,
            //   ),
            //   trailing: textWidget(
            //     text: subtext1,
            //     fontSize: 12,
            //     color: AppColors.secondaryTextColor,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),

          ],
        ),

      ),
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 4),
    );
  }
}