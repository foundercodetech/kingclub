import 'package:mahajong/generated/assets.dart';
import 'package:mahajong/res/aap_colors.dart';
import 'package:mahajong/res/components/app_bar.dart';
import 'package:mahajong/res/components/text_widget.dart';
import 'package:mahajong/view/account/gifts.dart';
import 'package:mahajong/view/activity/attendence_bonus.dart';
import 'package:mahajong/view/home/popup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
          title: SvgPicture.asset(
            Assets.imagesAppBarSecond,
            height: 40,
          ),
          gradient: AppColors.primaryGradient),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration:
                  const BoxDecoration(gradient: AppColors.primaryGradient),
              child: ListTile(
                title: textWidget(
                    text: 'Activity',
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: AppColors.primaryTextColor),
                subtitle: textWidget(
                    text:
                        'Please remember to follow the event page\nWe will launch user feedback activities from time to time',
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppColors.primaryTextColor),
              ),
            ),
            const SizedBox(height: 09),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     itemWidget(() {}, Assets.iconsBounce, 'Invitation', 'bonus',
            //         AppColors.containerBlueGradient),
            //     itemWidget(() {}, Assets.iconsRebate, 'Betting', 'rebate',
            //         AppColors.containerYellowGradient),
            //     itemWidget(() {}, Assets.iconsSuper, 'Super', 'Jackpot',
            //         AppColors.containerGreenGradient),
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  redeemWidget(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>GiftsPage()));
                  }, Assets.imagesGiftRedeem, 'Gifts',
                      'Enter the redemption code to receive gift rewards'),
                  redeemWidget(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AttendenceBonus()));
                  }, Assets.imagesSignInBanner, 'Attendance bonus',
                      'The more consecutive days you sign in, the higher the reward will be.'),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget itemWidget(Function()? onTap, String image, String title, String subTitle, Gradient? gradient) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 75,
            width: 75,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadiusDirectional.circular(15),
            ),
            child: SvgPicture.asset(image),
          ),
          const SizedBox(height: 10),
          textWidget(
              text: title,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.secondaryTextColor),
          textWidget(
              text: subTitle,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.secondaryTextColor),
        ],
      ),
    );
  }

  Widget redeemWidget(Function()? onTap, String image, String title, String subTitle)                                  {
    final heights=MediaQuery.of(context).size.height;
    final widths=MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: heights*0.15,
            width: widths*0.45,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(image),fit: BoxFit.fill),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: textWidget(
                text: title,
                fontWeight: FontWeight.w600,
                fontSize: 18,
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              width: widths*0.4,
              child: textWidget(
                  text: subTitle,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: AppColors.secondaryTextColor),
            ),
          ),
        ],
      ),
    );
  }
}
