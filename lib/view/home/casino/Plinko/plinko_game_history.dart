import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mahajong/generated/assets.dart';
import 'package:mahajong/model/user_model.dart';
import 'package:mahajong/res/aap_colors.dart';
import 'package:mahajong/res/api_urls.dart';
import 'package:mahajong/res/components/text_widget.dart';
import 'package:mahajong/res/provider/user_view_provider.dart';
import 'package:mahajong/view/home/casino/Plinko/Plinko_model/plinkohistorymodel.dart';
import 'package:http/http.dart' as http;


class PlinkoGameHistory extends StatefulWidget {
  const PlinkoGameHistory({super.key});

  @override
  State<PlinkoGameHistory> createState() => _PlinkoGameHistoryState();
}

class _PlinkoGameHistoryState extends State<PlinkoGameHistory> {

  int ?responseStatuscode;

  @override
  void initState() {
    PlinkoGameHistory();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final widths = MediaQuery.of(context).size.width;
    final heights = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(Assets.iconsArrowBack)),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red,
          centerTitle: true,
          title: textWidget(text: "Game History",fontSize: 18,color: Colors.white)

      ),
      body:
      responseStatuscode== 400 ?
      const Notfounddata(): items.isEmpty? const Center(child: CircularProgressIndicator()):
      ListView.builder(
        shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context,index){
        return  Card(
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
                      Text("Bet"
                        ,style: TextStyle(fontSize: widths*0.034,fontWeight: FontWeight.w800,
                            color: AppColors.secondaryTextColor),),
                      Text(items[index].bet.toString(),
                        maxLines: 1,
                        style: TextStyle(fontSize: widths*0.034,fontWeight: FontWeight.w800,
                            color: items[index].bet=="Green"?Colors.green:Colors.red
                        ),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Amount",style: TextStyle(fontSize: widths*0.034,fontWeight: FontWeight.w800,
                          color: AppColors.secondaryTextColor),),
                      Text("₹"+items[index].amount.toString(),style: TextStyle(fontSize: widths*0.034,fontWeight: FontWeight.w800,
                          color: AppColors.secondaryTextColor),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Status",style: TextStyle(fontSize: widths*0.034,fontWeight: FontWeight.w800,
                          color: AppColors.secondaryTextColor),),
                      Text(items[index].status==0?"Loss":"Win",style: TextStyle(fontSize: widths*0.034,fontWeight: FontWeight.w800,
                          color: Colors.red
                      ),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Date",style: TextStyle(fontSize: widths*0.034,fontWeight: FontWeight.w800,
                          color: AppColors.secondaryTextColor),),
                      Text(items[index].datetime==null?'not added':DateFormat("E, dd-MMM-yyyy, H:mm a").format(
                          DateTime.parse(items[index].datetime.toString())),
                          style: TextStyle(fontSize: widths*0.034,fontWeight: FontWeight.w800,
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
  UserViewProvider userProvider = UserViewProvider();

  List<PlinkoGameHistoryModel> items = [];

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
        items = responseData.map((item) => PlinkoGameHistoryModel.fromJson(item)).toList();
      });
      print(items);

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



// Text('Green',style: TextStyle(fontSize: 16,color: Colors.green),),

//  Text('12/01/2024:12:00:03'),