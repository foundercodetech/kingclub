import 'dart:convert';

import 'package:mahajong/generated/assets.dart';
import 'package:mahajong/model/notification_model.dart';
import 'package:mahajong/res/aap_colors.dart';
import 'package:mahajong/res/components/app_btn.dart';
import 'package:mahajong/res/components/text_widget.dart';
import 'package:mahajong/res/helper/api_helper.dart';
import 'package:mahajong/res/provider/notification_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

import '../../res/api_urls.dart';
import '../../res/components/app_bar.dart';
import 'package:http/http.dart' as http;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  
  @override
  void initState() {
    notificationn();
    // TODO: implement initState
    super.initState();
  }

  int ?responseStatuscode;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: GradientAppBar(
        leading: AppBackBtn(),
          title: textWidget(
              text: 'Notification',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryGradient),
      body:ListView(
        shrinkWrap: true,
        children: [
          SizedBox(height: 10),
          responseStatuscode== 400 ?
          const Notfounddata(): items.isEmpty? const Center(child: CircularProgressIndicator()):
          ListView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext, int index){
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textWidget(text: items[index].name.toString(), fontSize: 18,),
                            Image.network(items[index].image.toString(),height: 30,width: 30,),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: HtmlWidget(items[index].disc.toString()),
                        ),

                      ],
                    ),
                  ),
                );

          }),

        ],
      )
    );
  }

  List<NotificationModel> items = [];

  Future<void> notificationn() async {

    final response = await http.get(Uri.parse(ApiUrl.notificationapi),);
    print(ApiUrl.notificationapi);
    print('notificationapi');

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {

        items = responseData.map((item) => NotificationModel.fromJson(item)).toList();
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
        items = [];
      });
      throw Exception('Failed to load data');
    }
  }




// Future<void> fetchnotification() async {
  //   try {
  //     final Notifydata = await  baseApiHelper.fetchNotificationData();
  //     print(Notifydata);
  //     print("Notifydata");
  //     if (Notifydata != null) {
  //       Provider.of<NotificationProvider>(context, listen: false).setnotification(Notifydata);
  //     }
  //   } catch (error) {
  //     // Handle error here
  //   }
  // }
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

