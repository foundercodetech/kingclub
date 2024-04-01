import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:mahajong/generated/assets.dart';
import 'package:mahajong/res/aap_colors.dart';
import 'package:mahajong/res/components/app_bar.dart';
import 'package:mahajong/res/components/app_btn.dart';
import 'package:mahajong/res/components/text_field.dart';
import 'package:mahajong/res/components/text_widget.dart';
import 'package:mahajong/res/provider/auth_provider.dart';
import 'package:mahajong/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  bool selectedButton = true;
  bool hidePassword = true;
  bool rememberPass = false;
  // bool activeButton = true;
  TextEditingController phoneCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  TextEditingController passwordConn = TextEditingController();


  /// Check internet
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  /// Check internet  with initState Code

  @override
  void initState() {
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<UserAuthProvider>(context);

    final width = MediaQuery.of(context).size.width;

    return
      Scaffold(
          appBar: GradientAppBar(
          title: SvgPicture.asset(Assets.imagesAppBarSecond, height: 40),
          leading: const AppBackBtn(),
          gradient: AppColors.primaryGradient),
        body:
        _connectionStatus == ConnectivityResult.none
            ?Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image(
                image: const AssetImage(Assets.imagesNoDataAvailable),
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 2,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: Text('There is no Internet connection'),
            ),
            const Padding(
              padding: EdgeInsets.all(4.0),
              child:
              Text('Please check your Internet connection'),
            ),
          ],
        ):ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    decoration:
                    const BoxDecoration(gradient: AppColors.primaryGradient),
                    child: ListTile(
                      title: textWidget(
                          text: 'Log in',
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          color: AppColors.primaryTextColor),
                      subtitle: textWidget(
                          text: 'Please log in with your phone number or email\nIf you forget your password, please contact customer service',
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: AppColors.primaryTextColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(Assets.iconsPhoneTabColor),
                          SizedBox(width:width*0.01),
                          textWidget(
                              text: 'Log in with phone',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color:AppColors.gradientFirstColor
                          )
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Divider(thickness: 0.7, color: AppColors.dividerColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                    child: Row(
                      children: [
                        SvgPicture.asset(Assets.iconsPhone),
                        const SizedBox(width: 20),
                        textWidget(
                            text:  'Phone Number' ,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: AppColors.secondaryTextColor)
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child:
                      Row(
                        children: [
                          const SizedBox(
                            width: 100,
                            child: CustomTextField(
                              enabled: false,
                              hintText: '+91',
                              suffixIcon: RotatedBox(
                                  quarterTurns: 45,
                                  child: Icon(Icons.arrow_forward_ios_outlined,
                                      size: 20)),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                              child: CustomTextField(
                                onChanged: (value) {
                                  if (phoneCon.text.length == 10) {
                                    // setState(() {
                                    //   activeButton = !activeButton;
                                    // });
                                  }
                                },
                                keyboardType: TextInputType.number,
                                controller: phoneCon,
                                maxLength: 10,
                                hintText: 'Please enter the phone number',
                              )),
                        ],
                      )

                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                    child: Row(
                      children: [
                        SvgPicture.asset(Assets.iconsPassword),
                        const SizedBox(width: 20),
                        textWidget(
                            text: 'Password',
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: AppColors.secondaryTextColor)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                    child: CustomTextField(
                      obscureText: hidePassword,
                      controller: passwordCon,
                      maxLines: 1,
                      hintText: 'Please enterPassword',
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: SvgPicture.asset(hidePassword
                              ? Assets.iconsEyeClose
                              : Assets.iconsEyeOpen)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              rememberPass = !rememberPass;
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            decoration: rememberPass ?BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage(
                                      Assets.iconsCorrect)),
                              border: Border.all(
                                  color: Colors.transparent
                              ),
                              borderRadius: BorderRadiusDirectional.circular(50),
                            ):BoxDecoration(
                              border: Border.all(
                                  color: AppColors.secondaryTextColor),
                              borderRadius: BorderRadiusDirectional.circular(50),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        textWidget(text: 'Remember password', fontSize: 14),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                    child: AppBtn(
                        title: 'Log in',
                        fontSize: 20,
                        onTap: () {
                          // if (selectedButton==true) {
                          //   print("object");
                          //   authProvider.userLogin(context, phoneCon.text, passwordCon.text);
                          // } else {
                          //   authProvider.userLogin(context, emailCon.text, passwordCon.text);
                          // }

                          authProvider.userLogin(context, phoneCon.text, passwordCon.text);

                        },
                        hideBorder: true,
                        gradient: AppColors.primaryGradient

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                    child: AppBtn(
                      title: 'R e g i s t e r',
                      fontSize: 20,
                      titleColor: AppColors.gradientFirstColor,
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.registerScreen,arguments: '1');
                      },
                      gradient: AppColors.secondaryGradient,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _launchEmail();
                          },
                          child: Column(
                            children: [
                              SvgPicture.asset(Assets.iconsPassword, height: 60),
                              textWidget(
                                  text: 'Forgot password',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: AppColors.secondaryTextColor)
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              SvgPicture.asset(Assets.iconsCustomer, height: 60),
                              textWidget(
                                  text: 'Customer Service',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: AppColors.secondaryTextColor)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
  String email="techmahajong@gmail.com";
  _launchEmail() async {
    if (await canLaunch("mailto:$email")) {
      await launch("mailto:$email");
    } else {
      throw 'Could not launch';
    }
  }



}

