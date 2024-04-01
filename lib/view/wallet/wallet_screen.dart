import 'package:mahajong/generated/assets.dart';
import 'package:mahajong/res/aap_colors.dart';
import 'package:mahajong/res/components/app_bar.dart';
import 'package:mahajong/res/components/app_btn.dart';
import 'package:mahajong/res/components/text_widget.dart';
import 'package:mahajong/res/helper/api_helper.dart';
import 'package:mahajong/utils/routes/routes_name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mahajong/view/wallet/wallet_history.dart';
import 'package:provider/provider.dart';

import '../../res/provider/wallet_provider.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  BaseApiHelper baseApiHelper = BaseApiHelper();

  @override
  void initState() {
    walletfetch();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final userData = Provider.of<ProfileProvider>(context).userData;
    //
    final walletdetails = Provider.of<WalletProvider>(context).walletlist;

    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: GradientAppBar(
          title: textWidget(
              text: 'Wallet', fontSize: 25, color: AppColors.primaryTextColor),
          gradient: AppColors.primaryGradient),
      body: walletdetails != null
          ? Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      height: 135,
                      width: widths,
                      decoration: const BoxDecoration(
                          gradient: AppColors.primaryGradient),
                      child: Column(
                        children: [
                          SvgPicture.asset(Assets.iconsWallets),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.currency_rupee,
                                  size: 20, color: AppColors.iconSecondColor),
                              textWidget(
                                  // text: walletdetails.wallet.toString(),
                                  text: double.parse(walletdetails.wallet.toString()).toStringAsFixed(2),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: AppColors.primaryTextColor),
                            ],
                          ),
                          textWidget(
                            text: 'Total Balance',
                            color: AppColors.primaryTextColor,
                            fontSize: 14,
                          ),
                          const SizedBox(height: 40)
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                    top: heights * 0.12,
                    child: Container(
                      height: heights * 0.45,
                      width: widths * 0.95,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 35, 15, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const WalletHistory(
                                                name: "Winning Wallet",
                                                type: "1")));
                                  },
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                      height: heights * 0.10,
                                      width: widths * 0.25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          textWidget(
                                            text: "Winning Wallet",
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textWidget(
                                            // text: "₹ " + walletdetails.winning_wallet.toString(),
                                            text: "₹"+double.parse(walletdetails.winning_wallet.toString()).toStringAsFixed(2),
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const WalletHistory(
                                                name: "Bonus",
                                                type: "3")));
                                  },
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Container(
                                      height: heights * 0.10,
                                      width: widths * 0.25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          textWidget(
                                            text: "Bonus",
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textWidget(
                                            // text: "₹ " + walletdetails.bonus.toString(),
                                            text:"₹"+double.parse(walletdetails.bonus.toString()).toStringAsFixed(2),
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const WalletHistory(
                                                name: "Commission",
                                                type: "2")));
                                  },
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Container(
                                      height: heights * 0.10,
                                      width: widths * 0.25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          textWidget(
                                            text: "Commission",
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textWidget(
                                            // text: "₹ " + walletdetails.commission.toString(),
                                            text:"₹"+double.parse(walletdetails.commission.toString()).toStringAsFixed(2),
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // percentage(walletdetails.wallet.toString(), "", 'Main wallet'),
                                // percentage( walletdetails.commission.toString(),"", 'Bonus'),
                              ],
                            ),
                            const SizedBox(height: 20),
                            AppBtn(
                              gradient: AppColors.primaryGradient,
                              hideBorder: true,
                              title: 'Main wallet transfer',
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              onTap: () {},
                            ),
                            const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                itemWidget(() {
                                  Navigator.pushNamed(
                                      context, RoutesName.depositScreen);
                                }, Assets.iconsProDeposit, 'Deposit'),
                                itemWidget(() {
                                  Navigator.pushNamed(
                                      context, RoutesName.withdrawScreen);
                                }, Assets.iconsProWithdraw, 'Withdraw'),
                                // itemWidget(() {
                                //   Navigator.pushNamed(context, RoutesName.depositHistory);
                                // }, Assets.iconsDepositHistory, 'Deposit\n history'),
                                // itemWidget(() {
                                //   Navigator.pushNamed(context, RoutesName.withdrawalHistory);
                                // }, Assets.iconsWithdrawHistory, 'Withdrawal\n     history'),
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
              ],
            )
          : Container(),
    );
  }

  Future<void> walletfetch() async {
    try {
      if (kDebugMode) {
        print("qwerfghj");
      }
      final wallet_data = await baseApiHelper.fetchWalletData();
      if (kDebugMode) {
        print(wallet_data);
        print("wallet_data");
      }
      Provider.of<WalletProvider>(context, listen: false)
          .setWalletList(wallet_data!);
    } catch (error) {
      // Handle error here
      if (kDebugMode) {
        print("hiiii $error");
      }
    }
  }

  // Widget percentage(String percentData, String amount, String title) {
  //   return Column(
  //     children: [
  //       CircleAvatar(
  //         radius: 55,
  //         backgroundColor: AppColors.circleBorderColor,
  //         child: CircleAvatar(
  //           radius: 48,
  //           backgroundColor: AppColors.primaryContColor,
  //           child: textWidget(
  //               text: percentData, fontSize: 20, fontWeight: FontWeight.w600),
  //         ),
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           const Icon(Icons.currency_rupee, size: 16, color: AppColors.iconColor),
  //           textWidget(
  //               text: amount,
  //               fontWeight: FontWeight.w600,
  //               fontSize: 16,
  //               color: AppColors.secondaryTextColor),
  //         ],
  //       ),
  //       textWidget(
  //           text: title,
  //           fontWeight: FontWeight.w400,
  //           fontSize: 16,
  //           color: AppColors.secondaryTextColor),
  //     ],
  //   );
  // }

  Widget itemWidget(Function()? onTap, String image, String title) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SvgPicture.asset(image, height: 50),
          const SizedBox(height: 10),
          textWidget(
              text: title,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.secondaryTextColor),
        ],
      ),
    );
  }
}
