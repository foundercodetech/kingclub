import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui' as ui;

class TextToast {
  static void show({
    required String message,
    required BuildContext context,
  }) {
    FToast fToast = FToast();
    List messages=  message.split(' ');
    // Initialize FToast with the provided context
    fToast.init(context);

    fToast.showToast(
      child: Opacity(
        opacity: 0.9,
        child: Container(

          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.18,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Colors.black.withOpacity(0.5),
                Colors.black,
                Color(0xff070100),
                Color(0xff070100),
                Color(0xff332038),
                Color(0xff332038),
                Color(0xff070100),
                Color(0xff070100),
                Colors.black,
                Colors.black.withOpacity(0.5)
              ],
            ),
          ),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for(var data in messages)
                Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Center(
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return ui.Gradient.linear(
                          Offset(0.0, 0.0),
                          Offset(200.0, 70.0),
                          [Colors.amber,Colors.deepOrange], // Two colors in the list
                        );
                      },
                      child: Text(
                        data,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height*0.07,
                          fontWeight: FontWeight.w900,
                          color: Colors.white, // Text color is set to white
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 1),
    );
  }
}