import 'dart:convert';

import 'package:mahajong/generated/assets.dart';
import 'package:mahajong/res/aap_colors.dart';
import 'package:mahajong/res/components/app_bar.dart';
import 'package:mahajong/res/components/app_btn.dart';
import 'package:mahajong/res/components/text_widget.dart';
import 'package:flutter/material.dart';



class LevelScreen extends StatefulWidget {
  String?Name;
  final data;
   LevelScreen({ this.Name, this.data});

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {

  @override
  void initState() {
    level();
    // TODO: implement initState
    super.initState();
  }
  List<LevelModel> levelList = [];
  level(){
    print(widget.data[widget.Name]);
    if(widget.Name!=null){
    if(widget.data!=null) {
      for (var data in widget.data[widget.Name]) {
        levelList.add(LevelModel(level: data['username'].toString(),
            user: data['turnover'].toString(),
            commission: data['commission'].toString()));
      }
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    // List<LevelModel> levelList = [
    //   LevelModel(level: 'Raghav', user: '07/01/2024', commission: '20'),
    //   LevelModel(level: 'Rohit', user: '07/01/2024', commission: '250'),
    //   LevelModel(level: 'Dhruv', user: '07/01/2024', commission: '250'),
    // ];
    return Scaffold(
      appBar: GradientAppBar(
          leading:const AppBackBtn(),
          title: textWidget(
              text: widget.Name.toString(), fontSize: 25, color: AppColors.primaryTextColor),
          gradient: AppColors.primaryGradient),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Stack(
              children: [
                Container(
                  height: heights * 0.2,
                  width: widths,
                  decoration: const BoxDecoration(
                      color: AppColors.containerBgColor,
                      image: DecorationImage(
                          image: AssetImage(Assets.imagesContainerBg),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      )),
                  child:
                  Column(
                    children: [
                      const SizedBox(height: 50,),
                      textWidget(
                          text: 'Subscriber and Commission',
                          fontSize: 20,
                          color: AppColors.primaryTextColor
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Container(
                    // height: heights * 0.70,
                    width: widths * 0.94,
                    decoration: BoxDecoration(
                        color: AppColors.primaryTextColor,
                        borderRadius:
                        BorderRadiusDirectional.circular(15)),
                    child: Column(
                      children: [
                        SizedBox(height: heights*0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            textWidget(text: 'Username',fontWeight: FontWeight.w800,
                              fontSize: 14,),
                            textWidget(text: 'Turnover',fontWeight: FontWeight.w800,
                              fontSize: 14,),
                            textWidget(text: 'Commission',fontWeight: FontWeight.w800,
                              fontSize: 14,),
                          ],
                        ),
                        SizedBox(height: heights*0.01,),
                        levelList.isEmpty?Container():  ListView.builder(
                            shrinkWrap: true,
                            itemCount: levelList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                height: 45,
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryContColor,
                                ),
                                child: Card(
                                  elevation: 1,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: 80,
                                        child: textWidget(
                                          text: levelList[index].level,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 80,
                                        child: textWidget(
                                          text: levelList[index].user,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 80,
                                        child: textWidget(
                                          text: levelList[index].commission,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

}

class LevelModel {
  final String level;
  final String user;
  final String commission;

  LevelModel({
    required this.level,
    required this.user,
    required this.commission,
  });
}