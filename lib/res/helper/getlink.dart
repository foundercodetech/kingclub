import 'dart:convert';
import 'package:mahajong/model/user_model.dart';
import 'package:mahajong/res/api_urls.dart';
import 'package:mahajong/res/provider/user_view_provider.dart';
import 'package:http/http.dart' as http;

 var amount;
 var days;


Future<void> attendence_view() async {
  UserViewProvider userProvider = UserViewProvider();

  UserModel user = await userProvider.getUser();
  String token = user.id.toString();
  print("ffffffffff");

  final url = Uri.parse(ApiUrl.AttendenceGet+"userid=$token&tableid=");
  final response = await http.get(url,);
  print("fgggghgggg");
  if(response.statusCode==200){
    print(response.statusCode);
    print("guygugu");
    final responseData = json.decode(response.body)['data'];
    amount = responseData["amount"].toString();
    days = responseData["days"].toString();


    print("guygugu");

  }else{
    throw Exception("load to display");
  }
}