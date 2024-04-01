import 'package:mahajong/res/aap_colors.dart';
import 'package:mahajong/res/components/app_bar.dart';
import 'package:mahajong/res/components/text_widget.dart';
import 'package:mahajong/res/helper/api_helper.dart';
import 'package:mahajong/res/provider/Beginner_provider.dart';
import 'package:mahajong/res/provider/Howtoplay_Provider.dart';
import 'package:mahajong/res/provider/aboutus_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';


class BeginnersGuideScreen extends StatefulWidget {
  const BeginnersGuideScreen({super.key});

  @override
  State<BeginnersGuideScreen> createState() => _BeginnersGuideScreenState();
}

class _BeginnersGuideScreenState extends State<BeginnersGuideScreen> {

  @override
  void initState() {
    fetchbegin();
    // TODO: implement initState
    super.initState();
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  @override
  Widget build(BuildContext context) {

    final DataBeginnerGuide = Provider.of<BeginnerProvider>(context).BeginnerData;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
      appBar: GradientAppBar(
          title: textWidget(
              text: 'Beginner Guide',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryGradient),
      body: DataBeginnerGuide!= null?Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget(DataBeginnerGuide.disc.toString()),
                ),

              ],
            )),


      ):Container(),
    ));
  }
  Future<void> fetchbegin() async {
    try {
      final DataBegin = await  baseApiHelper.fetchBeginnerData();
      print(DataBegin);
      print("DataBegin");
      if (DataBegin != null) {
        Provider.of<BeginnerProvider>(context, listen: false).setbeginner(DataBegin);
      }
    } catch (error) {
      // Handle error here
    }
  }

}
