import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:mahajong/generated/assets.dart';
import 'package:mahajong/res/aap_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {
  static void flushBarSuccessMessage(String message, BuildContext context,Color messageColor) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: message,
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        duration: const Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.green,
        borderRadius: BorderRadius.circular(30),
        positionOffset: 20,
        icon: const Icon(
          Icons.error_outline,
          size: 20,
          color: Colors.white,
        ),
      )..show(context),
    );
  }


  static void flushBarErrorMessage(String message, BuildContext context,Color messageColor) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: message,
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        duration: const Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        borderRadius: BorderRadius.circular(30),
        backgroundColor: Colors.red,
        positionOffset: 20,
        icon: const Icon(
          Icons.error_outline,
          size: 20,
          color: AppColors.primaryTextColor,
        ),
      )..show(context),
    );
  }


  static showExitConfirmation(BuildContext context) async {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return await showModalBottomSheet(
      elevation: 5,
      backgroundColor: Colors.red.shade400,
      shape: RoundedRectangleBorder(
          side: BorderSide(width:2, color:Colors.white),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
      ),
      context: context,
      builder: (context) {
        return Container(
          height: height * 0.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))),
          child: Column(
            children: [
              SizedBox(height: height / 30),
              Text("EXIT APP",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: height / 30),
              Text("Are you sure want to exit?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: width * 0.05,
                  )),
              SizedBox(height: height * 0.04),
              Container(
                width: width * 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(

                            side: BorderSide(width:1, color:Colors.white),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: width*0.34,vertical: height*0.02)
                        ),
                        onPressed: (){

                          SystemNavigator.pop();
                        },
                        child: Text("Yes",style:TextStyle(
                            color: Colors.black,
                            fontSize: width * 0.06,
                            fontWeight: FontWeight.bold))
                    ),


                    SizedBox(height: height * 0.03),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            side: BorderSide(width:1),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: width*0.34,vertical: height*0.02)
                        ),
                        onPressed: (){

                          Navigator.pop(context, false);
                        },
                        child: Text("No",style:TextStyle(
                            color: Colors.black,
                            fontSize: width * 0.06,
                            fontWeight: FontWeight.bold))
                    ),

                  ],
                ),
              )
            ],
          ),
        );
      },
    ) ??
        false;
  }

  static showImageComming(BuildContext context) async {
    final height = MediaQuery.of(context).size.height;
    return await showDialog(
        context: context,
        builder: (context){
      return AlertDialog(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: SizedBox(
          height: height * 0.35,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close_sharp), onPressed: () {
                  Navigator.pop(context);
                },),
              ),
              Container(
                height: height * 0.28,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Assets.imagesCommingsoon),
                        fit: BoxFit.fill)
                ),


              ),
            ],
          ),
        ),
      );

  });}
}

