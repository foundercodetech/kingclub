import 'dart:convert';

import 'package:mahajong/generated/assets.dart';
import 'package:mahajong/model/user_model.dart';
import 'package:mahajong/res/aap_colors.dart';
import 'package:mahajong/res/components/app_bar.dart';
import 'package:mahajong/res/components/app_btn.dart';
import 'package:mahajong/res/components/clipboard.dart';
import 'package:mahajong/res/components/image_picker.dart';
import 'package:mahajong/res/components/text_field.dart';
import 'package:mahajong/res/components/text_widget.dart';
import 'package:mahajong/res/helper/api_helper.dart';
import 'package:mahajong/res/provider/profile_provider.dart';
import 'package:mahajong/res/provider/user_view_provider.dart';
import 'package:mahajong/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../res/api_urls.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  @override
  void initState() {
    profiledata();
    fetchData();
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  profiledata(){
    final userData = Provider.of<ProfileProvider>(context, listen: false).userData;
    namechangre.text =  userData!.username==null?"": userData.username.toString();
    phonecon.text = userData.mobile==null?"":userData.mobile.toString();
    emailCon.text = userData.email==null?"":userData.email.toString();
  }


  BaseApiHelper baseApiHelper = BaseApiHelper();


  TextEditingController namechangre = TextEditingController();
  TextEditingController uidcon = TextEditingController();
  TextEditingController phonecon = TextEditingController();
  TextEditingController emailCon = TextEditingController();


  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<ProfileProvider>(context).userData;


    final widths = MediaQuery.of(context).size.width;
    final heights = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: GradientAppBar(
        leading: AppBackBtn(),
          title: textWidget(
              text: 'Profile',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryGradient),
      body: userData!=null? ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.transparent,

                                backgroundImage:
                                myData != '0'
                                    ?
                                Image.memory(base64Decode(myData)).image:
                                NetworkImage(ApiUrl.uploadimage+userData.photo.toString()),
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      _settingModalBottomSheet(context);
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.redAccent,
                                      radius: 18,
                                      child: Icon(Icons.camera_alt_outlined),
                                    ),
                                  )),
                            ],
                          ),
                        ),

                        Container(
                          height: 35,
                          decoration: BoxDecoration(
                            color: AppColors.gradientSecondColor,
                            borderRadius:
                            BorderRadiusDirectional.circular(30),
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                textWidget(
                                    text: 'UID',
                                    color: AppColors.primaryTextColor,
                                    fontSize: 16),
                                const SizedBox(width: 8),
                                Container(
                                  width: 2,
                                  height: 18,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                textWidget(
                                    text: userData.custId.toString(),
                                    color: AppColors.primaryTextColor,
                                    fontSize: 16),
                                const SizedBox(width: 8),
                                InkWell(
                                    onTap: (){
                                      copyToClipboard(userData.custId.toString(), context);
                                    },
                                    child: Image.asset(Assets.iconsCopy)),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: heights*0.02,),
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
                              text: 'Nickname',
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: AppColors.secondaryTextColor)
                        ],
                      ),
                    ),
                    SizedBox(height: heights*0.01,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: CustomTextField(
                        controller: namechangre,
                        maxLines: 1,
                        hintText: "Enter your nickname",

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
                        child: CustomTextField(
                          keyboardType: TextInputType.phone,
                          controller: phonecon,
                          maxLength: 10,
                          hintText: 'Please enter the phone number',
                        )),
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

                        controller: emailCon,
                        maxLines: 1,
                        hintText: 'please input your email',

                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: AppBtn(
                        title: 'U p d a t e',
                        fontSize: 20,
                        titleColor: AppColors.gradientFirstColor,
                        onTap: () {
                          Profile_update(namechangre.text,phonecon.text,emailCon.text);

                        },
                        gradient: AppColors.secondaryGradient,
                      ),
                    ),



                  ],
                ),
              ),

            ],
          ),
        ),
      ):Container(),
    );
  }
  UserViewProvider userProvider = UserViewProvider();

  Profile_update(String changeusername,String phonenumber, String email) async {
    if (kDebugMode) {
      print("guycyg");
    }
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    if (kDebugMode) {
      print(token);
      print(changeusername);
    }
    final response = await http.post(Uri.parse(ApiUrl.profileUpdate),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic >{
          "userid":token,
          "username": changeusername,
          "mobile": phonenumber,
          "email": email,
          "image": myData,
        })
    );
    if(response.statusCode==200){
      final data = jsonDecode(response.body);
      if (kDebugMode) {
        print(data);
        print("👍👍👍👍update");
      }
      if(data["status"]=="200"){
        // getprofile();
        Navigator.pop(context);
        Utils.flushBarSuccessMessage(data["msg"], context, Colors.white);

      }
      else {
        Utils.flushBarErrorMessage(data["msg"], context, Colors.white);
      }
    }
    else{
      throw Exception("error");
    }

  }

  Future<void> fetchData() async {
    try {
      final userDataa = await  baseApiHelper.fetchProfileData();
      print(userDataa);
      print("userData");
      if (userDataa != null) {
        Provider.of<ProfileProvider>(context, listen: false).setUser(userDataa);
      }
    } catch (error) {
      // Handle error here
    }
  }


  String myData = '0';
  void _updateImage(ImageSource imageSource) async {
    String? imageData = await ChooseImage.chooseImageAndConvertToString(imageSource);
    if (imageData != null) {
      setState(() {
        myData = imageData;
      });
    }
  }

  void _settingModalBottomSheet(context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        context: context,
        builder: (BuildContext bc) {
          return SizedBox(
            height: heights / 7,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  widths / 12, 0, widths / 12, heights / 60),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      _updateImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: heights / 20,
                      width: widths / 2.7,
                      decoration: BoxDecoration(
                        // color: Colors.blue,
                          border: Border.all(color: Colors.red, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text(
                            "Camera",
                            style: TextStyle(color: Colors.red),
                          )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _updateImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: heights / 20,
                      width: widths / 2.7,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text(
                            "Gallery",
                          )),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }




}
