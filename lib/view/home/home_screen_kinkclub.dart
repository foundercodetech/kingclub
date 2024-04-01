// ignore_for_file: depend_on_referenced_packages, deprecated_member_use, prefer_typing_uninitialized_variables
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:mahajong/generated/assets.dart';
import 'package:mahajong/res/api_urls.dart';
import 'package:mahajong/res/helper/api_helper.dart';
import 'package:mahajong/view/home/notification.dart';
import 'package:mahajong/view/home/widgets/category_elements.dart';
import 'package:mahajong/view/home/widgets/category_widgets.dart';
import 'package:mahajong/view/home/widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  @override
  void initState() {
    versionCheck();
    // TODO: implement initState
    super.initState();
  }
  BaseApiHelper baseApiHelper = BaseApiHelper();
  int selectedCategoryIndex = 0;

  bool verssionview = false;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () => showAlert(context));
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        title: SvgPicture.asset(Assets.imagesAppBarSecond,height: 36),
        actions: [
          InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const NotificationScreen()));
              },
              child: SvgPicture.asset(Assets.iconsMsg)),

        ],
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              const SliderWidget(),
              CategoryWidget(
                onCategorySelected: (index) {
                  setState(() {
                    selectedCategoryIndex = index;
                  });
                },
              ),
              CategoryElement(selectedCategoryIndex: selectedCategoryIndex),
            ],
          ),
        ),
      ),
    );
  }

  void showAlert(BuildContext context) {
    verssionview == true
        ? showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          content: SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 80,
                  height: 100,
                  child: Image(image: AssetImage(Assets.imagesLogomahajong)),
                ),
                const Text('new version are available',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
                Text(
                    'Update your app  ${ApiUrl.version}  to  $map',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: (){
              _launchURL();
              if (kDebugMode) {
                print(versionlink);
                print("versionlink");
              }
            }, child: const Text("UPDATE"))

          ],
        ))
        : Container();
  }

  var map;
  var versionlink;

  Future<void> versionCheck() async {
    final response = await http.get(
      Uri.parse(ApiUrl.versionlink),
    );
    if (kDebugMode) {
      print(jsonDecode(response.body));
    }
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (kDebugMode) {
        print(responseData);
        print('rrrrrrrr');
      }
      if (responseData['version'] != ApiUrl.version) {
        setState(() {
          map = responseData['version'];
          versionlink = responseData['link'];
          verssionview=true;
        });
      } else {
        if (kDebugMode) {
          print('Version is up-to-date');
        }
      }
    } else {
      if (kDebugMode) {
        print('Failed to fetch version data');
      }
    }
  }
  _launchURL() async {
    var url = versionlink.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


}