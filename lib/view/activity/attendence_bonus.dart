// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:mahajong/generated/assets.dart';
import 'package:mahajong/model/attendence_model.dart';
import 'package:mahajong/model/user_model.dart';
import 'package:mahajong/res/aap_colors.dart';
import 'package:mahajong/res/api_urls.dart';
import 'package:mahajong/res/components/app_bar.dart';
import 'package:mahajong/res/components/app_btn.dart';
import 'package:mahajong/res/components/text_widget.dart';
import 'package:mahajong/res/provider/user_view_provider.dart';
import 'package:mahajong/view/activity/attendence_history.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class AttendenceBonus extends StatefulWidget {
  const AttendenceBonus({super.key});

  @override
  State<AttendenceBonus> createState() => _AttendenceBonusState();
}

class _AttendenceBonusState extends State<AttendenceBonus> {

  @override
  void initState() {
    AttendenceList();
     attendence_days();


    // TODO: implement initState
    super.initState();
  }

  int ?responseStatuscode;

  @override
  Widget build(BuildContext context) {

    String? lastDay = AttendenceItems.isNotEmpty?AttendenceItems.last.datetime.toString():"No data";
    String lastAmount = AttendenceItems.isNotEmpty?AttendenceItems.last.amount.toString():"No data";
    String lastid = AttendenceItems.isNotEmpty?AttendenceItems.last.id.toString():"No data";
    String laststatus = AttendenceItems.isNotEmpty?AttendenceItems.last.status.toString():"No data";


    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: GradientAppBar(
          leading: const AppBackBtn(),
          title: textWidget(
              text: 'Attendance bonus',
              fontSize: width*0.05,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryGradient),
        body: ListView(
          children: [
            Container(
              decoration: const BoxDecoration(gradient: AppColors.primaryGradient,image: DecorationImage(image: AssetImage(Assets.imagesBggifts),fit: BoxFit.fill)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWidget(
                      text: "Attendence Bonus",
                      fontSize: width*0.047,
                      color: AppColors.primaryTextColor,
                        fontWeight: FontWeight.bold

                    ),
                    SizedBox(height: height*0.01,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidget(
                          text: "Get your rewards based on consecutive \n login days.",
                          fontSize: width*0.034,
                          color: AppColors.primaryTextColor,
                        ),
                        textWidget(
                          text: "* Tap to claim the daily rewards",
                          fontSize: width*0.04,
                          color: AppColors.primaryTextColor,
                            fontWeight: FontWeight.bold

                        ),
                      ],
                    ),
                    SizedBox(height: height*0.01),
                    Container(
                      height: height*0.10,
                      width: width*0.50,
                      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(Assets.imagesBookmark),fit: BoxFit.fill)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: height*0.01,),
                          textWidget(
                              text: "Attended consecutively",
                              fontSize: width*0.035,
                              color: Colors.red,
                              fontWeight: FontWeight.bold
                          ),
                          SizedBox(height: height*0.01,),
                          textWidget(
                              text: days==null?"0 Days":"$days Days",
                              fontSize: width*0.045,
                              color: Colors.red,
                              fontWeight: FontWeight.bold
                          ),
                        ],
                      ),
                    ),
                    textWidget(
                      text: "Accumulated",
                      fontSize: width*0.045,
                      color: AppColors.primaryTextColor,
                      fontWeight: FontWeight.bold
                    ),
                    textWidget(
                      text: amount==null?"₹ 0.0":"₹ $amount",
                      fontSize:  width*0.05,
                      color: AppColors.primaryTextColor,
                    ),
                    SizedBox(height: height*0.02,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const AttendenceHistory()));
                      },
                      child: Center(
                        child: Container(
                          height: height*0.045,
                          width: width*0.40,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                           gradient: const LinearGradient(
                              colors: [Color(0xffff9b3e),Color(0xffffab3f)])),
                          child: Center(
                            child: textWidget(
                              text: "Attendence History",
                              fontSize:  width*0.035,
                              color: AppColors.primaryTextColor,
                            ),
                          ) ,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: height*0.02,),

            responseStatuscode== 400 ?
            const Notfounddata(): AttendenceItems.isEmpty? const Center(child: CircularProgressIndicator()):

            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount: AttendenceItems.length>6?6:AttendenceItems.length,
              itemBuilder: (BuildContext context, int index) {
                return
                  AttendenceItems[index].status=='1'?
                  InkWell(
                    onTap: (){
                      Attendenceget(ids:AttendenceItems[index].id.toString());
                    },
                    child: Card(
                    elevation:  3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          gradient: AppColors.secondaryGradient,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            textWidget(
                              text: "₹${AttendenceItems[index].amount}",
                              fontSize: width*0.04,
                            ),
                            Image.asset(Assets.imagesCoingifts, height: 45,),
                            textWidget(
                                text: DateFormat.EEEE().format(
                                    DateTime.parse(AttendenceItems[index].datetime.toString())),
                                fontSize: width*0.04,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondaryTextColor
                            ),

                          ],
                        ))),
                  )
                      :AttendenceItems[index].status=='2'?
                  Card(
                      elevation:  1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              textWidget(
                                text: "₹${AttendenceItems[index].amount}",
                                fontSize: width*0.04,
                              ),
                              textWidget(
                                  text: 'Redeemed',
                                  fontSize: width*0.04,
                                  fontWeight: FontWeight.w600,
                              ),
                              textWidget(
                                  text: DateFormat.EEEE().format(DateTime.parse(AttendenceItems[index].datetime.toString())),
                                  fontSize: width*0.04,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.secondaryTextColor
                              ),

                            ],
                          ))):
                  Card(
                      elevation:  1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              textWidget(
                                text: "₹${AttendenceItems[index].amount}",
                                fontSize: width*0.04,
                              ),
                              textWidget(
                                  text: 'Expired',
                                  fontSize: width*0.04,
                                  fontWeight: FontWeight.w600,
                              ),
                              textWidget(
                                  text: DateFormat.EEEE().format(
                                      DateTime.parse(AttendenceItems[index].datetime.toString())),
                                  fontSize: width*0.04,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.secondaryTextColor
                              ),
                            ],
                          )));
              },
            ),
            if (laststatus=="1") InkWell(
              onTap: (){
                Attendenceget(ids:lastid);
                if (kDebugMode) {
                  print(lastid);
                  print("lastid");
                 }
                },
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: height*0.20,
                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(Assets.imagesGiftsbelow),fit: BoxFit.fill)),
                  child: SizedBox(
                    width: width*0.0,
                    child: Padding(
                      padding:  EdgeInsets.only(left: width*0.30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textWidget(
                              text: "₹$lastAmount",
                              fontSize: width*0.04,
                              fontWeight: FontWeight.bold
                          ),
                          lastDay=='No data'?Container():
                          textWidget(
                              text: DateFormat.EEEE().format(DateTime.parse(lastDay.toString())),
                              fontSize: width*0.04,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryTextColor
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ) else laststatus=="2"?
            Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
                    height: height*0.20,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(Assets.imagesGiftsbelow),fit: BoxFit.fill)),
                    child: Padding(
                      padding: EdgeInsets.only(left: width*0.30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textWidget(
                            text:"₹$lastAmount",
                            fontSize: width*0.04,
                          ),
                          textWidget(
                            text: 'Redeemed',
                            fontSize: width*0.04,
                            fontWeight: FontWeight.w600,
                          ),
                          lastDay=='No data'?Container():
                          textWidget(
                              text: DateFormat.EEEE().format(
                                  DateTime.parse(lastDay.toString())),
                              fontSize: width*0.04,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryTextColor
                          ),

                        ],
                      ),
                    ))):
            Card(
                elevation:  1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: height*0.20,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration( color: Colors.grey.shade100,image: const DecorationImage(image: AssetImage(Assets.imagesGiftsbelow),fit: BoxFit.fill)),
                    child: Padding(
                      padding: EdgeInsets.only(left: width*0.30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textWidget(
                            text: "₹$lastAmount",
                            fontSize: width*0.04,
                          ),
                          textWidget(
                            text: 'Expired',
                            fontSize: width*0.04,
                            fontWeight: FontWeight.w600,

                          ),
                          lastDay=='No data'?Container():
                          textWidget(
                              text: DateFormat.EEEE().format(
                                  DateTime.parse(lastDay.toString())),
                              fontSize: width*0.04,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryTextColor
                          ),

                        ],
                      ),
                    )))
          ],
        )
    );
  }
  UserViewProvider userProvider = UserViewProvider();

  List<AttendenceModel> AttendenceItems = [];

  Future<void> AttendenceList() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(Uri.parse(ApiUrl.AttendenceList+token),);
    if (kDebugMode) {
      print(ApiUrl.AttendenceList+token);
      print('AttendenceList');
    }
    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {

        AttendenceItems = responseData.map((item) => AttendenceModel.fromJson(item)).toList();
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
        AttendenceItems = [];
      });
      throw Exception('Failed to load data');
    }
  }



///claim api
   Attendenceget( {String? ids}) async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

   final response = await http.get(Uri.parse("${ApiUrl.AttendenceGet}userid=$token&tableid=$ids"));
   print("${ApiUrl.AttendenceGet}userid=$token&tableid=$ids");

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response);
        print("response attendence get");
      }
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (kDebugMode) {
        print(responseData);
        print("responseData");
      }
      AttendenceList();
      return Fluttertoast.showToast(msg: responseData['msg']);
    } else {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return Fluttertoast.showToast(msg: responseData['msg']);
    }
  }

///container red

  var amount;
  var days;


  Future<void> attendence_days() async {
    UserViewProvider userProvider = UserViewProvider();

    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    if (kDebugMode) {
      print("ffffffffggfhff");
    }

    final url = Uri.parse(ApiUrl.attendenceDays+token);
    final response = await http.get(url,);
    if (kDebugMode) {
      print("fggggggghgggg");
      print(ApiUrl.attendenceDays+token);
      print("ApiUrl.attendenceDays+token");
    }

    if(response.statusCode==200){
      if (kDebugMode) {
        print(response.statusCode);
        print("guyguggggu");
      }
      final responseData = json.decode(response.body);
      amount = responseData["amount"]==null?"":responseData["amount"].toString();
      days = responseData["days"]==null?"":responseData["days"].toString();

    }else{
      throw Exception("load to display");
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

