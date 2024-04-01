import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mahajong/model/user_model.dart';
import 'package:mahajong/res/aap_colors.dart';
import 'package:mahajong/res/api_urls.dart';
import 'package:mahajong/res/provider/user_view_provider.dart';
import 'package:mahajong/Aviator/aviator_model/my_bet_model.dart';

class AllBets {
  String? username;
  String? bet;
  String? win;
  AllBets(this.username, this.bet, this.win);
}

class avaitorBetHistory extends StatefulWidget {
  const avaitorBetHistory({Key? key}) : super(key: key);

  @override
  State<avaitorBetHistory> createState() => _avaitorBetHistoryState();
}

class _avaitorBetHistoryState extends State<avaitorBetHistory> {
  List<MyBetModel> bets = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myBet();
  }

  double height = 150;
  double width = 300;
  @override
  Widget build(BuildContext context) {
    if (responseStatusCode == 400) {
      return const SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_month_outlined,
              size: 50,
              color: Colors.grey,
            ),
            Text('No Data Found Today',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: width * 0.3,
                    child: const Text("Game S.No",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: width * 0.3,
                    child: const Text("Bet, INR X",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: width * 0.3,
                    child: const Text("Win, INR",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: bets.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: width * 0.3,
                              child:Text('2024'+bets[index].gamesno.toString(),
                                  maxLines: 1,

                                  style: const TextStyle(
                                      color:  AppColors.secondaryTextColor, fontSize: 14)                              ),),
                            Container(
                                alignment: Alignment.center,
                                width: width * 0.3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(bets[index].multiplier=='null'?'${bets[index].amount}':'${bets[index].amount} , ',
                                        style: const TextStyle(
                                            color:  AppColors.secondaryTextColor, fontSize: 14)),
                                    Container(
                                      width: 35,
                                      child: Text(bets[index].multiplier=='null'?'':'${bets[index].multiplier}',
                                          style: const TextStyle(
                                              color:  AppColors.secondaryTextColor, fontSize: 14)),
                                    ),
                                  ],
                                )),

                            Container(
                                alignment: Alignment.centerRight,
                                width: width * 0.3,
                                child: Text(bets[index].cashoutAmount=="null"?'- ₹ 0.0':
                                '+ ₹ ${bets[index].cashoutAmount}',
                                    style:  TextStyle(
                                        color:  bets[index].cashoutAmount=="null"?Colors.red:
                                        Colors.green,
                                        fontSize: 14))),
                          ],
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      );
    }
  }

  int? responseStatusCode;
  UserViewProvider userProvider = UserViewProvider();

  Future<void> myBet() async {

    UserModel user = await userProvider.getUser();
    String userid = user.id.toString();
    final url = "${ApiUrl.betAvaiHistory}userid=$userid";
    try {
      final response = await http.get(Uri.parse(url));
      print(url);
      if (kDebugMode) {
        print(url);
      }
      setState(() {
        responseStatusCode = response.statusCode;
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        setState(() {
          bets = (responseData['data'] as List<dynamic>)
              .map((item) => MyBetModel.fromJson(item))
              .toList();
        });
      } else if (response.statusCode == 400) {
        if (kDebugMode) {
          print('Data not found');
        }
      } else {
        setState(() {
          bets = [];
        });
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        bets = [];
      });
    }
  }
}
