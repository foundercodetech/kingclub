//
//
// class ForgetPasswordScreen extends StatefulWidget {
//   const ForgetPasswordScreen({super.key});
//
//   @override
//   State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
// }
//
// class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
//   final _formKey = GlobalKey<FormState>();
//
//   bool selectedButton = true;
//   bool hideSetPassword = true;
//   bool hideConfirmPassword = true;
//   bool rememberPass = false;
//
//   // bool activeButton = true;
//   TextEditingController phoneCon = TextEditingController();
//   TextEditingController newPasswordCon = TextEditingController();
//   TextEditingController confirmPasswordCon = TextEditingController();
//   TextEditingController verifyCode = TextEditingController();
//   TextEditingController emailCon = TextEditingController();
//
//   int secondsRemaining = 60;
//   late Timer timer;
//
//   bool isOtpVerified = false;
//   bool isOtpSend = false;
//
//   void startTimer() {
//     timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
//       setState(() {
//         if (secondsRemaining > 0) {
//           secondsRemaining--;
//         } else {
//           timer.cancel();
//         }
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     timer.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final widths = MediaQuery.of(context).size.width;
//     final heights = MediaQuery.of(context).size.height;
//     final userForgetPasswordProvider =
//     Provider.of<UserForgetPasswordProvider>(context);
//     return Scaffold(
//       appBar: const GradientAppBar(
//         title: Text(
//           'Forget Password',
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//         leading: AppBackBtn(),
//         gradient: AppColors.primaryGradient,
//         centerTitle: false,
//       ),
//       body: ScrollConfiguration(
//         behavior: const ScrollBehavior().copyWith(overscroll: false),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const CircleAvatar(
//                   radius: 80,
//                   backgroundImage: AssetImage(Assets.imagesWingoLogo),
//                 ),
//                 !isOtpVerified
//                     ? sendOtp(userForgetPasswordProvider)
//                     : createNewPassword(userForgetPasswordProvider),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   otpSent(String mobile) async {
//     final response = await http.get(Uri.parse(
//         "https://otp.hopegamings.in/send_otp.php?mobile=$mobile&digit=6&mode=live"));
//     if (response.statusCode == 200) {
//       setState(() {
//         isOtpSend = true;
//         startTimer();
//       });
//     } else {
//       print(response.statusCode);
//     }
//   }
//
//   Widget sendOtp(userForgetPasswordProvider) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
//           child: CustomTextField(
//             onChanged: (value) {
//               if (phoneCon.text.length == 10) {}
//             },
//             prefixIcon: const Icon(
//               Icons.mobile_friendly,
//               color: Colors.red,
//             ),
//             keyboardType: TextInputType.number,
//             controller: phoneCon,
//             maxLength: 10,
//             hintText: 'Enter Mobile number',
//           ),
//         ),
//         if (isOtpSend) Padding(
//           padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
//           child: CustomTextField(
//             controller: verifyCode,
//             prefixIcon: const Icon(
//               Icons.verified_user,
//               color: Colors.red,
//             ),
//             maxLines: 1,
//             hintText: 'Verification code',
//             onChanged: (v) async {
//               if(v.length==6){
//                 final res = await http.get(Uri.parse(
//                     "https://otp.hopegamings.in/verifyotp.php?mobile=${phoneCon.text}&otp=${verifyCode.text}"));
//                 String data = jsonDecode(res.body)['error'];
//                 if (data == "400") {
//                   Utils.flushBarSuccessMessage(
//                       "Wrong Otp", context, Colors.red);
//                 }
//                 else {
//                   setState(() {
//                     isOtpVerified=true;
//                   });
//                   // Utils.flushBarSuccessMessage("message", context, messageColor)
//                   userForgetPasswordProvider.forgetUpdateUser(
//                     context,
//                     phoneCon.text,
//                     newPasswordCon.text,
//                     confirmPasswordCon.text,
//                   );
//                 }
//               }else{
//                 print("not done");
//               }
//             },
//           ),
//         ) else SizedBox(),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
//           child: AppBtn(
//             onTap: () {
//               if (phoneCon.text.isNotEmpty &&
//                   phoneCon.text.length == 10 &&
//                   (secondsRemaining == 0 || secondsRemaining == 60)) {
//                 print("iffff run");
//                 otpSent(phoneCon.text);
//               } else if (phoneCon.text.isEmpty || phoneCon.text.length != 10) {
//                 print("please enter valid number");
//               }
//               // if (phoneCon.text.isEmpty ||
//               //     phoneCon.text.length != 10) {
//               //   ScaffoldMessenger.of(context).showSnackBar(
//               //     const SnackBar(
//               //       content: Text(
//               //           "Please enter a valid 10-digit phone number."),
//               //     ),
//               //   );
//               // } else if (secondsRemaining == 0 ||
//               //     secondsRemaining == 60) {
//               //
//               //   startTimer();
//               // }
//               // else {
//               //   ScaffoldMessenger.of(context).showSnackBar(
//               //     const SnackBar(
//               //       content: Text(
//               //           "Please wait for 60 seconds before requesting OTP again."),
//               //     ),
//               //   );
//               // }
//             },
//             title: secondsRemaining == 0 || secondsRemaining == 60
//                 ? "Send Otp"
//                 : '$secondsRemaining s',
//           ),
//         ),
//         SizedBox(height: 5,),
//         Text("Otp not recived? Resend in: $secondsRemaining s")
//       ],
//
//     );
//   }
//
//   Widget createNewPassword(userForgetPasswordProvider) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
//           child: CustomTextField(
//             obscureText: hideSetPassword,
//             controller: newPasswordCon,
//             maxLines: 1,
//             hintText: 'Password (≥6 characters)',
//             prefixIcon: const Icon(
//               Icons.lock,
//               color: Colors.red,
//             ),
//             suffixIcon: IconButton(
//                 onPressed: () {
//                   setState(() {
//                     hideSetPassword = !hideSetPassword;
//                   });
//                 },
//                 icon: SvgPicture.asset(hideSetPassword
//                     ? Assets.iconsEyeClose
//                     : Assets.iconsEyeOpen)),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
//           child: CustomTextField(
//             obscureText: hideConfirmPassword,
//             controller: confirmPasswordCon,
//             maxLines: 1,
//             hintText: 'Password (≥6 characters)',
//             prefixIcon: const Icon(
//               Icons.lock,
//               color: Colors.red,
//             ),
//             suffixIcon: IconButton(
//                 onPressed: () {
//                   setState(() {
//                     hideConfirmPassword = !hideConfirmPassword;
//                   });
//                 },
//                 icon: SvgPicture.asset(hideConfirmPassword
//                     ? Assets.iconsEyeClose
//                     : Assets.iconsEyeOpen)),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
//           child: AppBtn(
//               title: 'Reset',
//               fontSize: 20,
//               loading: userForgetPasswordProvider.loading,
//               onTap: () async {
//                 if (phoneCon.text.isEmpty || phoneCon.text.length != 10) {
//                   Utils.flushBarSuccessMessage(
//                       "Enter phone number", context, Colors.red);
//                 } else if (newPasswordCon.text.isEmpty) {
//                   Utils.flushBarSuccessMessage(
//                       "Set your password", context, Colors.red);
//                 } else if (confirmPasswordCon.text.isEmpty) {
//                   Utils.flushBarSuccessMessage(
//                       "Confirm your password", context, Colors.red);
//                 } else {
//                   final res = await http.get(Uri.parse(
//                       "https://otp.hopegamings.in/verifyotp.php?mobile=${phoneCon.text}&otp=${verifyCode.text}"));
//                   String data = jsonDecode(res.body)['error'];
//                   data == "400"
//                       ? Utils.flushBarSuccessMessage(
//                       "Wrong Otp", context, Colors.red)
//                       : userForgetPasswordProvider.forgetUpdateUser(
//                     context,
//                     phoneCon.text,
//                     newPasswordCon.text,
//                     confirmPasswordCon.text,
//                   );
//                 }
//               },
//               hideBorder: true,
//               gradient: AppColors.primaryGradient),
//         ),
//       ],
//     );
//   }
// }