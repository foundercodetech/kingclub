// ignore_for_file: use_build_context_synchronously

import 'package:mahajong/model/user_model.dart';
import 'package:mahajong/res/provider/user_view_provider.dart';
import 'package:mahajong/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class SplashServices {
  Future<UserModel> getUserData() => UserViewProvider().getUser();
  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async {
      if (kDebugMode) {
        print(value.id.toString());
        print('valueId');
      }
      if (value.id.toString() == 'null' || value.id.toString() == '') {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.loginScreen);
      } else {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.bottomNavBar);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}