// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:mahajong/generated/assets.dart';
import 'package:mahajong/model/user_model.dart';
import 'package:mahajong/model/wallet_history_model.dart';
import 'package:mahajong/res/aap_colors.dart';
import 'package:mahajong/res/api_urls.dart';
import 'package:mahajong/res/components/app_bar.dart';
import 'package:mahajong/res/components/app_btn.dart';
import 'package:mahajong/res/components/text_widget.dart';
import 'package:mahajong/res/provider/user_view_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:mahajong/view/wallet/wallet_history.dart';
import 'package:mahajong/view/wallet/wallet_history.dart';
import '../../model/deposit_model.dart';


class WalletHistory extends StatefulWidget {
  final String? name;
  final String? type;
  const WalletHistory({super.key, this.name,this.type});

  @override
  State<WalletHistory> createState() => _WalletHistoryState();
}

class _WalletHistoryState extends State<WalletHistory> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    WalletHistoryyy();
    super.initState();

  }

  int ?responseStatuscode;


  @override
  Widget build(BuildContext context) {

    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: GradientAppBar(
          leading: const AppBackBtn(),
          title: textWidget(
              text:widget.name.toString(),
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryGradient),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            responseStatuscode== 400 ?
            const Notfounddata(): historyItem.isEmpty? const Center(child: CircularProgressIndicator()):
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: historyItem.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [

                            const SizedBox(
                              height: 4,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(
                                      text: "Balance",
                                      fontSize: widths * 0.04,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryTextColor),
                                  textWidget(
                                      text: historyItem[index].amount.toString(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryTextColor),
                                ],
                              ),
                            ),
                            Padding(
                              padding:  const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(
                                      text: "Type",
                                      fontSize: widths * 0.04,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryTextColor),

                                  textWidget(
                                      text: historyItem[index].type.toString(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryTextColor),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(
                                      text: "Time",
                                      fontSize: widths * 0.04,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryTextColor),
                                  // textWidget(
                                  //     text:
                                  //         '${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(historydeposit[index].date.toString() + historydeposit[index].time.toString()))}',
                                  //     fontSize: 14,
                                  //     fontWeight: FontWeight.w600,
                                  //     color: AppColors.secondaryTextColor),
                                  Text(DateFormat("dd-MMM-yyyy, hh:mm a").format(
                                      DateTime.parse(historyItem[index].datetime.toString())),
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),

                          ],
                        ),
                      );
                    })

            ),
            // textWidget(
            //     text: "No more",
            //     fontSize: 15,
            //     textAlign: TextAlign.center,
            //     fontWeight: FontWeight.w600,
            //     color: AppColors.secondaryTextColor),
          ],
        ),
      ),

    );
  }

  UserViewProvider userProvider = UserViewProvider();

  List<WalletHistoryModal> historyItem = [];

  Future<void> WalletHistoryyy() async {
    var type= widget.type.toString();
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(Uri.parse("${ApiUrl.walletHistory}$token&typeid=$type"),);
    print("${ApiUrl.walletHistory}$token&typeid=$type");
    print('WalletHistory');

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {

        historyItem = responseData.map((item) => WalletHistoryModal.fromJson(item)).toList();
        // selectedIndex = items.isNotEmpty ? 0:-1; //
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        historyItem = [];
      });
      throw Exception('Failed to load data');
    }
  }

}

class Notfounddata extends StatelessWidget {
  const Notfounddata({super.key});

  @override
  Widget build(BuildContext context){
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage(Assets.imagesNoDataAvailable),
          height: heights / 3,
          width: widths / 2,
        ),
        SizedBox(height: heights*0.07),
        const Text("Data not found",)
      ],
    );
  }

}



