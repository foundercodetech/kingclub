import 'package:mahajong/generated/assets.dart';
import 'package:mahajong/res/aap_colors.dart';
import 'package:mahajong/res/components/text_widget.dart';
import 'package:mahajong/res/provider/services/splash_service.dart';
import 'package:mahajong/view/home/popup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    // Future.delayed(Duration(seconds: 5), () {
    //   showDialog(context: context, builder: (context)=>OffersScreen());
    // });
    super.initState();
    splashServices.checkAuthentication(context);

  }



  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      height: heights,
      width: widths,
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.imagesSplashImage, height: 300),
          const SizedBox(height: 20),
          textWidget(
              text: 'Withdraw fast, safe and stable',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryTextColor),
          const SizedBox(height: 5),
          textWidget(
              text: 'Quick withdraw',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryTextColor),
          const SizedBox(height: 50),
          SvgPicture.asset(Assets.imagesAppBarSecond, height: 50)
        ],
      ),
    ));
  }
}
