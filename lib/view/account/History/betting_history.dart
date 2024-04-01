// ignore_for_file: depend_on_referenced_packages, unrelated_type_equality_checks, non_constant_identifier_names, avoid_types_as_parameter_names

import 'dart:convert';

import 'package:mahajong/model/bettingHistory_Model.dart';
import 'package:mahajong/model/user_model.dart';
import 'package:mahajong/res/aap_colors.dart';
import 'package:mahajong/res/components/app_bar.dart';
import 'package:mahajong/res/components/app_btn.dart';
import 'package:mahajong/res/components/clipboard.dart';
import 'package:mahajong/res/components/text_widget.dart';
import 'package:mahajong/res/provider/user_view_provider.dart';
import 'package:mahajong/view/account/History/AvaitorBethistory.dart';
import 'package:mahajong/view/home/casino/Dragon_tiger/Apimodel/bethistory.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mahajong/view/home/casino/Plinko/Plinko_model/plinkohistorymodel.dart';
import '../../../generated/assets.dart';
import '../../../res/api_urls.dart';
import 'package:http/http.dart' as http;


class BetHistory extends StatefulWidget {
  const BetHistory({super.key});

  @override
  State<BetHistory> createState() => _BetHistoryState();
}

class _BetHistoryState extends State<BetHistory> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    PlinkoGameHistory();
    BettingHistory();
    super.initState();
    selectedCatIndex = 0;
  }

  int ?responseStatuscode;


  List<BetIconModel> betIconList = [
    BetIconModel(title: 'Lottery', image: Assets.imagesLotteryIcon),
    BetIconModel(title: 'Aviator', image: Assets.imagesCasinoIcon),
    BetIconModel(title: 'Dragon Tiger', image: Assets.imagesCasinoIcon),
    BetIconModel(title: 'Plinko', image: Assets.imagesCasinoIcon),
  ];

  late int selectedCatIndex;



  @override
  Widget build(BuildContext context) {
    print(selectedCatIndex);
    print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: GradientAppBar(
          leading: const AppBackBtn(),
          title: textWidget(
              text: 'Bet History',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryGradient),
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            height: 70,
            width: widths * 0.93,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: betIconList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCatIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      height: 35,
                      width: 115,
                      decoration: BoxDecoration(
                        gradient: selectedCatIndex == index
                            ? AppColors.containerTopToBottomGradient
                            : AppColors.secondaryGradient,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey, width: 0.1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 0.2,
                            blurRadius: 2,
                            offset: const Offset(2, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('${betIconList[index].image}'),
                            height: 25,
                            color: selectedCatIndex == index
                                ? AppColors.primaryContColor
                                : AppColors.iconColor,
                          ),
                          textWidget(
                            text: betIconList[index].title,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: selectedCatIndex == index
                                ? AppColors.primaryContColor
                                : AppColors.secondaryTextColor,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          const SizedBox(height: 5,),
          selectedCatIndex==0?
         Container(
                child:responseStatuscode== 400 ?
              const Notfounddata(): items.isEmpty? const Center(child: CircularProgressIndicator()):
               Padding(
               padding: const EdgeInsets.all(8.0),
                 child: ListView.builder(
                  itemCount: items.length,
                  shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                   itemBuilder: (context , index){
                       List<Color> colors;

          if (items[index].number == '0') {
            colors = [
              const Color(0xFFfd565c),
              const Color(0xFFb659fe),
            ];
          } else if (items[index].number == '5') {
            colors = [
              const Color(0xFF40ad72),
              const Color(0xFFb659fe),
            ];
          }  else if (items[index].number == '10') {
            colors = [
              const Color(0xFF40ad72),
              const Color(0xFF40ad72),

            ];
          }  else if (items[index].number == '20') {
            colors = [

              const Color(0xFFb659fe),
              const Color(0xFFb659fe),
            ];
          }  else if (items[index].number == '30') {
            colors = [
              const Color(0xFFfd565c),
              const Color(0xFFfd565c),
            ];
          }  else if (items[index].number == '40') {
            colors = [
              const Color(0xFF40ad72),
              const Color(0xFF40ad72),

            ];
          }  else if (items[index].number == '50') {
            colors = [
              //blue
              const Color(0xFF6da7f4),
              const Color(0xFF6da7f4)
            ];
          } else {
            int number = int.parse(items[index].number.toString());
            colors = number.isOdd
                ? [
              const Color(0xFF40ad72),
              const Color(0xFF40ad72),
            ]
                : [
              const Color(0xFFfd565c),
              const Color(0xFFfd565c),
            ];
          }

          return  Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            height: 25,
                            width: widths * 0.40,
                            decoration:  BoxDecoration(
                                color:  Colors.red,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: textWidget(
                                text: 'Bet',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryTextColor),
                          ),
                        ),
                        textWidget(text:  items[index].status=="0"?"Pending":items[index].status=="1"?"Win":"Loss",
                            fontSize: widths*0.05,
                            fontWeight: FontWeight.w600,
                            color: AppColors.methodblue

                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4,),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(text: "Balance",
                            fontSize: widths*0.03,
                            fontWeight: FontWeight.w800,
                            color: AppColors.secondaryTextColor

                        ),
                        textWidget(
                            // text: "₹${items[index].amount}",
                            text: "₹"+double.parse(items[index].amount.toString()).toStringAsFixed(2),
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: AppColors.secondaryTextColor
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(text: "Bet Type",
                            fontSize: widths*0.03,
                            fontWeight: FontWeight.w800,
                            color: AppColors.secondaryTextColor
                        ),
                        int.parse(items[index].number.toString())<=9?
                        Container(
                          alignment: Alignment.centerRight,
                          width: widths*0.20,
                          child: GradientText(
                            items[index].number.toString(),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900),
                            gradient: LinearGradient(
                                colors: colors,
                                stops: const [
                                  0.5,
                                  0.5,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                tileMode: TileMode.mirror),
                          ),
                        ):GradientText(
                          items[index].number.toString()=='10'?'Green':items[index].number.toString()=='20'?'Voilet':items[index].number.toString()=='30'?'Red':items[index].number.toString()=='40'?'Big':items[index].number.toString()=='50'?'Small':'',
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900),
                          gradient: LinearGradient(
                              colors: colors,
                              stops: const [
                                0.5,
                                0.5,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              tileMode: TileMode.mirror),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(text: "Type",
                            fontSize: widths*0.03,
                            fontWeight: FontWeight.w800,
                            color: AppColors.secondaryTextColor
                        ),
                        textWidget(text: items[index].gameid=="1"?"1 min":items[index].gameid=="2"?"3 min":items[index].gameid=="4"?"5 min":"10 min",
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: AppColors.secondaryTextColor
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(text: "Win Amount",
                            fontSize: widths*0.03,
                            fontWeight: FontWeight.w800,
                            color: AppColors.secondaryTextColor
                        ),
                        textWidget(
                            // text: items[index].win==null?'₹ 0.0':'₹ ${items[index].win}',
                            text:"₹"+double.parse(items[index].win==null?'0.0':items[index].win.toString()).toStringAsFixed(2),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondaryTextColor
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(text: "Time",
                            fontSize: widths*0.03,
                            fontWeight: FontWeight.w800,
                            color: AppColors.secondaryTextColor
                        ),
                        textWidget(
                            text: DateFormat("dd-MMM-yyyy, hh:mm a").format(
                                DateTime.parse(items[index].datetime.toString())),
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: AppColors.secondaryTextColor

                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(text: "Order number",
                            fontSize: widths*0.03,
                            fontWeight: FontWeight.w800,
                            color: AppColors.secondaryTextColor
                        ),
                        Row(
                          children: [
                            textWidget(text: items[index].gamesno.toString(),
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: AppColors.secondaryTextColor
                            ),
                            SizedBox(width: widths*0.01,),
                            InkWell(
                                onTap: (){
                                  copyToClipboard(items[index].gamesno.toString(),context);
                                },
                                child: Image.asset(Assets.iconsCopy,color: Colors.grey,height: heights*0.027,)),

                          ],
                        ),

                      ],
                    ),
                  ),

                ],
              ),
            ),
          );

        }),
  ),):
          selectedCatIndex==1?
          const avaitorBetHistory():
          selectedCatIndex==2?
          responseStatuscode== 400 ?
          const Notfounddata(): items.isEmpty? const Center(child: CircularProgressIndicator()):
          Padding(
            padding: const EdgeInsets.all(8.0),
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

                            Text("Does not exist", style: TextStyle(fontSize: widths * 0.03, color: Colors.black)),

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
                                width: widths*0.60,
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
                                            ,style: TextStyle(fontSize: widths*0.03,fontWeight: FontWeight.w800,
                                                color: AppColors.secondaryTextColor),),
                                          Text(snapshot.data![index].gamesno.toString(),
                                            maxLines: 1,
                                            style: TextStyle(fontSize: widths*0.03,fontWeight: FontWeight.w800,
                                            ),),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Status",style: TextStyle(fontSize: widths*0.03,fontWeight: FontWeight.w800,
                                              color: AppColors.secondaryTextColor),),
                                          Text(snapshot.data![index].status=='1'?'Win':'Lose',style: TextStyle(fontSize: widths*0.03,fontWeight: FontWeight.w800,
                                              color: snapshot.data![index].status=='1'?Colors.green: Colors.red),),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Total Amount",style: TextStyle(fontSize: widths*0.03,fontWeight: FontWeight.w800,
                                              color: AppColors.secondaryTextColor),),
                                          Text(
                                            // snapshot.data![index].totalamounts==null?"₹0.0":"₹${snapshot.data![index].totalamounts}",
                                            "₹"+double.parse(snapshot.data![index].totalamounts==null?"0.0":"${snapshot.data![index].totalamounts}").toStringAsFixed(2),
                                            style: TextStyle(
                                                fontSize: widths*0.03,
                                                fontWeight: FontWeight.w800,
                                                color: AppColors.secondaryTextColor),),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Win Amount",style: TextStyle(fontSize: widths*0.03,fontWeight: FontWeight.w800,
                                              color: AppColors.secondaryTextColor),),
                                          // Text(snapshot.data![index].winning_amount==null?"₹0.0":"₹${snapshot.data![index].winning_amount}",style: TextStyle(fontSize: widths*0.03,fontWeight: FontWeight.w800,
                                          //     color: AppColors.secondaryTextColor),),
                                          Text(
                                            // snapshot.data![index].totalamounts==null?"₹0.0":"₹${snapshot.data![index].totalamounts}",
                                            "₹"+double.parse(snapshot.data![index].winning_amount==null?"0.0":"${snapshot.data![index].winning_amount}").toStringAsFixed(2),
                                            style: TextStyle(
                                                fontSize: widths*0.03,
                                                fontWeight: FontWeight.w800,
                                                color: AppColors.secondaryTextColor),),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Winner",style: TextStyle(fontSize: widths*0.03,fontWeight: FontWeight.w800,
                                              color: AppColors.secondaryTextColor),),
                                          Image.asset(snapshot.data![index].winner==1?Assets.dragontigerIcDtTie:snapshot.data![index].winner==2?Assets.dragontigerIcDtD:Assets.dragontigerIcDtT,
                                            height: heights*0.022,)
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Dragon",style: TextStyle(fontSize: widths*0.03,fontWeight: FontWeight.w800,
                                              color: AppColors.secondaryTextColor),),
                                          Text(snapshot.data![index].dragon.toString(),style: TextStyle(fontSize: widths*0.03,fontWeight: FontWeight.w800,
                                            color: AppColors.secondaryTextColor,),),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                        children: [
                                          Text("Tiger",style: TextStyle(fontSize: widths*0.03,fontWeight: FontWeight.w800,
                                              color: AppColors.secondaryTextColor),),
                                          Text(snapshot.data![index].tiger.toString(),style: TextStyle(fontSize: widths*0.03,fontWeight: FontWeight.w800,
                                              color: AppColors.secondaryTextColor),),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Tie",style: TextStyle(fontSize: widths*0.03,fontWeight: FontWeight.w800,
                                              color: AppColors.secondaryTextColor),),
                                          Text(snapshot.data![index].tie.toString(),style: TextStyle(fontSize: widths*0.03,fontWeight: FontWeight.w800,
                                              color: AppColors.secondaryTextColor),),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Date",style: TextStyle(fontSize: widths*0.03,fontWeight: FontWeight.w800,
                                              color: AppColors.secondaryTextColor),),
                                          Text(snapshot.data![index].datetime==null?'not added':DateFormat("E, dd-MMM-yyyy, H:mm a").format(
                                              DateTime.parse(snapshot.data![index].datetime.toString())),
                                              style: TextStyle(fontSize: widths*0.03,fontWeight: FontWeight.w800,
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
          ):Notfounddata(),


        ],
      ),
    );
  }


  UserViewProvider userProvider = UserViewProvider();

  ///wingo screen history
  List<BettingHistoryModel> items = [];

  Future<void> BettingHistory() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(Uri.parse(ApiUrl.betHistory+token),);
    print(ApiUrl.betHistory+token);
    print('betHistory+token');

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        items = responseData.map((item) => BettingHistoryModel.fromJson(item)).toList();
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        items = [];
      });
      throw Exception('Failed to load data');
    }
  }


  ///dragon tiger game history

  Future<List<Bethistorycon>> que() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(
      Uri.parse(ApiUrl.bethistory+token),
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['data'] as List<dynamic>;
      print(ApiUrl.bethistory+token);
      print(jsonData);
      print('ttttttttttttttttt');
      return jsonData.map((item) => Bethistorycon.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }


  ///plinko history
  List<PlinkoGameHistoryModel> itemss = [];

  Future<void> PlinkoGameHistory() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(Uri.parse(ApiUrl.plinkoBetHistory+token),);
    print(ApiUrl.plinkoBetHistory+token);
    print('plinkoBetHistory+token');

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        itemss = responseData.map((item) => PlinkoGameHistoryModel.fromJson(item)).toList();
      });
      print(itemss);

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        itemss = [];
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


class BetIconModel {
  final String title;
  final String? image;
  BetIconModel({required this.title, this.image});
}
class GradientText extends StatelessWidget {
  const GradientText(
      this.text, {
        super.key,
        required this.gradient,
        this.style,
      });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
class History{
  String method;
  String balance;
  String type;
  String orderno;
  History(this.method,this.balance,this.type,this.orderno);
}