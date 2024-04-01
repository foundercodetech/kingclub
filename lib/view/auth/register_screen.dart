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
import 'package:mahajong/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../res/components/rich_text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool hideSetPassword = true;
  bool hideConfirmPassword = true;
  bool readAndAgreePolicy = false;

  String phoneNumber = '';
  bool showContainer = false;
  bool show = false;



  TextEditingController phoneCon = TextEditingController();
  TextEditingController otp = TextEditingController();
  TextEditingController setPasswordCon = TextEditingController();
  TextEditingController confirmPasswordCon = TextEditingController();
  // TextEditingController refercodee = TextEditingController(text:"971752563938");
  TextEditingController refercodee = TextEditingController();
  TextEditingController emailCon = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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

    String argument = ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
      appBar: GradientAppBar(
          title: SvgPicture.asset(
            Assets.imagesAppBarSecond,
            height: 40,
          ),
          leading: argument == '0' ? Container() : const AppBackBtn(),
          gradient: AppColors.primaryGradient),
      body:  _connectionStatus == ConnectivityResult.none
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
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  decoration:
                      const BoxDecoration(gradient: AppColors.primaryGradient),
                  child: ListTile(
                    title: textWidget(
                        text: 'Register',
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        color: AppColors.primaryTextColor),
                    subtitle: textWidget(
                        text: 'Please register by phone number or email',
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppColors.primaryTextColor),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Assets.iconsPhoneTabColor,
                      height: 28,
                    ),
                    const SizedBox(width: 2),
                    textWidget(
                        text: 'Register your phone',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColors.gradientFirstColor)
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Divider(thickness: 0.7, color: AppColors.dividerColor),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Assets.iconsInvitionCode,
                        height: 30,
                      ),
                      const SizedBox(width: 20),
                      textWidget(
                          text: 'Enter Referral Code',
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: AppColors.secondaryTextColor)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: CustomTextField(
                    controller: refercodee,
                    maxLines: 1,
                    hintText: 'Please Enter Referral code',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Assets.iconsPhone,
                        height: 30,
                      ),
                      const SizedBox(width: 20),
                      textWidget(
                          text: 'Phone Number',
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: AppColors.secondaryTextColor)
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Row(
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
                              keyboardType: TextInputType.phone,
                          controller: phoneCon,
                          maxLength: 10,
                          hintText: 'Please enter the phone number',
                        )),
                      ],
                    )),
                // if (showContainer==true)
                //   Column(
                //     children: [
                //       Padding(
                //           padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                //           child: Row(
                //             children: [
                //               Icon(
                //                 Icons.verified_user,
                //                 color: Colors.red,
                //               ),
                //               const SizedBox(width: 20),
                //               textWidget(
                //                   text: 'OTP',
                //                   fontWeight: FontWeight.w400,
                //                   fontSize: 18,
                //                   color: AppColors.secondaryTextColor)
                //             ],
                //           )),
                //       Padding(
                //         padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                //         child: CustomTextField(
                //           controller: otp,
                //           prefixIcon: const Icon(
                //             Icons.verified_user,
                //             color: Colors.red,
                //           ),
                //           maxLines: 1,
                //           hintText: 'Verification code',
                //           onChanged: (v) async {
                //             if(v.length==4){
                //               otpMatch(otp.text,phoneCon.text);
                //
                //             }else{
                //               print("not done");
                //             }
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                //
                // SizedBox(height: 10,),
                // if (showContainer==false)
                // CustomButton(
                //   onTap: () {
                //     setState(() {
                //       showContainer = phoneCon.text.isNotEmpty;
                //
                //     });
                //     otpurl(phoneCon.text);
                //   //  otpMatch(myControllers.map((e) => e.text).join(),phoneCon.text);
                //   },
                //   text: 'Send OTP',
                //   textColor: Colors.white,
                // ),
                // // CustomButton(
                // //   onTap: () {
                // //    // otpurl(phoneCon.text);
                // //       otpMatch(myControllers.map((e) => e.text).join(),phoneCon.text);
                // //   },
                // //   text: 'match OTP',
                // //   textColor: Colors.white,
                // // ),


                  // if(show==true)
                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          children: [
                            SvgPicture.asset(Assets.iconsEmailTabColor,height: 30,),
                            const SizedBox(width: 20),
                            textWidget(
                                text: 'Email',
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: AppColors.secondaryTextColor)
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: CustomTextField(

                        onChanged: (value) {
                          if (emailCon.text.isNotEmpty) {}
                        },
                        controller: emailCon,
                        maxLines: 1,
                        hintText: 'please input your email',
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.iconsPassword,
                            height: 30,
                          ),
                          const SizedBox(width: 20),
                          textWidget(
                              text: 'Set password',
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: AppColors.secondaryTextColor)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: CustomTextField(
                        obscureText: hideSetPassword,
                        controller: setPasswordCon,
                        maxLines: 1,
                        hintText: 'Please enterSet password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hideSetPassword = !hideSetPassword;
                              });
                            },
                            icon: SvgPicture.asset(hideSetPassword
                                ? Assets.iconsEyeClose
                                : Assets.iconsEyeOpen)),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.iconsPassword,
                            height: 30,
                          ),
                          const SizedBox(width: 20),
                          textWidget(
                              text: 'Confirm password',
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: AppColors.secondaryTextColor)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: CustomTextField(
                        // validator: (value) {
                        //   if (confirmPasswordCon.text.isEmpty) {
                        //     return 'Please enter your password';
                        //   }
                        //   return null;
                        // },
                        obscureText: hideConfirmPassword,
                        controller: confirmPasswordCon,
                        maxLines: 1,
                        hintText: 'Please EnterConfirm password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hideConfirmPassword = !hideConfirmPassword;
                              });
                            },
                            icon: SvgPicture.asset(hideConfirmPassword
                                ? Assets.iconsEyeClose
                                : Assets.iconsEyeOpen)),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                readAndAgreePolicy = !readAndAgreePolicy;
                              });
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              alignment: Alignment.center,
                              decoration: readAndAgreePolicy
                                  ? BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage(Assets.iconsCorrect)),
                                border: Border.all(
                                    color: AppColors.secondaryTextColor),
                                borderRadius:
                                BorderRadiusDirectional.circular(50),
                              )
                                  : BoxDecoration(
                                border: Border.all(
                                    color: AppColors.secondaryTextColor),
                                borderRadius:
                                BorderRadiusDirectional.circular(50),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          CustomRichText(
                            textSpans: [
                              CustomTextSpan(
                                text: "I have read and agree",
                                textColor: Colors.black,
                                fontSize: 13,
                                spanTap: () {
                                  setState(() {
                                    readAndAgreePolicy = !readAndAgreePolicy;
                                  });
                                },
                              ),
                              CustomTextSpan(
                                text: "【Privacy Agreement】",
                                textColor: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                spanTap: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: AppBtn(
                          title: 'Register',
                          fontSize: 20,
                          loading: authProvider.regLoading,
                          onTap: () {

                            if(phoneCon.text.isEmpty || phoneCon.text.length!=10){
                              Utils.flushBarSuccessMessage("Enter phone number", context, Colors.red);
                            }else if(setPasswordCon.text.isEmpty){
                              Utils.flushBarSuccessMessage("Set your password", context, Colors.red);
                            } else if(confirmPasswordCon.text.isEmpty){
                              Utils.flushBarSuccessMessage("Confirm your password", context, Colors.red);
                            } else if(emailCon.text.isEmpty){
                              Utils.flushBarSuccessMessage("Confirm your email", context, Colors.red);
                            }
                            else {
                              authProvider.userRegister(
                                  context,
                                  phoneCon.text,
                                  setPasswordCon.text,
                                  confirmPasswordCon.text,
                                  refercodee.text,
                                  emailCon.text
                              );
                            }},
                          hideBorder: true,
                          gradient: AppColors.primaryGradient
                        // gradient: activeButton
                        //     ? AppColors.primaryGradient
                        //     : AppColors.inactiveGradient,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: AppBtn(
                        onTap: () {
                          Navigator.pushNamed(context, RoutesName.loginScreen);
                        },
                        gradient: AppColors.secondaryGradient,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            textWidget(
                                text: 'I have an account',
                                fontSize: 16,
                                color: AppColors.secondaryTextColor,
                                fontWeight: FontWeight.w600),
                            const SizedBox(width: 15),
                            textWidget(
                                text: 'Login',
                                fontSize: 22,
                                color: AppColors.gradientFirstColor,
                                fontWeight: FontWeight.w600)
                          ],
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // otpurl(String phonenumber) async {
  //   final response = await http.get(
  //     Uri.parse(ApiUrl.OTP_url+'mobile=$phonenumber&digit=4&mode=live'),
  //   );
  //
  //
  //   var data = jsonDecode(response.body);
  //
  //   if(data["error"]=="200"){
  //     setState(() {
  //       show=true;
  //     });
  //     // otpMatch(myControllers.map((e) => e.text).join(),phoneCon.text);
  //     Utils.flushBarSuccessMessage(data["msg"], context, Colors.white);
  //
  //   }else {
  //
  //     Utils.flushBarErrorMessage(data["msg"], context, Colors.white);
  //
  //   }
  // }
  //
  // otpMatch(String myControllers,String Phone) async {
  //
  //   // show = false;
  //   // final prefs = await SharedPreferences.getInstance();
  //   // const key = 'userId';
  //   // final userId = user;
  //   // prefs.setString(key, userId);
  //   // if (kDebugMode) {
  //   //   print(userId);
  //   //   print('harsh');
  //   //   print(myControllers);
  //   // }
  //   final response = await http.get(Uri.parse('${ApiUrl.OTP_verify}mobile=$Phone&otp=$myControllers'));
  //
  //   if (kDebugMode) {
  //     print("sdghkhfd");
  //   }
  //
  //   var data = jsonDecode(response.body);
  //   if(data["error"]=="200"){
  //     setState(() {
  //       show = true;
  //     });
  //     final prefs = await SharedPreferences.getInstance();
  //     final userid = prefs.getString("token");
  //     // Navigator.pushReplacementNamed(context,  RoutesName.bottomNavBar);
  //   }else {
  //     setState(() {
  //       show = false;
  //     });
  //     Utils.flushBarErrorMessage(data["msg"], context, Colors.white);
  //
  //   }
  // }


}
