// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:mahajong/generated/assets.dart';
import 'package:mahajong/model/user_model.dart';
import 'package:mahajong/res/api_urls.dart';
import 'package:mahajong/res/components/image_tost.dart';
import 'package:mahajong/res/provider/user_view_provider.dart';
import 'package:mahajong/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class BetColorResultProvider with ChangeNotifier {

  UserViewProvider userProvider = UserViewProvider();

  bool _regLoading = false;
  bool get regLoading =>_regLoading;
  setRegLoading(bool value){
    _regLoading=value;
    notifyListeners();
  }
  Future Colorbet(context, String amount, String number,int gameid) async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    setRegLoading(true);
    final response = await http.post(
      Uri.parse(ApiUrl.betColorPrediction),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
      "userid":token,
      "amount":amount,
        "gameid":gameid.toString(),
        "number": number

      }),
    );
    if (response.statusCode == 200) {
      print(response);
      print("responsebet");
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print(responseData);
      print("responseData");
      setRegLoading(false);
      Navigator.pop(context);
     // Navigator.pushReplacementNamed(context,  RoutesName.winGoScreen);
      return  ImageToast.show(imagePath: Assets.imagesBetSucessfull, context: context,heights: 200,widths: 200);
        //Fluttertoast.showToast(msg: responseData['msg']);
    } else {
      setRegLoading(false);
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return Fluttertoast.showToast(msg: responseData['msg']);
    }
  }
}