import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart'as http;
import 'package:mahajong/res/api_urls.dart';
import 'package:mahajong/view/home/casino/Plinko/Plinko_Constant/random_color.dart';
import 'package:mahajong/view/home/casino/Plinko/Plinko_model/green_list_model.dart';


class LastTwelveResult extends StatefulWidget {
  const LastTwelveResult({super.key});

  @override
  State<LastTwelveResult> createState() => _LastTwelveResultState();
}

class _LastTwelveResultState extends State<LastTwelveResult> {

  bool isExpend = false;
  @override
  void initState() {
    lastData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ExpansionTile(

      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      title: isExpend
          ? const Center(child: Text("Round History", style: TextStyle(fontSize: 12, color: Colors.white)))
          :Row(
            children: [
              SizedBox(
        height: height*0.03,
        width: width*0.20,
        child: ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index){
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        gradient: Constants.greenGradient.gradient,
                      ),
                      child: Text(greenList[index].multiplier.toString(),style: const TextStyle(fontSize: 10,color:Colors.white),),

                    ),
                  );
                }),
      ),
              SizedBox(
                height: height*0.03,
                width: width*0.20,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index){
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            gradient: Constants.redGradient.gradient,
                          ),
                          child: Text(redList[index].multiplier.toString(),style: const TextStyle(fontSize: 10,color:Colors.white),),

                        ),
                      );
                    }),
              ),
            ],
          ),
      onExpansionChanged: (value) {
        // Update the isExpanded variable when the ExpansionTile state changes
        setState(() {
          isExpend = value;
        });
      },
      trailing: Container(
        alignment: Alignment.center,
        height: height * 0.035,
        width: width * 0.12,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.4),
          border: Border.all(color: Colors.grey.withOpacity(0.8)),
          borderRadius: const BorderRadius.all(Radius.circular(25)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Align icons in the center
          children: [
            const Icon(Icons.history, size: 16, color: Colors.white,),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Icon(
                isExpend
                    ? Icons.arrow_drop_up_rounded
                    : Icons.arrow_drop_down_rounded,
                size: 28,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),

      children: [
        Container(
          height: height*0.03,
          width: width,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount:greenList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index){
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: Constants.greenGradient.gradient,
                    ),
                    child: Text(greenList[index].multiplier.toString(),style: const TextStyle(fontSize: 10,color:Colors.white),),

                  ),
                );
              }),
        ),
        Container(
          height: height*0.03,
          width: width,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: redList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index){
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: Constants.redGradient.gradient,
                    ),
                    child: Text(redList[index].multiplier.toString(),style: const TextStyle(fontSize: 10,color:Colors.white),),

                  ),
                );
              }),
        ),
      ],
    );
  }


  List<GreenListModel> greenList = [];
  List<GreenListModel> redList = [];
  Future<void> lastData() async {
    const url = ApiUrl.lastResult; // Assuming ApiUrl is defined somewhere
    try {
      final response = await http.get(Uri.parse(url));

      if (kDebugMode) {
        print(url);
      }
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        setState(() {
          greenList = (responseData['green'] as List<dynamic>)
              .map((item) => GreenListModel.fromJson(item))
              .toList();

          redList = (responseData['red'] as List<dynamic>)
              .map((item) => GreenListModel.fromJson(item))
              .toList();
        });
      } else if (response.statusCode == 400) {
        if (kDebugMode) {
          print('Data not found');
        }
      } else {
        setState(() {
          greenList = [];
          redList = [];
        });
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle exceptions if any
      print('Error: $e');
      setState(() {
        greenList = [];
        redList = [];
      });
    }
  }

}
