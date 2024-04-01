import 'package:mahajong/generated/assets.dart';
import 'package:mahajong/res/aap_colors.dart';
import 'package:mahajong/res/components/app_bar.dart';
import 'package:mahajong/res/components/app_btn.dart';
import 'package:mahajong/res/components/text_widget.dart';
import 'package:mahajong/res/helper/api_helper.dart';
import 'package:mahajong/res/provider/contactus_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  @override
  void initState() {
    fetchcontact();
    // TODO: implement initState
    super.initState();
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  @override
  Widget build(BuildContext context) {

    final contactusData = Provider.of<ContactUsProvider>(context).ContactusData;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
      appBar: GradientAppBar(
          leading: const AppBackBtn(),
          title: textWidget(
              text: 'Contact Us',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryGradient),
      body: contactusData!= null?Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: height*0.50,
              width: 300,
              decoration: BoxDecoration(

                  image: DecorationImage(image: NetworkImage(contactusData.image.toString()),fit: BoxFit.cover)),
            ),
          ),

         TextButton(onPressed: () async {
           final String groupLink =  contactusData.image.toString(); // Replace with your Telegram group link

           if (await canLaunch(groupLink)) {
           await launch(groupLink);
           } else {
           throw "Could not launch $groupLink";
           }
         }, child: Text('Teligram Link'))

        ],
      ):Column(
        children: [
          Center(
            child: Image(
              image: const AssetImage(Assets.imagesNoDataAvailable),
              height: height / 3,
              width: width / 2,
            ),
          ),
          SizedBox(height: height*0.04),
          const Text("Data not found",)
        ],
      ),
    ));
  }
  Future<void> fetchcontact() async {
    try {
      final Datacontact = await  baseApiHelper.fetchdataCU();
      print(Datacontact);
      print("Datacontact");
      if (Datacontact != null) {
        Provider.of<ContactUsProvider>(context, listen: false).setCu(Datacontact);
      }
    } catch (error) {
      // Handle error here
    }
  }


  void openteligram() async {

  }

}
