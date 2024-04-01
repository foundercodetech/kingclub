import 'package:mahajong/res/aap_colors.dart';
import 'package:mahajong/res/components/app_bar.dart';
import 'package:mahajong/res/components/app_btn.dart';
import 'package:mahajong/res/components/text_widget.dart';
import 'package:mahajong/res/helper/api_helper.dart';
import 'package:mahajong/res/provider/aboutus_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';


class Aboutus extends StatefulWidget {
  const Aboutus({super.key});

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {

  @override
  void initState() {
    fetchDataAboutus();
    // TODO: implement initState
    super.initState();
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  @override
  Widget build(BuildContext context) {

    final dataabout = Provider.of<AboutusProvider>(context).aboutusData;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
      appBar: GradientAppBar(
        leading: AppBackBtn(),
          title: textWidget(
              text: 'About Us',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryGradient),
      body: dataabout!= null?Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget(dataabout.disc.toString()),
                ),

              ],
            )),


      ):Container(),
    ));
  }
  Future<void> fetchDataAboutus() async {
    try {
      final AbouttDataa = await  baseApiHelper.fetchaboutusData();
      print(AbouttDataa);
      print("AbouttDataa");
      if (AbouttDataa != null) {
        Provider.of<AboutusProvider>(context, listen: false).setUser(AbouttDataa);
      }
    } catch (error) {
      // Handle error here
    }
  }

}
