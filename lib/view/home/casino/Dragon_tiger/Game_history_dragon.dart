// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mahajong/generated/assets.dart';
import 'package:mahajong/model/user_model.dart';
import 'package:mahajong/res/aap_colors.dart';
import 'package:mahajong/res/api_urls.dart';
import 'package:mahajong/res/components/text_widget.dart';
import 'package:mahajong/res/provider/user_view_provider.dart';
import 'package:mahajong/view/home/casino/Dragon_tiger/Apimodel/bethistory.dart';
import 'package:http/http.dart' as http;

class Dragon_gameHistory extends StatefulWidget {
  const Dragon_gameHistory({super.key});

  @override
  State<Dragon_gameHistory> createState() => _Dragon_gameHistoryState();
}

class _Dragon_gameHistoryState extends State<Dragon_gameHistory> {


  Future<bool> _onWillPop() async {
    SystemChrome.setPreferredOrientations([

      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    Navigator.of(context, rootNavigator: true).pop(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width  = MediaQuery.of(context).size.width;
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
              child: GestureDetector(
                  onTap: () {
                    SystemChrome.setPreferredOrientations([
                      DeviceOrientation.landscapeLeft,
                      DeviceOrientation.landscapeRight,
                    ]);
                    Navigator.pop(context);
                    },
                  child: SvgPicture.asset(Assets.iconsArrowBack)),
            ),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.red,
              centerTitle: true,
              title: textWidget(text: "Game History",fontSize: 18,color: Colors.white)

          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              // image: DecorationImage(
              //     fit: BoxFit.fill, image: AssetImage(background)
              // ),
            ),
            child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: height*0.60,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10) ),
                child: ListView(
                  shrinkWrap: true,
                 // physics: ClampingScrollPhysics(),
                  children: [
                    FutureBuilder<List<Bethistorycon>>(
                      future: que(),
                      builder:(context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );

                        }
                        else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        }
                        else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Text("Does not exist", style: TextStyle(fontSize: width * 0.03, color: Colors.black)),

                              ],
                            ),
                          );
                        }
                        else {
                          return ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext, int index){
                                return Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  child: Container(
                                    width: width*0.60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Game S.No."
                                                ,style: TextStyle(fontSize: width*0.03,fontWeight: FontWeight.w800,
                                                    color: AppColors.secondaryTextColor),),
                                              Text(snapshot.data![index].gamesno.toString(),
                                                maxLines: 1,
                                                style: TextStyle(fontSize: width*0.03,fontWeight: FontWeight.w800,
                                                    ),),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Status",style: TextStyle(fontSize: width*0.03,fontWeight: FontWeight.w800,
                                                  color: AppColors.secondaryTextColor),),
                                              Text(snapshot.data![index].status=='1'?'Win':'Lose',style: TextStyle(fontSize: width*0.03,fontWeight: FontWeight.w800,
                                                  color: snapshot.data![index].status=='1'?Colors.green: Colors.red),),
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Total Amount",style: TextStyle(fontSize: width*0.03,fontWeight: FontWeight.w800,
                                                  color: AppColors.secondaryTextColor),),
                                              Text(snapshot.data![index].totalamounts==null?"₹0.0":"₹${snapshot.data![index].totalamounts}",style: TextStyle(fontSize: width*0.03,fontWeight: FontWeight.w800,
                                                  color: AppColors.secondaryTextColor),),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Win Amount",style: TextStyle(fontSize: width*0.03,fontWeight: FontWeight.w800,
                                                  color: AppColors.secondaryTextColor),),
                                              Text(snapshot.data![index].winning_amount==null?"₹0.0":"₹${snapshot.data![index].winning_amount}",style: TextStyle(fontSize: width*0.03,fontWeight: FontWeight.w800,
                                                  color: AppColors.secondaryTextColor),),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Winner",style: TextStyle(fontSize: width*0.03,fontWeight: FontWeight.w800,
                                                  color: AppColors.secondaryTextColor),),
                                              Image.asset(snapshot.data![index].winner==1?Assets.dragontigerIcDtTie:snapshot.data![index].winner==2?Assets.dragontigerIcDtD:Assets.dragontigerIcDtT,
                                              height: height*0.022,)
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Dragon",style: TextStyle(fontSize: width*0.03,fontWeight: FontWeight.w800,
                                                  color: AppColors.secondaryTextColor),),
                                              Text(snapshot.data![index].dragon.toString(),style: TextStyle(fontSize: width*0.03,fontWeight: FontWeight.w800,
                                                color: AppColors.secondaryTextColor,),),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                            children: [
                                              Text("Tiger",style: TextStyle(fontSize: width*0.03,fontWeight: FontWeight.w800,
                                                  color: AppColors.secondaryTextColor),),
                                              Text(snapshot.data![index].tiger.toString(),style: TextStyle(fontSize: width*0.03,fontWeight: FontWeight.w800,
                                                  color: AppColors.secondaryTextColor),),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Tie",style: TextStyle(fontSize: width*0.03,fontWeight: FontWeight.w800,
                                                  color: AppColors.secondaryTextColor),),
                                              Text(snapshot.data![index].tie.toString(),style: TextStyle(fontSize: width*0.03,fontWeight: FontWeight.w800,
                                                  color: AppColors.secondaryTextColor),),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Date",style: TextStyle(fontSize: width*0.03,fontWeight: FontWeight.w800,
                                                  color: AppColors.secondaryTextColor),),
                                              Text(snapshot.data![index].datetime==null?'not added':DateFormat("E, dd-MMM-yyyy, H:mm a").format(
                                                  DateTime.parse(snapshot.data![index].datetime.toString())),
                                                  style: TextStyle(fontSize: width*0.03,fontWeight: FontWeight.w800,
                                                  )
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                      },

                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  UserViewProvider userProvider = UserViewProvider();

  Future<List<Bethistorycon>> que() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    print("hfs6");
    final response = await http.get(Uri.parse(ApiUrl.bethistory+token),
    );
    print(ApiUrl.bethistory+token);
    print("ApiUrl.bethistory+token");

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['data'] as List<dynamic>;
      print(jsonData);
      print('ttttttttttttttttt');
      return jsonData.map((item) => Bethistorycon.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

}

