// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names, unnecessary_null_comparison, prefer_interpolation_to_compose_strings, use_build_context_synchronously, depend_on_referenced_packages, prefer_typing_uninitialized_variables
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:dashed_color_circle/dashed_color_circle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:mahajong/generated/assets.dart';
import 'package:mahajong/model/user_model.dart';
import 'package:mahajong/res/api_urls.dart';
import 'package:mahajong/res/app_constant.dart';
import 'package:mahajong/res/components/audio.dart';
import 'package:mahajong/res/helper/api_helper.dart';
import 'package:mahajong/res/provider/profile_provider.dart';
import 'package:mahajong/res/provider/user_view_provider.dart';
import 'package:mahajong/res/provider/wallet_provider.dart';
import 'package:mahajong/utils/utils.dart';
import 'package:mahajong/view/home/casino/Dragon_tiger/Game_history_dragon.dart';
import 'package:mahajong/view/home/casino/Dragon_tiger/Image_tost.dart';
import 'package:mahajong/view/home/casino/Dragon_tiger/coinAnimation.dart';
import 'package:mahajong/view/home/casino/Dragon_tiger/dragonRules.dart';
import 'package:mahajong/view/home/casino/Dragon_tiger/dragonTost.dart';
import 'package:mahajong/view/home/casino/Dragon_tiger/dragon_tiger_Assets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'Apimodel/fifteenResult.dart';
// class Coin {
//   final int value;
//
//   Coin(this.value);
// }
class Result {
  String photo;
  Result(this.photo);
}

class Chipsdata {
  String photos;
  Chipsdata(this.photos);
}

class DragontigerPage extends StatefulWidget {
  const DragontigerPage({Key? key}) : super(key: key);

  @override
  State<DragontigerPage> createState() => _DragontigerPageState();
}

class _DragontigerPageState extends State<DragontigerPage> with WidgetsBindingObserver,SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    fetchDataprofile();
    // _controller = AnimationController(
    //   vsync: this,
    //   duration: Duration(seconds: 1),
    // );
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: []);
    startCountdown();
    Audio.DragonbgSound();
    fetchData();
    walletfetch();
    fetchDataprofile();

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    Audio.audioPlayer.dispose();
    countdownTimer?.cancel();
    super.dispose();
  }

  // int? wallet;
  bool isFrontVisible = true;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      Audio.audioPlayer.stop();
    } else if (state == AppLifecycleState.resumed) {
      if (music) {
        Audio.DragonbgSound();
      }
    }
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();


  bool music = true;
  bool hidebutton = false;
  void _togglePlayback() async {
    if (music) {
      await Audio.audioPlayer.stop();
    } else {
      Audio.DragonbgSound();
    }
    setState(() {
      music = !music;
    });
  }

  final tigerCon = FlipCardController();
  final dragonCon = FlipCardController();

  String selectedImage = '';
  int selectedCart = 1;
  GlobalKey<CartIconKey> dragon = GlobalKey<CartIconKey>();
  GlobalKey<CartIconKey> tiger = GlobalKey<CartIconKey>();
  GlobalKey<CartIconKey> tie = GlobalKey<CartIconKey>();

  late Function(GlobalKey<CartIconKey>) runAddToCartAnimation;
  var _cartQuantityItems = 0;

  int countdownSeconds = 60;
  Timer? countdownTimer;

  void countandcoinclear() {
    setState(() {
      dragonCoins.clear();
      dragoncount = 0;

      tigerCoins.clear();
      tigercount = 0;

      tieCoins.clear();
      tiecount = 0;
    });
  }

  void toggleCard() {
    setState(() {
      isFrontVisible = !isFrontVisible;
    });
  }

  Future<void> startCountdown() async {
    DateTime now = DateTime.now().toUtc();
    int initialSeconds = 60 - now.second; // Calculate initial remaining seconds
    setState(() {
      countdownSeconds = initialSeconds;
    });

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateUI(timer);
    });
  }

  void updateUI(Timer timer) {
    setState(() {
      if (countdownSeconds == 59) {
        ImageToast.show(imagePath: AppAssets.dvst, heights: 100, context: context);
        changeRandom();

      } else if (countdownSeconds == 57) {
        ImageToast.show(
            imagePath: AppAssets.dragontigerStartbetting,
            heights: 100,
            context: context);
        _addCoins(100);

      } else if (countdownSeconds == 35) {
        ImageToast.show(
            imagePath: AppAssets.twsecleft, heights: 100, context: context);
      } else if (countdownSeconds == 13) {
        ImageToast.show(
            imagePath: AppAssets.dragontigerStopbetting,
            heights: 100,
            context: context);
        hidebutton = true;
      } else if (countdownSeconds == 8) {
        beting();
      } else if (countdownSeconds == 4) {
        lastresultview();
        // walletview();
        walletfetch();
      } else if (countdownSeconds == 1) {
        _handleFlipCards(countdownSeconds);
        fetchData();
        hidebutton = false;
        fristcome=true;
        coins.clear();
        coins2.clear();
        coins3.clear();
      }
      countdownSeconds = (countdownSeconds - 1) % 60;
    });
  }

  void _handleFlipCards(int newCountdownSeconds) {
    dragonCon.flipcard();
    tigerCon.flipcard();
    countdownSeconds = newCountdownSeconds;
  }



  List<int> list = [10, 50, 100, 500, 1000];
  int tigercount = 0;
  int tiecount = 0;
  int dragoncount = 0;
  List<Widget> dragonCoins = [];
  List<Widget> tieCoins = [];
  List<Widget> tigerCoins = [];

  Future<bool> _onWillPop() async {
    Audio.audioPlayer.stop();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    Navigator.of(context, rootNavigator: true).pop(context);
    return true;
  }


  bool fristcome=false;
  int WaitingTimeSeconds = 60;


  List<Map<String, String>> data = [
    {"name": "User465","image": Assets.dragontigerAvatar0,"bgimage": AppAssets.dragontigerVip1},
    {"name": "User6869","image": Assets.dragontigerAvatar1,"bgimage": AppAssets.dragontigerVip2},
    {"name": "qweer","image": Assets.dragontigerAvatar2,"bgimage": AppAssets.dragontigerVip3},
    {"name": "devil","image": Assets.dragontigerAvatar3,"bgimage": AppAssets.dragontigerVip4},
    {"name": "darkdeviii","image": Assets.dragontigerAvatar4,"bgimage": AppAssets.dragontigerVip5},
    {"name": "akay76","image": Assets.dragontigerAvatar5,"bgimage": AppAssets.dragontigerVip6},
    {"name": "loki999","image": Assets.dragontigerAvatar7,"bgimage": AppAssets.dragontigerVip7},
    {"name": "ironrrr","image": Assets.dragontigerAvatar8,"bgimage": AppAssets.dragontigerVip8},
    {"name": "zerox445","image": Assets.dragontigerAvatar10,"bgimage": AppAssets.dragontigerVip9},
    {"name": "prime213","image": Assets.dragontigerAvatar11,"bgimage": AppAssets.dragontigerVip10},
    {"name": "po39","image": Assets.dragontigerAvatar9,"bgimage": AppAssets.dragontigerVip1},


    {"name": "User465", "image": AppAssets.dragontigerAvatar0,"bgimage": AppAssets.dragontigerVip2},
    {"name": "User6869", "image": AppAssets.dragontigerAvatar1,"bgimage": AppAssets.dragontigerVip3},
    {"name": "qweffser", "image": AppAssets.dragontigerAvatar2,"bgimage": AppAssets.dragontigerVip4},
    {"name": "desvil", "image": AppAssets.dragontigerAvatar3,"bgimage": AppAssets.dragontigerVip5},
    {"name": "ddeviii", "image": AppAssets.dragontigerAvatar4,"bgimage": AppAssets.dragontigerVip6},
    {"name": "aky76", "image": AppAssets.dragontigerAvatar5,"bgimage": AppAssets.dragontigerVip7},
    {"name": "loki999", "image": AppAssets.dragontigerAvatar7,"bgimage": AppAssets.dragontigerVip8},
    {"name": "i555rr", "image": AppAssets.dragontigerAvatar8,"bgimage": AppAssets.dragontigerVip9},
    {"name": "zerrox445", "image": AppAssets.dragontigerAvatar10,"bgimage": AppAssets.dragontigerVip10},
    {"name": "prime0213", "image": AppAssets.dragontigerAvatar11,"bgimage": AppAssets.dragontigerVip1},
    {"name": "po539", "image": AppAssets.dragontigerAvatar9,"bgimage": AppAssets.dragontigerVip2} ,

    {"name": "465User","image": AppAssets.dragontigerAvatar0,"bgimage": AppAssets.dragontigerVip3},
    {"name": "User7869","image": AppAssets.dragontigerAvatar1,"bgimage": AppAssets.dragontigerVip4},
    {"name": "qweelknhr","image": AppAssets.dragontigerAvatar2,"bgimage": AppAssets.dragontigerVip5},
    {"name": "devilllvil","image": AppAssets.dragontigerAvatar3,"bgimage": AppAssets.dragontigerVip6},
    {"name": "devidark","image": AppAssets.dragontigerAvatar4,"bgimage": AppAssets.dragontigerVip7},
    {"name": "akay76","image": AppAssets.dragontigerAvatar5,"bgimage": AppAssets.dragontigerVip8},
    {"name": "thori999","image": AppAssets.dragontigerAvatar7,"bgimage": AppAssets.dragontigerVip9},
    {"name": "batsmann0x","image": AppAssets.dragontigerAvatar8,"bgimage": AppAssets.dragontigerVip10},
    {"name": "rox445","image": AppAssets.dragontigerAvatar10,"bgimage": AppAssets.dragontigerVip1},
    {"name": "prime9o13","image": AppAssets.dragontigerAvatar11,"bgimage": AppAssets.dragontigerVip2},
    {"name": "99OX9","image": AppAssets.dragontigerAvatar9,"bgimage": AppAssets.dragontigerVip3}
  ];

  Random random = Random();
  List<int> indexesFirstList = [0, 1, 2]; // Initial indexes for the first list
  List<int> indexesSecondList = [3, 4, 5]; // Initial indexes for the second list

  void changeRandom() {
    setState(() {
      indexesFirstList = [
        random.nextInt(data.length),
        random.nextInt(data.length),
        random.nextInt(data.length)
      ];
      indexesSecondList = [
        random.nextInt(data.length),
        random.nextInt(data.length),
        random.nextInt(data.length)
      ];
    });
  }


  List<Widget> coins = [];
  List<Widget> coins2 = [];
  List<Widget> coins3 = [];
  void _addCoins(int count) {
    for (int i = 0; i < count; i++) {

      Timer(Duration(milliseconds: i * 200), () {
        setState(() {
          coins.add(
            const _AnimatedCoin(type: 0,),
          );
          coins2.add(
            const _AnimatedCoin(type: 1,),
          );
          coins3.add(
            const _AnimatedCoin(type: 2,),
          );
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<ProfileProvider>(context).userData;

    final walletdetails = Provider.of<WalletProvider>(context).walletlist;

    final heights = MediaQuery.of(context).size.height;
    final widths = heights * 2.1;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: AddToCartAnimation(
        cartKey: selectedCart == 1
            ? dragon
            : selectedCart == 2
                ? tie
                : tiger,
        height: 15,
        width: 15,
        opacity: 0.85,
        dragAnimation: const DragToCartAnimationOptions(
          rotation: false,
        ),
        jumpAnimation: const JumpAnimationOptions(),
        createAddToCartAnimation: (runAddToCartAnimation) {
          this.runAddToCartAnimation = runAddToCartAnimation;
        },
        child: SafeArea(
          child:
          fristcome==false?
          Scaffold(
            backgroundColor: Colors.deepOrange,
            body:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Assets.dragontigerDragonTigerRemovebgPreview,height: heights*0.40,),
                SizedBox(height: heights*0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xffea0b3e), width: 1),
                      ),
                      child: LinearProgressIndicator(
                        value: 1 - (countdownSeconds / WaitingTimeSeconds),
                        backgroundColor: Colors.grey,
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xffea0b3e)),
                        minHeight: 6,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Text(
                      '  ${(100 - ((countdownSeconds / WaitingTimeSeconds) * 100)).toStringAsFixed(0)}%',
                    ),
                    // Text(' ${_linearProgressAnimation.value.toStringAsFixed(2)}%',style: TextStyle(color: Colors.white),),
                  ],
                ),
                SizedBox(height: heights*0.02,),
                Text(
                  " Dragon Tiger is a verifiably 100% ${AppConstants.appName}",
                  style: TextStyle(
                      fontSize: widths*0.02,
                    color: Colors.white
                  ),
                )
              ],
            ),
          ):
          walletdetails != null?Scaffold(
            body: Container(
              height: heights,
              width: widths,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.backgroundDragontigerBg),
                  fit: BoxFit.fill,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: PopupMenuButton<String>(
                      icon: Image.asset(
                        AppAssets.buttonsBtnCaidan,
                        scale: 0.2,
                      ),
                      offset: const Offset(0, 45),
                      onSelected: handleClick,
                      color: Colors.black.withOpacity(0.9),
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem<String>(
                          child: ListTile(
                            onTap: () {
                              Audio.audioPlayer.stop();
                              SystemChrome.setPreferredOrientations([
                                DeviceOrientation.portraitUp,
                                DeviceOrientation.portraitDown,
                                DeviceOrientation.landscapeLeft,
                                DeviceOrientation.landscapeRight,
                              ]);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            leading: const Icon(
                              Icons.home_rounded,
                              color: Colors.white,
                            ),
                            title: const Text(
                              'Lobby',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const PopupMenuDivider(
                          height: 5,
                        ),
                        PopupMenuItem<String>(
                          child: ListTile(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const DragonRules()));
                            },
                            leading: const Icon(
                              Icons.rule_outlined,
                              color: Colors.white,
                            ),
                            title: const Text(
                              'Rule',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const PopupMenuDivider(
                          height: 5,
                        ),
                        PopupMenuItem<String>(
                          child: ListTile(
                            onTap: _togglePlayback,
                            leading: Icon(
                              music
                                  ? Icons.music_note_sharp
                                  : Icons.music_off,
                              color: Colors.white,
                            ),
                            title: const Text(
                              'Music',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const PopupMenuDivider(
                          height: 5,
                        ),
                        PopupMenuItem<String>(
                          child: ListTile(
                            onTap: () {
                              SystemChrome.setPreferredOrientations([
                                DeviceOrientation.portraitUp,
                                DeviceOrientation.portraitDown,
                                DeviceOrientation.landscapeLeft,
                                DeviceOrientation.landscapeRight,
                              ]);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const Dragon_gameHistory()));
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => CoinAnimation()));
                            },
                            leading: const Icon(
                              Icons.history,
                              color: Colors.white,
                            ),
                            title: const Text(
                              'Game History',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: heights*0.22 ),
                    child: SizedBox(
                      height: heights*0.66,
                      width: widths*0.08,
                      child:  Column(
                        children: [
                          for (int index in indexesFirstList)
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 27,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:  AssetImage(data[index]['bgimage']!),
                                  child: CircleAvatar(
                                    radius: 21.5,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage:  AssetImage(data[index]['image']!),
                                  )

                                ),
                                Text(
                                  data[index]['name']!,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: widths * 0.015, color: Colors.white),
                                ),
                                SizedBox(height: heights * 0.03),
                              ],
                            )
                        ],
                      ),


                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: heights / 1.30,
                          width: widths / 1.55,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppAssets.backgroundIcDtTable),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [

                                  SizedBox(
                                    width: widths / 10.3,
                                  ),
                                  Image.asset(AppAssets.imageIcDragonGif,
                                      height: heights / 6),
                                  FlipCard(
                                    rotateSide: RotateSide.bottom,
                                    controller: dragonCon,
                                    animationDuration:
                                        const Duration(milliseconds: 800),
                                    axis: FlipAxis.horizontal,
                                    frontWidget: Image.asset(
                                        AppAssets.imageFireCard,
                                        height: heights / 7),
                                    backWidget: Image.asset(
                                        dragonpatti == null
                                            ? 'assets/cards/' + '1' + ".png"
                                            : "assets/cards/" +
                                                dragonpatti +
                                                ".png",
                                        height: heights / 8),
                                  ),
                                  Image.asset(AppAssets.imageIcVerse,
                                      height: heights / 6),
                                  FlipCard(
                                    rotateSide: RotateSide.bottom,
                                    controller: tigerCon,
                                    animationDuration:
                                        const Duration(milliseconds: 800),
                                    axis: FlipAxis.horizontal,
                                    frontWidget: Image.asset(
                                        AppAssets.imageFireCard,
                                        height: heights / 7),
                                    backWidget: Image.asset(
                                        tigerpatti == null
                                            ? 'assets/cards/' + '1' + ".png"
                                            : 'assets/cards/' +
                                                tigerpatti +
                                                ".png",
                                        height: heights / 8),
                                  ),
                                  Image.asset(AppAssets.imageIcTigerGif,
                                      height: heights / 6),
                                ],
                              ),

                              SizedBox(
                                height: heights / 70,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: widths / 40,
                                  ),
                                  SizedBox(
                                    height: heights / 20,
                                    width: widths / 2.7,
                                    child: ListView.builder(
                                      itemCount: items.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return CircleAvatar(
                                          radius: heights / 40,
                                          backgroundImage: AssetImage(
                                              items[index].win_number == '1'
                                                  ? AppAssets.backgroundIcDtTie
                                                  : items[index].win_number ==
                                                          '2'
                                                      ? AppAssets.imageIcDtD
                                                      : AppAssets.imageIcDtT),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: widths / 40,
                                  ),
                                  Image.asset(AppAssets.buttonsIcArrowZigzag,
                                      height: heights / 19),
                                ],
                              ),
                              SizedBox(
                                height: heights / 70,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: heights / 2.5,
                                    width: widths / 7,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedCart = 1;
                                        });
                                      },
                                      child: Container(
                                        key: dragon,
                                        height: heights / 2.5,
                                        width: widths / 7,
                                        decoration: BoxDecoration(
                                          image: const DecorationImage(
                                            image: AssetImage(AppAssets.backgroundPurpledragon),
                                            fit: BoxFit.fill,
                                          ),
                                          borderRadius: BorderRadius.circular(5),
                                          border: Border.all(
                                            width: 3,
                                            color: selectedCart == 1 ? Colors.green : Colors.transparent,
                                          ),
                                          color: selectedCart == 1 ? Colors.blue.withOpacity(0.5) : null,
                                        ),
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Positioned(
                                                left: -130,
                                                top: 10,
                                                child:
                                                Stack(
                                                  children: coins,
                                                )),

                                            Stack(
                                              children: [
                                                for (var data in dragonCoins) data,
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: heights / 3.5,
                                        width: widths / 7.5,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(AppAssets
                                                .backgroundIcDtTieButton),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedCart = 2;
                                            });
                                          },
                                          child: Center(
                                            child: Container(
                                              key: tie,
                                              height: heights / 4.0,
                                              width: widths / 8.9,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(5),
                                                border: Border.all(
                                                    width: 3,
                                                    color: selectedCart == 2
                                                        ? Colors.green
                                                        : Colors.transparent),
                                                color: selectedCart == 2
                                                    ? Colors.blue
                                                    .withOpacity(0.5)
                                                    : null,
                                              ),
                                              child: Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  Positioned(
                                                      left: -140,
                                                      top: 0,
                                                      child:
                                                      Stack(
                                                        children: coins2,
                                                      )),

                                                  Stack(
                                                    children: [
                                                      for (var data in tieCoins) data,
                                                    ],
                                                  ),
                                                ],
                                              ),),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: heights / 9,
                                        width: widths / 9,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                AppAssets.buttonsRuppePannel),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                CircleAvatar(
                                                  radius: heights / 80,
                                                  backgroundImage:
                                                  const AssetImage(
                                                      AppAssets.imageIcDtD),
                                                ),
                                                CircleAvatar(
                                                  radius: heights / 80,
                                                  backgroundImage:
                                                  const AssetImage(AppAssets
                                                      .backgroundIcDtTie),
                                                ),
                                                CircleAvatar(
                                                  radius: heights / 80,
                                                  backgroundImage:
                                                  const AssetImage(
                                                      AppAssets.imageIcDtT),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  dragoncount.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 9,
                                                      fontWeight:
                                                      FontWeight.w800,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  tiecount.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 9,
                                                      fontWeight:
                                                      FontWeight.w800,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  tigercount.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 9,
                                                      fontWeight:
                                                      FontWeight.w800,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: heights / 2.5,
                                    width: widths / 7,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            AppAssets.backgroundOrange),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedCart = 3;
                                        });
                                      },
                                      child: Container(
                                        key: tiger,
                                        height: heights / 2.5,
                                        width: widths / 7,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                          border: Border.all(
                                              width: 3,
                                              color: selectedCart == 3
                                                  ? Colors.green
                                                  : Colors.transparent),
                                          color: selectedCart == 3
                                              ? Colors.blue.withOpacity(0.5)
                                              : null,
                                        ),
                                        child:Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Positioned(
                                                left: -130,
                                                top: 10,
                                                child:
                                                Stack(
                                                  children: coins3,
                                                )),

                                            Stack(
                                              children: [
                                                for (var data in tigerCoins) data,
                                              ],
                                            ),
                                          ],
                                        ),


                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //_buildAnimatedCoins(),
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 2, bottom: 2, left: 5),
                            child:  CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.deepPurple.shade100,
                              backgroundImage: userData!.photo == null
                                  ? const AssetImage(Assets.person5) as ImageProvider:
                                    NetworkImage(ApiUrl.uploadimage + userData.photo.toString())

                            ),
                          ),
                          SizedBox( width: widths *0.02,),
                          Container(
                            height: heights / 7,
                            width: widths / 2.2,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AppAssets.backgroundTotalBetInput),
                                fit: BoxFit.fill
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: widths / 60),
                                InkWell(
                                  onTap: (){
                                    // throwCoins();
                                  },
                                  child: Container(
                                    height: heights / 15,
                                    width: widths / 8,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(AppAssets.buttonsRedButton),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        walletdetails.wallet == null
                                            ? '₹ 00'
                                            : '₹ ' +  walletdetails.wallet.toString(),
                                        style:  TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context).size.width / 70,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: widths / 80,
                                ),
                                SizedBox(
                                  height: heights / 6,
                                  width: widths / 3.6,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: list.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext, int index) {
                                      final GlobalKey<CartIconKey> itemKey =
                                      GlobalKey<CartIconKey>();
                                      return hidebutton == true
                                          ? hidecoins(list[index])
                                          : InkWell(
                                        onTap: () {
                                          double walletAmount = double.parse(walletdetails.wallet.toString());

                                          walletAmount < list[index]
                                              ? Utils.flushBarErrorMessage(
                                              'Low Balance',
                                              context,
                                              Colors.white)
                                              : Future.delayed(
                                              const Duration(milliseconds: 1500),
                                                  () {
                                                if (selectedCart == 3) {
                                                  tigerCoins.add(Positioned(
                                                      left: Randomno(1, 70),
                                                      top: Randomno(1, 70),
                                                      child: CoindesignNew(list[index])));
                                                } else if (selectedCart == 2) {
                                                  tieCoins.add(Positioned(
                                                      left: Randomno(1, 40),
                                                      top: Randomno(1, 40),
                                                      child: CoindesignNew(list[index])));
                                                } else {
                                                  dragonCoins.add(Positioned(
                                                      left: Randomno(1, 70),
                                                      top: Randomno(1, 70),
                                                      child: CoindesignNew(list[index])));
                                                }
                                                setState(() {
                                                  if (selectedCart == 3) {
                                                    tigercount = tigercount + list[index];
                                                  } else if (selectedCart == 2) {
                                                    tiecount = tiecount + list[index];
                                                  } else {
                                                    dragoncount = dragoncount + list[index];
                                                  }
                                                });
                                              });

                                          walletAmount < list[index]
                                              ? ''
                                              : listClick(itemKey);

                                          void deductAmount(int amountToDeduct) {
                                            if (walletAmount >= amountToDeduct) {
                                              setState(() {
                                                walletAmount = (walletAmount - amountToDeduct).toDouble();
                                              });

                                            } else {
                                              Utils.flushBarErrorMessage('Insufficient funds', context, Colors.white);
                                            }
                                          }
                                          deductAmount(list[index]);
                                        },
                                        child: Container(
                                            key: itemKey,
                                            child: CoindesignNew(list[index])),
                                      );

                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox( width: widths *0.02,),


                        ],
                      ),

                    ],
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: heights*0.22),
                    child: SizedBox(
                      height: heights*0.66,
                      width: widths*0.076,

                      child:  Column(
                        children: [
                          for (int index in indexesSecondList)
                            Column(
                              children: [
                                CircleAvatar(
                                    radius: 27,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage:  AssetImage(data[index]['bgimage']!),
                                    child: CircleAvatar(
                                      radius: 21.5,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:  AssetImage(data[index]['image']!),
                                    )

                                ),

                                Text(
                                  data[index]['name']!,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: widths * 0.015, color: Colors.white),
                                ),
                                SizedBox(height: heights * 0.03),
                              ],
                            )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: heights / 5.3,
                    width: widths / 9.7,
                    decoration: const BoxDecoration(

                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(AppAssets.watch)),
                    ),
                    child: Center(child: Text(countdownSeconds.toString())),
                  )
                ],
              ),
            ),
          ):Container(),
        ),
      ),
    );
  }


  Randomno(int min, int max) {
    Random random = Random();
    return double.parse((min + random.nextInt(max - min + 1)).toString());
  }

  void handleClick(String value) {
    setState(() {});
  }

  void listClick(GlobalKey<CartIconKey> itemKey) async {
    await runAddToCartAnimation(itemKey);
    if (selectedCart == 1 && dragon.currentState != null) {
      dragon.currentState!.runCartAnimation((++_cartQuantityItems).toString());
      debugPrint('Selected Cart: Dragon');
    } else if (selectedCart == 2 && tie.currentState != null) {
      tie.currentState!.runCartAnimation((++_cartQuantityItems).toString());
      debugPrint('Selected Cart: Tie');
    } else if (selectedCart == 3 && tiger.currentState != null) {
      tiger.currentState!.runCartAnimation((++_cartQuantityItems).toString());
      debugPrint('Selected Cart: Tiger');
    }
  }

  Widget CoindesignNew(otherdatas) {
    Color color = Colors.red;
    if (otherdatas == 10) {
      color = Colors.red;
    } else if (otherdatas == 50) {
      color = Colors.orangeAccent;
    } else if (otherdatas == 100) {
      color = Colors.orange;
    } else if (otherdatas == 500) {
      color = Colors.deepOrangeAccent;
    } else if (otherdatas == 1000) {
      color = Colors.green;
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CircleAvatar(
        backgroundColor: color,
        radius: MediaQuery.of(context).size.width / 50,
        child: Stack(
          children: [
             Center(
              child: DashedColorCircle(
                dashes: 12,
                emptyColor: Colors.grey,
                filledColor: Colors.white,
                fillCount: 12,
                size: MediaQuery.of(context).size.width / 30,
                gapSize:  MediaQuery.of(context).size.width / 40,
                strokeWidth: 2.0,
              ),
            ),
            Center(
              child: Text(
                otherdatas.toString(),
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 80,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget hidecoins(otherdatas) {
    Color color = Colors.white;
    if (otherdatas == 10) {
      color = Colors.white;
    } else if (otherdatas == 50) {
      color = Colors.white;
    } else if (otherdatas == 100) {
      color = Colors.white;
    } else if (otherdatas == 500) {
      color = Colors.white;
    } else if (otherdatas == 1000) {
      color = Colors.white;
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CircleAvatar(
        backgroundColor: color,
        radius: MediaQuery.of(context).size.width / 50,
        child: Stack(
          children: [
             Center(
              child: DashedColorCircle(
                dashes: 12,
                emptyColor: Colors.grey,
                filledColor: Colors.grey,
                fillCount: 12,
                size: MediaQuery.of(context).size.width / 30,
                gapSize:  MediaQuery.of(context).size.width / 40,
                strokeWidth: 2.0,
              ),
            ),
            Center(
              child: Text(
                otherdatas.toString(),
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 80,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> fetchDataprofile() async {
    try {
      final userDataa = await baseApiHelper.fetchProfileData();
      if (userDataa != null) {
        Provider.of<ProfileProvider>(context, listen: false).setUser(userDataa);
      }
    }  catch (error) {
      // Handle other exceptions
    }
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


// // *wallet API*  //
//   walletview() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userid = prefs.getString("userId");
//     final response = await http.get(
//       Uri.parse('${ApiUrl.walletdash}userid=$userid'),
//     );
//     var data = jsonDecode(response.body);
//     if (data['error'] == '200') {
//       setState(() {
//         final walt = data['data'];
//         wallet =
//             (walt['wallet'] == null ? 0 : double.parse(walt['wallet'])).toInt();
//       });
//     }
//   }

// *Profile API*  //
//   var map;
//   viewprofile() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userid = prefs.getString("userId");
//     final response = await http.post(
//       Uri.parse(ApiUrl.profile),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         "id": '$userid',
//       }),
//     );
//     // .onError((error, stackTrace) => InternetSlowMsg(context));
//     var data = jsonDecode(response.body);
//     if (data['error'] == '200') {
//       setState(() {
//         map = data['userdata'];
//       });
//     }
//   }
  UserViewProvider userProvider = UserViewProvider();


  // *beting API*  //
  beting() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    if (kDebugMode) {
      print("ifvytdi");
    }
    final response = await http.post(
      Uri.parse(ApiUrl.dragonbetting),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userid": token,
        "dragon": dragoncount.toString(),
        "tiger": tigercount.toString(),
        "tie": tiecount.toString()
      }),
    );
    var data = jsonDecode(response.body);
    if (data["status"] == "200") {
      if (kDebugMode) {
        print(ApiUrl.dragonbetting);
        print("ApiUrl.dragonbetting");

      }

      ImageToast.show(imagePath: AppAssets.bettingplaceds, heights: 100, context: context);
      countandcoinclear();
      walletfetch();
    } else {
      Utils.flushBarErrorMessage(data['msg'], context, Colors.black);
    }
  }

  // *result*  //
  var dragonpatti;
  var tigerpatti;
  var winstatus;
  lastresultview() async {
    if (kDebugMode) {
      print("vyuf");
    }
    final response = await http.get(
      Uri.parse(ApiUrl.lastresult),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var data = jsonDecode(response.body);
    if (kDebugMode) {
      print(data);
      print('yuyuyu');
      print(ApiUrl.lastresult);
    }


    if (data['error'] == '200') {
      setState(() {
        dragonpatti = data['dragon'].toString();
        tigerpatti = data['tiger'].toString();
        winstatus = data['status'].toString();
      });
      _handleFlipCards(countdownSeconds);
      // or
      winstatus == '1'
          ? TextToast.show(message: 'Game Tie', context: context)
          : winstatus == '2'
              ? ImageToast.show(
                  imagePath: AppAssets.gif_dragon_animated,
                  context: context,
                )
              : ImageToast.show(
                  imagePath: AppAssets.gif_tiger_animated,
                  context: context,
                );
    }
  }

  List<lastfifteen> items = [];
  Future<void> fetchData() async {
    const url = ApiUrl.last15result;
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(url);
    }
    if (response.statusCode == 200) {
      final List<dynamic> responseData =
          json.decode(response.body)['last_result'];
      setState(() {
        items = responseData.map((item) => lastfifteen.fromJson(item)).toList();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        items = [];
      });
      throw Exception('Failed to load data');
    }
  }
}
class _AnimatedCoin extends StatefulWidget {
  final int type;

  const _AnimatedCoin({super.key, required this.type});
  @override
  _AnimatedCoinState createState() => _AnimatedCoinState();
}

class _AnimatedCoinState extends State<_AnimatedCoin> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation =
    widget.type==0?
    Tween<Offset>(
      begin: const Offset(-100, 250),
      end: _randomOffset(-10,10),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    ):widget.type==1?Tween<Offset>(
      begin: const Offset(-280, 300),
      end: _randomOffset(250,350),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    ):Tween<Offset>(
      begin: const Offset(-440, 300),
      end: _randomOffset(400,550),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();
  }

  doublepj(double start,double end ){
    Random random = Random();

    return  start + random.nextDouble() * (end - start);

  }
  Offset _randomOffset(double start, double end) {
    double randomPositionX = doublepj(80,120);
    double randomPositionY =  doublepj(70,120);
    return Offset(randomPositionX, randomPositionY);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: _animation.value,
          child: CoinSpringAnimation(),
        );
      },
    );
  }


}