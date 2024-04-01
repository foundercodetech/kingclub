import 'dart:convert';

import 'package:mahajong/generated/assets.dart';
import 'package:mahajong/model/Mlm_Plan_model.dart';
import 'package:mahajong/model/user_model.dart';
import 'package:mahajong/res/aap_colors.dart';
import 'package:mahajong/res/api_urls.dart';
import 'package:mahajong/res/components/app_bar.dart';
import 'package:mahajong/res/components/app_btn.dart';
import 'package:mahajong/res/components/text_widget.dart';
import 'package:mahajong/res/provider/user_view_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LevelPlan extends StatefulWidget {
  const LevelPlan({super.key});

  @override
  State<LevelPlan> createState() => _LevelPlanState();
}

class _LevelPlanState extends State<LevelPlan> {



  @override
  void initState() {
    MLMPlan();
    super.initState();
  }


  int ?responseStatuscode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
          leading: AppBackBtn(),
          title: textWidget(
              text: 'Level Plan',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryGradient),
      body: ListView(
        children: [
          responseStatuscode== 400 ?
          const Notfounddata(): PlanItems.isEmpty? const Center(child: CircularProgressIndicator()):
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: PlanItems.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation:  3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      gradient: AppColors.secondaryGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        textWidget(
                            text: PlanItems[index].name.toString(),
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                        textWidget(
                            text: PlanItems[index].commission.toString()+"%",
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold

                        ),
                        textWidget(
                            text: "Commision",
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold

                        ),

                      ],
                    )

                ),
              );
            },
          ),
        ],
      ),
    );
  }
  UserViewProvider userProvider = UserViewProvider();


  ///mlm plan
  List<MlmPlanModel> PlanItems = [];

  Future<void> MLMPlan() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(Uri.parse(ApiUrl.planMlm));
    print(ApiUrl.planMlm);
    print('planMlm');

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {

        PlanItems = responseData.map((item) => MlmPlanModel.fromJson(item)).toList();
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
        PlanItems = [];
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

