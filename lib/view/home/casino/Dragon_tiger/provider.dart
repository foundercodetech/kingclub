import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mahajong/utils/utils.dart';

class AuthProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // LoginModel? _loginResponse;
  // LoginModel? get loginResponse => _loginResponse;

  Future userLogin(context, String phoneNumber) async {
    setLoading(true);
    final response = await http.post(
      Uri.parse(''),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"mobile": phoneNumber}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body)['id'];

      if (responseData['error'] == '200') {
        setLoading(false);
        // _loginResponse = LoginModel.fromJson(responseData);

        return Utils.flushBarSuccessMessage(
            responseData['msg'], context, Colors.white);
      } else {
        setLoading(false);
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        //  _loginResponse = LoginModel.fromJson(responseData);
        return Utils.flushBarErrorMessage(
            responseData['msg'], context, Colors.white);
      }
    } else {
      setLoading(false);
      return Utils.flushBarErrorMessage('server error', context, Colors.white);
    }
  }
}
