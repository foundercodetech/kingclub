
// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:dashed_color_circle/dashed_color_circle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mahajong/model/user_model.dart';
import 'package:mahajong/res/api_urls.dart';
import 'package:mahajong/res/components/image_tost.dart';
import 'package:mahajong/res/helper/api_helper.dart';
import 'package:mahajong/res/provider/user_view_provider.dart';
import 'package:mahajong/res/provider/wallet_provider.dart';
import 'package:mahajong/utils/utils.dart';
import 'package:mahajong/view/home/casino/Dragon_tiger/dragon_tiger_Assets.dart';
import 'package:mahajong/view/home/casino/Plinko/PlinkoRules.dart';
import 'package:mahajong/view/home/casino/Plinko/Plinko_Constant/Plinko_Assets.dart';
import 'package:mahajong/view/home/casino/Plinko/Plinko_Constant/random_color.dart';
import 'package:mahajong/view/home/casino/Plinko/Plinko_model/green_list_model.dart';
import 'package:mahajong/view/home/casino/Plinko/plinko_game_history.dart';
import 'package:mahajong/view/home/casino/Plinko/widget/bet_locked_screen.dart';
import 'package:mahajong/view/home/casino/Plinko/widget/last_twelve_result.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class PlinkoHomePage extends StatefulWidget {
  const PlinkoHomePage({super.key});

  @override
  State<PlinkoHomePage> createState() => _PlinkoHomePageState();
}

class _PlinkoHomePageState extends State<PlinkoHomePage> with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  void handleClick(String value) {
    setState(() {});
  }

  int countdownSeconds = 60;
  Timer? countdownTimer;

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
        ImageToast.show(
            imagePath: PlinkoAssets.BettingStart,
            heights: 100,
            context: context);
      } else if (countdownSeconds == 35) {
        ImageToast.show(
            imagePath: PlinkoAssets.twentySecLeft,
            heights: 200,
            context: context);
      } else if (countdownSeconds == 18) {
        ImageToast.show(
            imagePath: PlinkoAssets.BettingStop,
            heights: 100,
            context: context);
        betLocked=false;
        hideButton = true;
      } else if (countdownSeconds == 15) {
        ballFallReq();
      } else if (countdownSeconds == 6) {
        amount.clear();
        image2Url = null;
        image1Url = null;
      } else if (countdownSeconds == 4) {
        // lastresultview();
        // walletView();
        walletfetch();
      } else if (countdownSeconds == 1) {
        light.clear();
        ballImg = PlinkoAssets.plinkoYellowball;

        hideButton = false;
        betLocked=false;
      }
      countdownSeconds = (countdownSeconds - 1) % 60;
    });
  }

  bool loadingGreen = false;
  bool loadingRed = false;
  bool betLocked = false;

  @override
  Widget build(BuildContext context) {

    final walletdetails = Provider.of<WalletProvider>(context).walletlist;

    wallet = (walletdetails!.wallet == null ? 0 : double.parse(walletdetails.wallet.toString())).toInt();
    wallbal = (walletdetails.wallet == null ? 0 : double.parse(walletdetails.wallet.toString())).toInt();

    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(PlinkoAssets.plinko_Home_bg),
                  fit: BoxFit.fill)),
          child: Stack(
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Center(child: board()),
                  const SizedBox(
                    height: 20,
                  ),
                 betLocked==true?const BetLockedScreen(): Center(
                    child: Container(
                      height: 200,
                      width: 370,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        color: Colors.black12.withOpacity(0.3),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (amount.text.isNotEmpty &&
                                        amount.text != "0") {
                                      greenBetPlaced(amount.text, greenCode!);
                                    } else {
                                      image1Url = null;
                                      Utils.flushBarErrorMessage(
                                          ' Select Amount First',
                                          context,
                                          Colors.white);
                                    }
                                  });
                                },
                                child: Container(
                                  height: 44.0,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    gradient: Constants.greenGradient.gradient,
                                  ),
                                  child: Center(
                                      child: loadingGreen == true
                                          ? const Center(
                                              child: CircularProgressIndicator(
                                              backgroundColor: Colors.white,
                                              color: Colors.red,
                                              strokeWidth: 2,
                                            ))
                                          : const Text(
                                              'Green',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            )),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (amount.text.isNotEmpty &&
                                        amount.text != "0") {
                                      redBetPlaced(amount.text, redCode!);
                                    } else {
                                      image2Url = null;
                                      Utils.flushBarErrorMessage(
                                          ' Select Amount First',
                                          context,
                                          Colors.white);
                                    }
                                  });
                                },
                                child: Container(
                                  height: 44.0,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    gradient: Constants.redGradient.gradient,
                                  ),
                                  child: Center(
                                      child: loadingRed == true
                                          ? const Center(
                                              child: CircularProgressIndicator(
                                              backgroundColor: Colors.white,
                                              color: Colors.green,
                                              strokeWidth: 2,
                                            ))
                                          : const Text(
                                              'Red',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            )),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 280,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              color: Colors.black12.withOpacity(0.3),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                    onTap: decrement,
                                    child: const Card(
                                      elevation: 6,
                                      shape: CircleBorder(),
                                      child: Icon(
                                        Icons.remove,
                                        size: 40,
                                      ),
                                    )),
                                SizedBox(
                                  width: 100,
                                  height: 50,
                                  child: TextField(
                                    textAlign:
                                        TextAlign.center, // Center the text
                                    keyboardType: TextInputType.number,
                                    controller: amount,
                                    readOnly: true,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (newValue) {
                                      setState(() {
                                        value = int.tryParse(newValue) ?? 0;
                                      });
                                    },
                                  ),
                                ),
                                InkWell(
                                    onTap: increment,
                                    child: const Card(
                                      elevation: 6,
                                      shape: CircleBorder(),
                                      child: Icon(
                                        Icons.add,
                                        size: 40,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              height: 55,
                              width: 390,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: list.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, int index) {
                                  return hideButton == true
                                      ? hidecoins(list[index])
                                      : InkWell(
                                          onTap: () {
                                            selectam(list[index]);

                                            // selectListItem();
                                          },
                                          child: Container(
                                              child:
                                                  coinDesignNew(list[index])),
                                        );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                setState(() {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                });
                              },
                              leading: const Icon(
                                Icons.home_rounded,
                                color: Colors.white,
                              ),
                              title: Text(
                                'Lobby',
                                style: TextStyle(
                                  fontSize: heights / 50,
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
                                        const PlinkoRules()));
                              },
                              leading: const Icon(
                                Icons.rule_outlined,
                                color: Colors.white,
                              ),
                              title: Text(
                                'Rule',
                                style: TextStyle(
                                  fontSize: heights / 50,
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
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const PlinkoGameHistory()));
                              },
                              leading: const Icon(
                                    Icons.history,
                                color: Colors.white,
                              ),
                              title: Text(
                                'Game History',
                                style: TextStyle(
                                  fontSize: heights / 50,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const PopupMenuDivider(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 13.0),
                      child: Container(
                        height: heights / 30,
                        width: widths / 5,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppAssets.buttonsRedButton),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            wallet == null ? '₹ 00' : '₹ $wallet',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: MediaQuery.of(context).size.width / 35,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        //   height: heights / 20,
                        width: widths / 1.55,
                        child: const LastTwelveResult()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Container(
                  height: heights / 12,
                  width: widths / 5,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill, image: AssetImage(AppAssets.watch)),
                  ),
                  child: Center(child: Text(countdownSeconds.toString())),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String? image1Url;
  String? greenCode = 'Green';
  String? image2Url;
  String? redCode = 'Red';

  String? ballImg = PlinkoAssets.plinkoYellowball;

  double postop = 50.0;
  double posleft = 200;
  Random r = Random();

  @override
  void initState() {
    super.initState();
    // walletView();
    walletfetch();
    startCountdown();
    // walletView();
    walletfetch();
    fallingAnimation();
    greenData();
    redData();
  }

  void fallingAnimation() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInQuint,
      ),
    );
  }

  void ballFallReq() {
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });
    ballFallPadding();
  }

  int m = 0;
  ballFallPadding() async {
    for (var data in fallBall) {
      await Future.delayed(const Duration(milliseconds: 200));
      _controller.reset();
      _controller.forward();
      setState(() {
        postop = data['top']!.toDouble();
        posleft = data['left']!.toDouble();
      });
      await Future.delayed(const Duration(milliseconds: 700));

      light.add(Light(data['column'], data['row']));
      setState(() {});
    }
  }

  Widget fallingball() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, -0.8),
        end: const Offset(0, 1.0),
      ).animate(_animation),
      child: Container(
        height: 15,
        width: 15,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(fit: BoxFit.fill, image: AssetImage(ballImg!)),
        ),
      ),
    );
  }

  TextEditingController amount = TextEditingController();
  int value = 1;
  List<int> list = [10, 50, 100, 500, 1000]; // List of integers
  int selectedAmount = 0;

  void increment() {
    setState(() {
      value = value + 1;
      deductAmount();
    });
  }

  void decrement() {
    setState(() {
      if (value > 0) {
        value = value - 1;
        deductAmount();
      }
    });
  }

  void selectam(int amount) {
    setState(() {
      selectedAmount = amount;
      value = 1;
    });
    deductAmount();
  }

  void deductAmount() {
    if (wallbal! >= selectedAmount * value) {
      wallet = wallbal;
    }
    int amountToDeduct = selectedAmount * value;
    if (wallet! >= amountToDeduct) {
      setState(() {
        amount.text = (selectedAmount * value).toString();
        wallet = (wallet! - amountToDeduct).toInt();
      });
    } else {
      Utils.flushBarErrorMessage('Insufficient funds', context, Colors.white);
    }
  }

  bool hideButton = false;

  Widget coinDesignNew(otherdatas) {
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
        radius: 30,
        child: Stack(
          children: [
            const Center(
              child: DashedColorCircle(
                dashes: 12,
                emptyColor: Colors.grey,
                filledColor: Colors.white,
                fillCount: 12,
                size: 40,
                gapSize: 6,
                strokeWidth: 2.0,
              ),
            ),
            Center(
              child: Text(
                otherdatas.toString(),
                style: const TextStyle(
                  fontSize: 12,
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
        radius: 30,
        child: Stack(
          children: [
            const Center(
              child: DashedColorCircle(
                dashes: 12,
                emptyColor: Colors.grey,
                filledColor: Colors.grey,
                fillCount: 12,
                size: 40,
                gapSize: 6,
                strokeWidth: 2.0,
              ),
            ),
            Center(
              child: Text(
                otherdatas.toString(),
                style: const TextStyle(
                  fontSize: 12,
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

  Widget board() {
    return Center(
      child: Container(
        height: 500,
        width: 400,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Center(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                padding: const EdgeInsets.all(0),
                itemBuilder: (context, i) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(i + 2, (j) {
                      final isLight = light.any((light) =>
                          light.column == i + 1 && light.row == j + 1);

                      return Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: CircleAvatar(
                            radius: 7,
                            backgroundImage: isLight
                                ? const AssetImage(PlinkoAssets.plinkoWhiteball)
                                : const AssetImage(PlinkoAssets.plinkoBlueball),
                            backgroundColor: Colors.transparent),
                      );
                    }),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: postop,
                left: posleft,
              ),
              child: fallingball(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 430.0, left: 20),
              child: SizedBox(
                height: 80,
                width: 370,
                child: Column(
                  children: [
                    Container(
                      height: 35,
                      width: 370,
                      decoration: BoxDecoration(
                        image: image1Url != null
                            ? DecorationImage(
                                image: AssetImage(image1Url!),
                                fit: BoxFit.fill,
                              )
                            : null,
                      ),
                      child: Center(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: redItems.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return Center(
                                child: Container(
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                      image: AssetImage(
                                          PlinkoAssets.plinkogreenbt),
                                    )),
                                    width: 35,
                                    child: Center(
                                        child: Text(
                                      redItems[index].multiplier.toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ))),
                              );
                            }),
                      ),
                    ),
                    Container(
                      height: 35,
                      width: 370,
                      decoration: BoxDecoration(
                        image: image2Url != null
                            ? DecorationImage(
                                image: AssetImage(image2Url!),
                                fit: BoxFit.fill,
                              )
                            : null,
                      ),
                      child: Center(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: greenItems.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return Container(
                                  width: 35,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                    image: AssetImage(PlinkoAssets.plinkoRedbt),
                                  )),
                                  child: Center(
                                      child: Text(
                                    greenItems[index].multiplier.toString(),
                                    style: const TextStyle(color: Colors.red),
                                  )));
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Light> light = [];

  @override
  void dispose() {
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    countdownTimer?.cancel();
    super.dispose();
  }

  /// wallet api
  int? wallet;
  int? wallbal;
  UserViewProvider userProvider = UserViewProvider();

  // walletView() async {
  //   UserModel user = await userProvider.getUser();
  //   String token = user.id.toString();
  //   final response = await http.get(
  //     Uri.parse('${ApiUrl.walletdash}userid=$token'),
  //   );
  //   var data = jsonDecode(response.body);
  //   if (data['error'] == '200') {
  //     setState(() {
  //       final walt = data['data'];
  //       wallet =
  //           (walt['wallet'] == null ? 0 : double.parse(walt['wallet'])).toInt();
  //       wallbal =
  //           (walt['wallet'] == null ? 0 : double.parse(walt['wallet'])).toInt();
  //     });
  //   }
  // }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  Future<void> walletfetch() async {
    try {
      if (kDebugMode) {
        print("qwerfghj");
      }
      final walletData = await baseApiHelper.fetchWalletData();
      if (kDebugMode) {
        print(walletData);
        print("wallet_data");
      }
      Provider.of<WalletProvider>(context, listen: false).setWalletList(walletData!);
    } catch (error) {
      // Handle error here
      if (kDebugMode) {
        print("hiiii $error");
      }
    }
  }

  ///greenList
  List<GreenListModel> greenItems = [];
  Future<void> greenData() async {
    const url = ApiUrl.greenListTable;
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(url);
    }
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        greenItems = responseData.map((item) => GreenListModel.fromJson(item)).toList();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        greenItems = [];
      });
      throw Exception('Failed to load data');
    }
  }

  /// red list
  List<GreenListModel> redItems = [];
  Future<void> redData() async {
    const url = ApiUrl.redListTable;
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(url);
    }
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        redItems =
            responseData.map((item) => GreenListModel.fromJson(item)).toList();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        redItems = [];
      });
      throw Exception('Failed to load data');
    }
  }

  greenBetPlaced(String amount, String greenCode) async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    setState(() {
      loadingGreen = true;

    });
    final response = await http.post(
      Uri.parse(ApiUrl.plinkoBet),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userid": token,
        "amount": amount,
        "Green": greenCode

      }),
    );
    var data = jsonDecode(response.body);
    if (data["error"] == "200") {
      image2Url = null;
      image1Url = PlinkoAssets.plinkoGreenbtnbg;
      ballImg = PlinkoAssets.greenBall;
      // ballFallReq();
      ImageToast.show(
          imagePath: AppAssets.bettingplaceds, heights: 100, context: context);
      setState(() {
        loadingGreen = false;
        betLocked=true;
      });
    } else {
      setState(() {
        loadingGreen = false;
      });
      Utils.flushBarErrorMessage(data['msg'], context, Colors.black);
    }
  }

  redBetPlaced(String amount, String redCode) async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    setState(() {
      loadingRed = true;
    });
    final response = await http.post(
      Uri.parse(ApiUrl.plinkoBet),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userid": token,
        "amount": amount,
        "Green": redCode
      }),
    );
    var data = jsonDecode(response.body);
    if (data["error"] == "200") {
      image1Url = null;
      image2Url = PlinkoAssets.plinkoRedbtnbg;
      ballImg = PlinkoAssets.plinkoRedball;
      // ballFallReq();
      ImageToast.show(
          imagePath: AppAssets.bettingplaceds, heights: 100, context: context);
      setState(() {
        loadingRed = false;
        betLocked=true;
      });
    } else {
      setState(() {
        loadingRed = false;
      });
      Utils.flushBarErrorMessage(data['msg'], context, Colors.black);
    }
  }

  get fallBall => paddingList10e;

  /// paddingList1
  List paddingList1a = [
    {"top": 100.0, "left": 203, "column": 2, "row": 2},
    {"top": 132.0, "left": 188, "column": 3, "row": 2},
    {"top": 165.0, "left": 168, "column": 4, "row": 2},
    {"top": 200.0, "left": 150, "column": 5, "row": 2},
    {"top": 237.0, "left": 133, "column": 6, "row": 2},
    {"top": 267.0, "left": 117, "column": 7, "row": 2},
    {"top": 305.0, "left": 134, "column": 8, "row": 3},
    {"top": 338.0, "left": 116, "column": 9, "row": 3},
    {"top": 370.0, "left": 99, "column": 10, "row": 3},
    {"top": 390.0, "left": 70, "column": 10, "row": 2},
    {"top": 430.0, "left": 30, "column": 10, "row": 2},
  ];
  List paddingList1b = [
    {"top": 105.0, "left": 197, "column": 2, "row": 2},
    {"top": 140.0, "left": 210, "column": 3, "row": 3},
    {"top": 173.0, "left": 196, "column": 4, "row": 3},
    {"top": 205.0, "left": 180, "column": 5, "row": 3},
    {"top": 240.0, "left": 190, "column": 6, "row": 4},
    {"top": 280.0, "left": 177, "column": 7, "row": 4},
    {"top": 275.0, "left": 146, "column": 7, "row": 3},
    {"top": 310.0, "left": 128, "column": 8, "row": 3},
    {"top": 340.0, "left": 110, "column": 9, "row": 3},
    {"top": 340.0, "left": 75, "column": 9, "row": 2},
    {"top": 380.0, "left": 50, "column": 10, "row": 2},
    {"top": 430.0, "left": 30, "column": 11, "row": 1},
  ];
  List paddingList1c = [
    {"top": 132.0, "left": 188, "column": 2, "row": 2},
    {"top": 140.0, "left": 175, "column": 3, "row": 2},
    {"top": 140.0, "left": 128, "column": 3, "row": 1},
    {"top": 173.0, "left": 133, "column": 4, "row": 1},
    {"top": 205.0, "left": 145, "column": 5, "row": 2},
    {"top": 240.0, "left": 155, "column": 6, "row": 3},
    {"top": 275.0, "left": 143, "column": 7, "row": 3},
    {"top": 295.0, "left": 110, "column": 7, "row": 2},
    {"top": 310.0, "left": 90, "column": 8, "row": 2},
    {"top": 330.0, "left": 65, "column": 8, "row": 1},
    {"top": 340.0, "left": 75, "column": 9, "row": 2},
    {"top": 430.0, "left": 35, "column": 10, "row": 2},
  ];
  List paddingList1d = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 142.0, "left": 210, "column": 3, "row": 3},
    {"top": 175.0, "left": 220, "column": 4, "row": 4},
    {"top": 205.0, "left": 215, "column": 5, "row": 4},
    {"top": 240.0, "left": 200, "column": 6, "row": 4},
    {"top": 277.0, "left": 180, "column": 7, "row": 4},
    {"top": 274.0, "left": 147, "column": 7, "row": 3},
    {"top": 310.0, "left": 130, "column": 8, "row": 3},
    {"top": 345.0, "left": 110, "column": 9, "row": 3},
    {"top": 345.0, "left": 78, "column": 9, "row": 2},
    {"top": 375.0, "left": 60, "column": 10, "row": 2},
    {"top": 430.0, "left": 40, "column": 11, "row": 0},
  ];
  List paddingList1e = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 140.0, "left": 180, "column": 3, "row": 2},
    {"top": 158.0, "left": 195, "column": 3, "row": 3},
    {"top": 175.0, "left": 190, "column": 4, "row": 3},
    {"top": 195.0, "left": 160, "column": 4, "row": 2},
    {"top": 205.0, "left": 140, "column": 5, "row": 2},
    {"top": 240.0, "left": 130, "column": 6, "row": 2},
    {"top": 275.0, "left": 110, "column": 7, "row": 2},
    {"top": 310.0, "left": 120, "column": 8, "row": 3},
    {"top": 330.0, "left": 90, "column": 8, "row": 2},
    {"top": 340.0, "left": 75, "column": 9, "row": 2},
    {"top": 378.0, "left": 60, "column": 10, "row": 2},
    {"top": 430.0, "left": 40, "column": 11, "row": 0},
  ];

  /// paddingList2
  List paddingList2a = [
    {"top": 105.0, "left": 200, "column": 2, "row": 2},
    {"top": 140.0, "left": 210, "column": 3, "row": 3},
    {"top": 190.0, "left": 210, "column": 4, "row": 3},
    {"top": 205.0, "left": 215, "column": 5, "row": 4},
    {"top": 220.0, "left": 190, "column": 5, "row": 3},
    {"top": 255.0, "left": 165, "column": 6, "row": 3},
    {"top": 280.0, "left": 145, "column": 7, "row": 3},
    {"top": 295.0, "left": 120, "column": 7, "row": 2},
    {"top": 310.0, "left": 125, "column": 8, "row": 3},
    {"top": 340.0, "left": 110, "column": 9, "row": 3},
    {"top": 375.0, "left": 90, "column": 10, "row": 3},
    {"top": 430.0, "left": 75, "column": 11, "row": 0},
  ];
  List paddingList2b = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 140.0, "left": 210, "column": 3, "row": 3},
    {"top": 180.0, "left": 200, "column": 4, "row": 3},
    {"top": 185.0, "left": 175, "column": 4, "row": 2},
    {"top": 220.0, "left": 190, "column": 5, "row": 3},
    {"top": 240.0, "left": 195, "column": 6, "row": 4},
    {"top": 280.0, "left": 190, "column": 7, "row": 4},
    {"top": 285.0, "left": 145, "column": 7, "row": 3},
    {"top": 320.0, "left": 125, "column": 8, "row": 3},
    {"top": 360.0, "left": 100, "column": 9, "row": 3},
    {"top": 375.0, "left": 90, "column": 10, "row": 3},
    {"top": 430.0, "left": 75, "column": 11, "row": 0},
  ];
  List paddingList2c = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 150.0, "left": 185, "column": 3, "row": 2},
    {"top": 175.0, "left": 195, "column": 4, "row": 3},
    {"top": 210.0, "left": 180, "column": 5, "row": 3},
    {"top": 215.0, "left": 145, "column": 5, "row": 2},
    {"top": 240.0, "left": 160, "column": 6, "row": 3},
    {"top": 290.0, "left": 140, "column": 7, "row": 3},
    {"top": 310.0, "left": 125, "column": 8, "row": 3},
    {"top": 350.0, "left": 105, "column": 9, "row": 3},
    {"top": 365.0, "left": 80, "column": 9, "row": 2},
    {"top": 380.0, "left": 90, "column": 10, "row": 3},
    {"top": 430.0, "left": 70, "column": 11, "row": 0},
  ];
  List paddingList2d = [
    {"top": 105.0, "left": 200, "column": 2, "row": 2},
    {"top": 160.0, "left": 190, "column": 3, "row": 2},
    {"top": 185.0, "left": 210, "column": 4, "row": 3},
    {"top": 220.0, "left": 220, "column": 5, "row": 4},
    {"top": 245.0, "left": 230, "column": 6, "row": 5},
    {"top": 295.0, "left": 220, "column": 7, "row": 5},
    {"top": 295.0, "left": 180, "column": 7, "row": 4},
    {"top": 290.0, "left": 150, "column": 7, "row": 3},
    {"top": 310.0, "left": 130, "column": 8, "row": 3},
    {"top": 340.0, "left": 110, "column": 9, "row": 3},
    {"top": 380.0, "left": 90, "column": 10, "row": 3},
    {"top": 430.0, "left": 70, "column": 11, "row": 0},
  ];
  List paddingList2e = [
    {"top": 105.0, "left": 200, "column": 2, "row": 2},
    {"top": 155.0, "left": 180, "column": 3, "row": 2},
    {"top": 160.0, "left": 150, "column": 3, "row": 1},
    {"top": 185.0, "left": 160, "column": 4, "row": 2},
    {"top": 220.0, "left": 170, "column": 5, "row": 3},
    {"top": 240.0, "left": 160, "column": 6, "row": 3},
    {"top": 250.0, "left": 130, "column": 6, "row": 2},
    {"top": 275.0, "left": 110, "column": 7, "row": 2},
    {"top": 320.0, "left": 100, "column": 8, "row": 2},
    {"top": 355.0, "left": 80, "column": 9, "row": 2},
    {"top": 378.0, "left": 60, "column": 10, "row": 2},
    {"top": 430.0, "left": 75, "column": 11, "row": 0},
  ];

  /// paddingList3
  List paddingList3a = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 110.0, "left": 170, "column": 2, "row": 1},
    {"top": 150.0, "left": 185, "column": 3, "row": 2},
    {"top": 140.0, "left": 200, "column": 3, "row": 3},
    {"top": 185.0, "left": 195, "column": 4, "row": 3},
    {"top": 220.0, "left": 170, "column": 5, "row": 3},
    {"top": 240.0, "left": 160, "column": 6, "row": 3},
    {"top": 290.0, "left": 140, "column": 7, "row": 3},
    {"top": 310.0, "left": 130, "column": 8, "row": 3},
    {"top": 340.0, "left": 105, "column": 9, "row": 3},
    {"top": 380.0, "left": 110, "column": 10, "row": 4},
    {"top": 430.0, "left": 115, "column": 11, "row": 0},
  ];
  List paddingList3b = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 140.0, "left": 210, "column": 3, "row": 3},
    {"top": 150.0, "left": 250, "column": 3, "row": 4},
    {"top": 175.0, "left": 225, "column": 4, "row": 4},
    {"top": 210.0, "left": 205, "column": 5, "row": 4},
    {"top": 215.0, "left": 180, "column": 5, "row": 3},
    {"top": 240.0, "left": 195, "column": 6, "row": 4},
    {"top": 280.0, "left": 180, "column": 7, "row": 4},
    {"top": 310.0, "left": 165, "column": 8, "row": 4},
    {"top": 350.0, "left": 140, "column": 9, "row": 4},
    {"top": 370.0, "left": 125, "column": 10, "row": 4},
    {"top": 430.0, "left": 110, "column": 11, "row": 0},
  ];
  List paddingList3c = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 140.0, "left": 185, "column": 3, "row": 2},
    {"top": 140.0, "left": 210, "column": 3, "row": 3},
    {"top": 175.0, "left": 195, "column": 4, "row": 3},
    {"top": 220.0, "left": 170, "column": 5, "row": 3},
    {"top": 215.0, "left": 145, "column": 5, "row": 2},
    {"top": 240.0, "left": 160, "column": 6, "row": 3},
    {"top": 290.0, "left": 140, "column": 7, "row": 3},
    {"top": 310.0, "left": 130, "column": 8, "row": 3},
    {"top": 350.0, "left": 140, "column": 9, "row": 4},
    {"top": 370.0, "left": 125, "column": 10, "row": 4},
    {"top": 430.0, "left": 110, "column": 11, "row": 0},
  ];
  List paddingList3d = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 110.0, "left": 170, "column": 2, "row": 1},
    {"top": 150.0, "left": 185, "column": 3, "row": 2},
    {"top": 175.0, "left": 195, "column": 4, "row": 3},
    {"top": 220.0, "left": 190, "column": 5, "row": 3},
    {"top": 240.0, "left": 185, "column": 6, "row": 4},
    {"top": 280.0, "left": 190, "column": 7, "row": 4},
    {"top": 285.0, "left": 145, "column": 7, "row": 3},
    {"top": 310.0, "left": 165, "column": 8, "row": 4},
    {"top": 350.0, "left": 140, "column": 9, "row": 4},
    {"top": 370.0, "left": 125, "column": 10, "row": 4},
    {"top": 430.0, "left": 110, "column": 11, "row": 0},
  ];
  List paddingList3e = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 110.0, "left": 215, "column": 2, "row": 3},
    {"top": 140.0, "left": 210, "column": 3, "row": 3},
    {"top": 180.0, "left": 200, "column": 4, "row": 3},
    {"top": 185.0, "left": 170, "column": 4, "row": 2},
    {"top": 220.0, "left": 190, "column": 5, "row": 3},
    {"top": 240.0, "left": 195, "column": 6, "row": 4},
    {"top": 280.0, "left": 190, "column": 7, "row": 4},
    {"top": 310.0, "left": 165, "column": 8, "row": 4},
    {"top": 350.0, "left": 140, "column": 9, "row": 4},
    {"top": 370.0, "left": 125, "column": 10, "row": 4},
    {"top": 430.0, "left": 110, "column": 11, "row": 0},
  ];

  /// paddingList4
  List paddingList4a = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 110.0, "left": 170, "column": 2, "row": 1},
    {"top": 150.0, "left": 185, "column": 3, "row": 2},
    {"top": 140.0, "left": 200, "column": 3, "row": 3},
    {"top": 175.0, "left": 225, "column": 4, "row": 4},
    {"top": 210.0, "left": 205, "column": 5, "row": 4},
    {"top": 240.0, "left": 195, "column": 6, "row": 4},
    {"top": 280.0, "left": 190, "column": 7, "row": 4},
    {"top": 310.0, "left": 200, "column": 8, "row": 5},
    {"top": 340.0, "left": 180, "column": 9, "row": 5},
    {"top": 380.0, "left": 160, "column": 10, "row": 5},
    {"top": 430.0, "left": 150, "column": 11, "row": 0},
  ];
  List paddingList4b = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 150.0, "left": 185, "column": 3, "row": 2},
    {"top": 180.0, "left": 200, "column": 4, "row": 3},
    {"top": 210.0, "left": 205, "column": 5, "row": 4},
    {"top": 215.0, "left": 180, "column": 5, "row": 3},
    {"top": 240.0, "left": 195, "column": 6, "row": 4},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 280.0, "left": 200, "column": 7, "row": 5},
    {"top": 310.0, "left": 200, "column": 8, "row": 5},
    {"top": 340.0, "left": 180, "column": 9, "row": 5},
    {"top": 380.0, "left": 160, "column": 10, "row": 5},
    {"top": 430.0, "left": 150, "column": 11, "row": 0},
  ];
  List paddingList4c = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 140.0, "left": 210, "column": 3, "row": 3},
    {"top": 175.0, "left": 225, "column": 4, "row": 4},
    {"top": 210.0, "left": 205, "column": 5, "row": 4},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 255.0, "left": 250, "column": 6, "row": 6},
    {"top": 290.0, "left": 240, "column": 7, "row": 6},
    {"top": 280.0, "left": 200, "column": 7, "row": 5},
    {"top": 310.0, "left": 200, "column": 8, "row": 5},
    {"top": 340.0, "left": 180, "column": 9, "row": 5},
    {"top": 380.0, "left": 160, "column": 10, "row": 5},
    {"top": 430.0, "left": 150, "column": 11, "row": 0},
  ];
  List paddingList4d = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 110.0, "left": 170, "column": 2, "row": 1},
    {"top": 150.0, "left": 185, "column": 3, "row": 2},
    {"top": 175.0, "left": 195, "column": 4, "row": 3},
    {"top": 210.0, "left": 205, "column": 5, "row": 4},
    {"top": 240.0, "left": 185, "column": 6, "row": 4},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 280.0, "left": 200, "column": 7, "row": 5},
    {"top": 310.0, "left": 200, "column": 8, "row": 5},
    {"top": 340.0, "left": 180, "column": 9, "row": 5},
    {"top": 380.0, "left": 160, "column": 10, "row": 5},
    {"top": 430.0, "left": 150, "column": 11, "row": 0},
  ];
  List paddingList4e = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 140.0, "left": 210, "column": 3, "row": 3},
    {"top": 175.0, "left": 225, "column": 4, "row": 4},
    {"top": 210.0, "left": 205, "column": 5, "row": 4},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 240.0, "left": 195, "column": 6, "row": 4},
    {"top": 280.0, "left": 190, "column": 7, "row": 4},
    {"top": 280.0, "left": 200, "column": 7, "row": 5},
    {"top": 310.0, "left": 200, "column": 8, "row": 5},
    {"top": 340.0, "left": 180, "column": 9, "row": 5},
    {"top": 380.0, "left": 160, "column": 10, "row": 5},
    {"top": 430.0, "left": 150, "column": 11, "row": 0},
  ];
  List paddingList4f = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 140.0, "left": 210, "column": 3, "row": 3},
    {"top": 175.0, "left": 225, "column": 4, "row": 4},
    {"top": 210.0, "left": 205, "column": 5, "row": 4},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 240.0, "left": 195, "column": 6, "row": 4},
    {"top": 280.0, "left": 190, "column": 7, "row": 4},
    {"top": 280.0, "left": 200, "column": 7, "row": 5},
    {"top": 310.0, "left": 165, "column": 8, "row": 4},
    {"top": 350.0, "left": 140, "column": 9, "row": 4},
    {"top": 380.0, "left": 160, "column": 10, "row": 5},
    {"top": 430.0, "left": 150, "column": 11, "row": 0},
  ];
  List paddingList4g = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 150.0, "left": 185, "column": 3, "row": 2},
    {"top": 175.0, "left": 195, "column": 4, "row": 3},
    {"top": 175.0, "left": 225, "column": 4, "row": 4},
    {"top": 210.0, "left": 205, "column": 5, "row": 4},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 280.0, "left": 200, "column": 7, "row": 5},
    {"top": 280.0, "left": 180, "column": 7, "row": 4},
    {"top": 310.0, "left": 165, "column": 8, "row": 4},
    {"top": 350.0, "left": 140, "column": 9, "row": 4},
    {"top": 380.0, "left": 160, "column": 10, "row": 5},
    {"top": 430.0, "left": 150, "column": 11, "row": 0},
  ];
  List paddingList4h = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 140.0, "left": 210, "column": 3, "row": 3},
    {"top": 150.0, "left": 250, "column": 3, "row": 4},
    {"top": 175.0, "left": 225, "column": 4, "row": 4},
    {"top": 175.0, "left": 195, "column": 4, "row": 3},
    {"top": 210.0, "left": 205, "column": 5, "row": 4},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 280.0, "left": 200, "column": 7, "row": 5},
    {"top": 310.0, "left": 200, "column": 8, "row": 5},
    {"top": 340.0, "left": 180, "column": 9, "row": 5},
    {"top": 380.0, "left": 160, "column": 10, "row": 5},
    {"top": 430.0, "left": 150, "column": 11, "row": 0},
  ];
  List paddingList4i = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 160.0, "left": 190, "column": 3, "row": 2},
    {"top": 185.0, "left": 210, "column": 4, "row": 3},
    {"top": 175.0, "left": 225, "column": 4, "row": 4},
    {"top": 185.0, "left": 250, "column": 4, "row": 5},
    {"top": 220.0, "left": 235, "column": 5, "row": 5},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 280.0, "left": 200, "column": 7, "row": 5},
    {"top": 310.0, "left": 200, "column": 8, "row": 5},
    {"top": 340.0, "left": 180, "column": 9, "row": 5},
    {"top": 380.0, "left": 160, "column": 10, "row": 5},
    {"top": 430.0, "left": 150, "column": 11, "row": 0},
  ];
  List paddingList4j = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 140.0, "left": 210, "column": 3, "row": 3},
    {"top": 150.0, "left": 250, "column": 3, "row": 4},
    {"top": 175.0, "left": 225, "column": 4, "row": 4},
    {"top": 175.0, "left": 195, "column": 4, "row": 3},
    {"top": 210.0, "left": 205, "column": 5, "row": 4},
    {"top": 240.0, "left": 195, "column": 6, "row": 4},
    {"top": 280.0, "left": 190, "column": 7, "row": 4},
    {"top": 310.0, "left": 200, "column": 8, "row": 5},
    {"top": 340.0, "left": 180, "column": 9, "row": 5},
    {"top": 380.0, "left": 160, "column": 10, "row": 5},
    {"top": 430.0, "left": 150, "column": 11, "row": 0},
  ];

  /// paddingList5
  List paddingList5a = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 150.0, "left": 185, "column": 3, "row": 2},
    {"top": 180.0, "left": 210, "column": 4, "row": 3},
    {"top": 210.0, "left": 225, "column": 5, "row": 4},
    {"top": 240.0, "left": 200, "column": 6, "row": 4},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 280.0, "left": 250, "column": 7, "row": 6},
    {"top": 310.0, "left": 235, "column": 8, "row": 6},
    {"top": 340.0, "left": 215, "column": 9, "row": 6},
    {"top": 380.0, "left": 200, "column": 10, "row": 6},
    {"top": 430.0, "left": 190, "column": 11, "row": 0},
  ];
  List paddingList5b = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 140.0, "left": 220, "column": 3, "row": 3},
    {"top": 175.0, "left": 245, "column": 4, "row": 4},
    {"top": 210.0, "left": 255, "column": 5, "row": 5},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 280.0, "left": 220, "column": 7, "row": 5},
    {"top": 280.0, "left": 250, "column": 7, "row": 6},
    {"top": 310.0, "left": 230, "column": 8, "row": 6},
    {"top": 340.0, "left": 245, "column": 9, "row": 7},
    {"top": 350.0, "left": 210, "column": 9, "row": 6},
    {"top": 380.0, "left": 200, "column": 10, "row": 6},
    {"top": 430.0, "left": 200, "column": 11, "row": 0},
  ];
  List paddingList5c = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 140.0, "left": 220, "column": 3, "row": 3},
    {"top": 175.0, "left": 235, "column": 4, "row": 4},
    {"top": 210.0, "left": 225, "column": 5, "row": 4},
    {"top": 220.0, "left": 255, "column": 5, "row": 5},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 255.0, "left": 260, "column": 6, "row": 6},
    {"top": 290.0, "left": 250, "column": 7, "row": 6},
    {"top": 310.0, "left": 230, "column": 8, "row": 6},
    {"top": 340.0, "left": 210, "column": 9, "row": 6},
    {"top": 380.0, "left": 190, "column": 10, "row": 6},
    {"top": 430.0, "left": 200, "column": 11, "row": 0},
  ];
  List paddingList5d = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 150.0, "left": 185, "column": 3, "row": 2},
    {"top": 180.0, "left": 210, "column": 4, "row": 3},
    {"top": 175.0, "left": 235, "column": 4, "row": 4},
    {"top": 210.0, "left": 225, "column": 5, "row": 4},
    {"top": 240.0, "left": 200, "column": 6, "row": 4},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 290.0, "left": 250, "column": 7, "row": 6},
    {"top": 310.0, "left": 230, "column": 8, "row": 6},
    {"top": 340.0, "left": 200, "column": 9, "row": 6},
    {"top": 380.0, "left": 210, "column": 10, "row": 6},
    {"top": 430.0, "left": 200, "column": 11, "row": 0},
  ];
  List paddingList5e = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 150.0, "left": 185, "column": 3, "row": 2},
    {"top": 155.0, "left": 220, "column": 3, "row": 3},
    {"top": 175.0, "left": 230, "column": 4, "row": 4},
    {"top": 210.0, "left": 225, "column": 5, "row": 4},
    {"top": 240.0, "left": 200, "column": 6, "row": 4},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 290.0, "left": 250, "column": 7, "row": 6},
    {"top": 310.0, "left": 240, "column": 8, "row": 6},
    {"top": 340.0, "left": 220, "column": 9, "row": 6},
    {"top": 380.0, "left": 195, "column": 10, "row": 6},
    {"top": 430.0, "left": 190, "column": 11, "row": 0},
  ];
  List paddingList5f = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 140.0, "left": 215, "column": 3, "row": 3},
    {"top": 175.0, "left": 240, "column": 4, "row": 4},
    {"top": 210.0, "left": 265, "column": 5, "row": 5},
    {"top": 255.0, "left": 260, "column": 6, "row": 6},
    {"top": 290.0, "left": 250, "column": 7, "row": 6},
    {"top": 310.0, "left": 230, "column": 8, "row": 6},
    {"top": 320.0, "left": 210, "column": 8, "row": 5},
    {"top": 340.0, "left": 225, "column": 9, "row": 6},
    {"top": 380.0, "left": 195, "column": 10, "row": 6},
    {"top": 430.0, "left": 190, "column": 11, "row": 0},
  ];
  List paddingList5g = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 140.0, "left": 215, "column": 3, "row": 3},
    {"top": 175.0, "left": 240, "column": 4, "row": 4},
    {"top": 210.0, "left": 225, "column": 5, "row": 4},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 255.0, "left": 260, "column": 6, "row": 6},
    {"top": 290.0, "left": 250, "column": 7, "row": 6},
    {"top": 310.0, "left": 230, "column": 8, "row": 6},
    {"top": 320.0, "left": 210, "column": 8, "row": 5},
    {"top": 340.0, "left": 225, "column": 9, "row": 6},
    {"top": 380.0, "left": 195, "column": 10, "row": 6},
    {"top": 430.0, "left": 190, "column": 11, "row": 0},
  ];
  List paddingList5h = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 105.0, "left": 230, "column": 2, "row": 3},
    {"top": 140.0, "left": 215, "column": 3, "row": 3},
    {"top": 175.0, "left": 240, "column": 4, "row": 4},
    {"top": 185.0, "left": 250, "column": 4, "row": 5},
    {"top": 220.0, "left": 235, "column": 5, "row": 5},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 250.0, "left": 260, "column": 6, "row": 6},
    {"top": 280.0, "left": 250, "column": 7, "row": 6},
    {"top": 310.0, "left": 230, "column": 8, "row": 6},
    {"top": 340.0, "left": 225, "column": 9, "row": 6},
    {"top": 380.0, "left": 195, "column": 10, "row": 6},
    {"top": 430.0, "left": 190, "column": 11, "row": 0},
  ];
  List paddingList5i = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 140.0, "left": 215, "column": 3, "row": 3},
    {"top": 175.0, "left": 240, "column": 4, "row": 4},
    {"top": 220.0, "left": 235, "column": 5, "row": 5},
    {"top": 250.0, "left": 260, "column": 6, "row": 6},
    {"top": 280.0, "left": 250, "column": 7, "row": 6},
    {"top": 310.0, "left": 230, "column": 8, "row": 6},
    {"top": 340.0, "left": 245, "column": 9, "row": 7},
    {"top": 350.0, "left": 225, "column": 9, "row": 6},
    {"top": 380.0, "left": 195, "column": 10, "row": 6},
    {"top": 430.0, "left": 190, "column": 11, "row": 0},
  ];
  List paddingList5j = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 140.0, "left": 210, "column": 3, "row": 3},
    {"top": 175.0, "left": 225, "column": 4, "row": 4},
    {"top": 220.0, "left": 235, "column": 5, "row": 5},
    {"top": 255.0, "left": 250, "column": 6, "row": 6},
    {"top": 290.0, "left": 240, "column": 7, "row": 6},
    {"top": 310.0, "left": 230, "column": 8, "row": 6},
    {"top": 320.0, "left": 210, "column": 8, "row": 5},
    {"top": 350.0, "left": 225, "column": 9, "row": 6},
    {"top": 380.0, "left": 195, "column": 10, "row": 6},
    {"top": 430.0, "left": 190, "column": 11, "row": 0},
  ];

  /// paddingList6
  List paddingList6a = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 150.0, "left": 185, "column": 3, "row": 2},
    {"top": 180.0, "left": 210, "column": 4, "row": 3},
    {"top": 210.0, "left": 225, "column": 5, "row": 4},
    {"top": 240.0, "left": 200, "column": 6, "row": 4},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 280.0, "left": 250, "column": 7, "row": 6},
    {"top": 310.0, "left": 235, "column": 8, "row": 6},
    {"top": 340.0, "left": 215, "column": 9, "row": 6},
    {"top": 380.0, "left": 230, "column": 10, "row": 7},
    {"top": 430.0, "left": 225, "column": 11, "row": 0},
  ];
  List paddingList6b = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 140.0, "left": 220, "column": 3, "row": 3},
    {"top": 175.0, "left": 245, "column": 4, "row": 4},
    {"top": 210.0, "left": 255, "column": 5, "row": 5},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 280.0, "left": 220, "column": 7, "row": 5},
    {"top": 280.0, "left": 250, "column": 7, "row": 6},
    {"top": 310.0, "left": 230, "column": 8, "row": 6},
    {"top": 320.0, "left": 260, "column": 8, "row": 7},
    {"top": 340.0, "left": 245, "column": 9, "row": 7},
    {"top": 380.0, "left": 240, "column": 10, "row": 7},
    {"top": 430.0, "left": 230, "column": 11, "row": 0},
  ];
  List paddingList6c = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 140.0, "left": 220, "column": 3, "row": 3},
    {"top": 150.0, "left": 240, "column": 3, "row": 4},
    {"top": 175.0, "left": 235, "column": 4, "row": 4},
    {"top": 210.0, "left": 205, "column": 5, "row": 4},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 255.0, "left": 260, "column": 6, "row": 6},
    {"top": 290.0, "left": 270, "column": 7, "row": 7},
    {"top": 320.0, "left": 260, "column": 8, "row": 7},
    {"top": 340.0, "left": 245, "column": 9, "row": 7},
    {"top": 380.0, "left": 240, "column": 10, "row": 7},
    {"top": 430.0, "left": 220, "column": 11, "row": 0},
  ];
  List paddingList6d = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 150.0, "left": 185, "column": 3, "row": 2},
    {"top": 180.0, "left": 200, "column": 4, "row": 3},
    {"top": 210.0, "left": 205, "column": 5, "row": 4},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 255.0, "left": 260, "column": 6, "row": 6},
    {"top": 260.0, "left": 290, "column": 6, "row": 7},
    {"top": 290.0, "left": 270, "column": 7, "row": 7},
    {"top": 320.0, "left": 260, "column": 8, "row": 7},
    {"top": 340.0, "left": 245, "column": 9, "row": 7},
    {"top": 380.0, "left": 240, "column": 10, "row": 7},
    {"top": 430.0, "left": 220, "column": 11, "row": 0},
  ];
  List paddingList6e = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 110.0, "left": 170, "column": 2, "row": 1},
    {"top": 150.0, "left": 185, "column": 3, "row": 2},
    {"top": 180.0, "left": 200, "column": 4, "row": 3},
    {"top": 210.0, "left": 205, "column": 5, "row": 4},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 280.0, "left": 250, "column": 7, "row": 6},
    {"top": 320.0, "left": 260, "column": 8, "row": 7},
    {"top": 340.0, "left": 245, "column": 9, "row": 7},
    {"top": 380.0, "left": 240, "column": 10, "row": 7},
    {"top": 430.0, "left": 220, "column": 11, "row": 0},
  ];
  List paddingList6f = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 140.0, "left": 210, "column": 3, "row": 3},
    {"top": 180.0, "left": 200, "column": 4, "row": 3},
    {"top": 175.0, "left": 235, "column": 4, "row": 4},
    {"top": 180.0, "left": 260, "column": 4, "row": 5},
    {"top": 220.0, "left": 235, "column": 5, "row": 5},
    {"top": 255.0, "left": 260, "column": 6, "row": 6},
    {"top": 290.0, "left": 270, "column": 7, "row": 7},
    {"top": 320.0, "left": 260, "column": 8, "row": 7},
    {"top": 340.0, "left": 245, "column": 9, "row": 7},
    {"top": 380.0, "left": 240, "column": 10, "row": 7},
    {"top": 430.0, "left": 220, "column": 11, "row": 0},
  ];
  List paddingList6g = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 150.0, "left": 185, "column": 3, "row": 2},
    {"top": 180.0, "left": 200, "column": 4, "row": 3},
    {"top": 210.0, "left": 205, "column": 5, "row": 4},
    {"top": 240.0, "left": 200, "column": 6, "row": 4},
    {"top": 280.0, "left": 220, "column": 7, "row": 5},
    {"top": 310.0, "left": 230, "column": 8, "row": 6},
    {"top": 340.0, "left": 245, "column": 9, "row": 7},
    {"top": 380.0, "left": 240, "column": 10, "row": 7},
    {"top": 430.0, "left": 220, "column": 11, "row": 0},
  ];
  List paddingList6h = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 110.0, "left": 215, "column": 2, "row": 3},
    {"top": 140.0, "left": 210, "column": 3, "row": 3},
    {"top": 180.0, "left": 200, "column": 4, "row": 3},
    {"top": 215.0, "left": 180, "column": 5, "row": 3},
    {"top": 240.0, "left": 160, "column": 6, "row": 3},
    {"top": 280.0, "left": 190, "column": 7, "row": 4},
    {"top": 310.0, "left": 200, "column": 8, "row": 5},
    {"top": 340.0, "left": 210, "column": 9, "row": 6},
    {"top": 380.0, "left": 232, "column": 10, "row": 7},
    {"top": 430.0, "left": 220, "column": 11, "row": 0},
  ];
  List paddingList6i = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 140.0, "left": 210, "column": 3, "row": 3},
    {"top": 180.0, "left": 200, "column": 4, "row": 3},
    {"top": 215.0, "left": 180, "column": 5, "row": 3},
    {"top": 240.0, "left": 160, "column": 6, "row": 3},
    {"top": 290.0, "left": 140, "column": 7, "row": 3},
    {"top": 280.0, "left": 190, "column": 7, "row": 4},
    {"top": 310.0, "left": 200, "column": 8, "row": 5},
    {"top": 340.0, "left": 210, "column": 9, "row": 6},
    {"top": 380.0, "left": 232, "column": 10, "row": 7},
    {"top": 430.0, "left": 220, "column": 11, "row": 0},
  ];
  List paddingList6j = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 140.0, "left": 210, "column": 3, "row": 3},
    {"top": 175.0, "left": 225, "column": 4, "row": 4},
    {"top": 220.0, "left": 235, "column": 5, "row": 5},
    {"top": 255.0, "left": 250, "column": 6, "row": 6},
    {"top": 290.0, "left": 240, "column": 7, "row": 6},
    {"top": 290.0, "left": 270, "column": 7, "row": 7},
    {"top": 320.0, "left": 260, "column": 8, "row": 7},
    {"top": 340.0, "left": 245, "column": 9, "row": 7},
    {"top": 380.0, "left": 240, "column": 10, "row": 7},
    {"top": 430.0, "left": 220, "column": 11, "row": 0},
  ];

  ///paddingLiat7
  List paddingList7a = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 150.0, "left": 185, "column": 3, "row": 2},
    {"top": 180.0, "left": 210, "column": 4, "row": 3},
    {"top": 210.0, "left": 225, "column": 5, "row": 4},
    {"top": 240.0, "left": 200, "column": 6, "row": 4},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 280.0, "left": 255, "column": 7, "row": 6},
    {"top": 310.0, "left": 260, "column": 8, "row": 6},
    {"top": 340.0, "left": 265, "column": 9, "row": 7},
    {"top": 380.0, "left": 270, "column": 10, "row": 8},
    {"top": 430.0, "left": 245, "column": 11, "row": 0},
  ];
  List paddingList7b = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 105.0, "left": 230, "column": 2, "row": 3},
    {"top": 150.0, "left": 250, "column": 3, "row": 4},
    {"top": 175.0, "left": 245, "column": 4, "row": 4},
    {"top": 210.0, "left": 255, "column": 5, "row": 5},
    {"top": 250.0, "left": 235, "column": 6, "row": 5},
    {"top": 290.0, "left": 245, "column": 7, "row": 6},
    {"top": 290.0, "left": 290, "column": 7, "row": 7},
    {"top": 310.0, "left": 295, "column": 8, "row": 8},
    {"top": 340.0, "left": 280, "column": 9, "row": 8},
    {"top": 380.0, "left": 270, "column": 10, "row": 8},
    {"top": 430.0, "left": 245, "column": 11, "row": 0},
  ];
  List paddingList7c = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 150.0, "left": 185, "column": 3, "row": 2},
    {"top": 185.0, "left": 175, "column": 4, "row": 2},
    {"top": 215.0, "left": 180, "column": 5, "row": 3},
    {"top": 240.0, "left": 200, "column": 6, "row": 4},
    {"top": 280.0, "left": 220, "column": 7, "row": 5},
    {"top": 280.0, "left": 250, "column": 7, "row": 6},
    {"top": 320.0, "left": 260, "column": 8, "row": 7},
    {"top": 340.0, "left": 245, "column": 9, "row": 7},
    {"top": 380.0, "left": 270, "column": 10, "row": 8},
    {"top": 430.0, "left": 245, "column": 11, "row": 0},
  ];
  List paddingList7d = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 120.0, "left": 170, "column": 2, "row": 1},
    {"top": 150.0, "left": 185, "column": 3, "row": 2},
    {"top": 180.0, "left": 210, "column": 4, "row": 3},
    {"top": 210.0, "left": 215, "column": 5, "row": 4},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 280.0, "left": 215, "column": 7, "row": 5},
    {"top": 310.0, "left": 230, "column": 8, "row": 6},
    {"top": 340.0, "left": 245, "column": 9, "row": 7},
    {"top": 360.0, "left": 280, "column": 9, "row": 8},
    {"top": 380.0, "left": 270, "column": 10, "row": 8},
    {"top": 430.0, "left": 245, "column": 11, "row": 0},
  ];
  List paddingList7e = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 140.0, "left": 220, "column": 3, "row": 3},
    {"top": 175.0, "left": 245, "column": 4, "row": 4},
    {"top": 210.0, "left": 255, "column": 5, "row": 5},
    {"top": 220.0, "left": 275, "column": 5, "row": 6},
    {"top": 255.0, "left": 250, "column": 6, "row": 6},
    {"top": 290.0, "left": 270, "column": 7, "row": 7},
    {"top": 320.0, "left": 260, "column": 8, "row": 7},
    {"top": 360.0, "left": 280, "column": 9, "row": 8},
    {"top": 380.0, "left": 270, "column": 10, "row": 8},
    {"top": 430.0, "left": 245, "column": 11, "row": 0},
  ];
  List paddingList7f = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 140.0, "left": 220, "column": 3, "row": 3},
    {"top": 175.0, "left": 245, "column": 4, "row": 4},
    {"top": 210.0, "left": 255, "column": 5, "row": 5},
    {"top": 220.0, "left": 275, "column": 5, "row": 6},
    {"top": 255.0, "left": 250, "column": 6, "row": 6},
    {"top": 290.0, "left": 270, "column": 7, "row": 7},
    {"top": 320.0, "left": 260, "column": 8, "row": 7},
    {"top": 360.0, "left": 240, "column": 9, "row": 7},
    {"top": 380.0, "left": 240, "column": 10, "row": 7},
    {"top": 430.0, "left": 245, "column": 11, "row": 0},
  ];

  /// paddingList8
  List paddingList8a = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 150.0, "left": 185, "column": 3, "row": 2},
    {"top": 180.0, "left": 200, "column": 4, "row": 3},
    {"top": 210.0, "left": 225, "column": 5, "row": 4},
    {"top": 240.0, "left": 200, "column": 6, "row": 4},
    {"top": 250.0, "left": 225, "column": 6, "row": 5},
    {"top": 280.0, "left": 250, "column": 7, "row": 6},
    {"top": 310.0, "left": 240, "column": 8, "row": 6},
    {"top": 310.0, "left": 280, "column": 8, "row": 7},
    {"top": 330.0, "left": 290, "column": 9, "row": 8},
    {"top": 370.0, "left": 285, "column": 10, "row": 9},
    {"top": 430.0, "left": 275, "column": 11, "row": 0},
  ];
  List paddingList8b = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 140.0, "left": 220, "column": 3, "row": 3},
    {"top": 175.0, "left": 245, "column": 4, "row": 4},
    {"top": 210.0, "left": 255, "column": 5, "row": 5},
    {"top": 255.0, "left": 250, "column": 6, "row": 6},
    {"top": 290.0, "left": 290, "column": 7, "row": 7},
    {"top": 310.0, "left": 270, "column": 8, "row": 7},
    {"top": 330.0, "left": 290, "column": 9, "row": 8},
    {"top": 370.0, "left": 285, "column": 10, "row": 9},
    {"top": 430.0, "left": 275, "column": 11, "row": 0},
  ];
  List paddingList8c = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 150.0, "left": 185, "column": 3, "row": 2},
    {"top": 180.0, "left": 200, "column": 4, "row": 3},
    {"top": 210.0, "left": 205, "column": 5, "row": 4},
    {"top": 240.0, "left": 195, "column": 6, "row": 4},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 255.0, "left": 250, "column": 6, "row": 6},
    {"top": 290.0, "left": 290, "column": 7, "row": 7},
    {"top": 310.0, "left": 270, "column": 8, "row": 7},
    {"top": 330.0, "left": 290, "column": 9, "row": 8},
    {"top": 370.0, "left": 285, "column": 10, "row": 9},
    {"top": 430.0, "left": 275, "column": 11, "row": 0},
  ];
  List paddingList8d = [
    {"top": 100.0, "left": 205, "column": 2, "row": 2},
    {"top": 132.0, "left": 188, "column": 3, "row": 2},
    {"top": 165.0, "left": 168, "column": 4, "row": 2},
    {"top": 180.0, "left": 210, "column": 4, "row": 3},
    {"top": 210.0, "left": 215, "column": 5, "row": 4},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 255.0, "left": 250, "column": 6, "row": 6},
    {"top": 290.0, "left": 290, "column": 7, "row": 7},
    {"top": 310.0, "left": 270, "column": 8, "row": 7},
    {"top": 330.0, "left": 290, "column": 9, "row": 8},
    {"top": 370.0, "left": 285, "column": 10, "row": 9},
    {"top": 430.0, "left": 275, "column": 11, "row": 0},
  ];
  List paddingList8e = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 140.0, "left": 220, "column": 3, "row": 3},
    {"top": 175.0, "left": 245, "column": 4, "row": 4},
    {"top": 210.0, "left": 255, "column": 5, "row": 5},
    {"top": 255.0, "left": 270, "column": 6, "row": 6},
    {"top": 270.0, "left": 290, "column": 6, "row": 7},
    {"top": 290.0, "left": 270, "column": 7, "row": 7},
    {"top": 310.0, "left": 295, "column": 8, "row": 8},
    {"top": 330.0, "left": 290, "column": 9, "row": 8},
    {"top": 370.0, "left": 285, "column": 10, "row": 9},
    {"top": 430.0, "left": 275, "column": 11, "row": 0},
  ];

  /// paddingList9
  List paddingList9a = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 150.0, "left": 185, "column": 3, "row": 2},
    {"top": 180.0, "left": 200, "column": 4, "row": 3},
    {"top": 210.0, "left": 225, "column": 5, "row": 4},
    {"top": 240.0, "left": 200, "column": 6, "row": 4},
    {"top": 250.0, "left": 225, "column": 6, "row": 5},
    {"top": 280.0, "left": 250, "column": 7, "row": 6},
    {"top": 310.0, "left": 280, "column": 8, "row": 7},
    {"top": 310.0, "left": 290, "column": 8, "row": 8},
    {"top": 330.0, "left": 310, "column": 9, "row": 9},
    {"top": 370.0, "left": 325, "column": 10, "row": 10},
    {"top": 430.0, "left": 315, "column": 11, "row": 0},
  ];
  List paddingList9b = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 140.0, "left": 220, "column": 3, "row": 3},
    {"top": 175.0, "left": 245, "column": 4, "row": 4},
    {"top": 210.0, "left": 255, "column": 5, "row": 5},
    {"top": 255.0, "left": 250, "column": 6, "row": 6},
    {"top": 290.0, "left": 290, "column": 7, "row": 7},
    {"top": 310.0, "left": 290, "column": 8, "row": 8},
    {"top": 330.0, "left": 310, "column": 9, "row": 9},
    {"top": 370.0, "left": 325, "column": 10, "row": 10},
    {"top": 430.0, "left": 315, "column": 11, "row": 0},
  ];
  List paddingList9c = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 150.0, "left": 185, "column": 3, "row": 2},
    {"top": 180.0, "left": 200, "column": 4, "row": 3},
    {"top": 210.0, "left": 205, "column": 5, "row": 4},
    {"top": 240.0, "left": 195, "column": 6, "row": 4},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 255.0, "left": 250, "column": 6, "row": 6},
    {"top": 290.0, "left": 290, "column": 7, "row": 7},
    {"top": 310.0, "left": 290, "column": 8, "row": 8},
    {"top": 330.0, "left": 310, "column": 9, "row": 9},
    {"top": 370.0, "left": 325, "column": 10, "row": 10},
    {"top": 430.0, "left": 315, "column": 11, "row": 0},
  ];
  List paddingList9d = [
    {"top": 100.0, "left": 205, "column": 2, "row": 2},
    {"top": 132.0, "left": 185, "column": 3, "row": 2},
    {"top": 170.0, "left": 200, "column": 4, "row": 3},
    {"top": 210.0, "left": 215, "column": 5, "row": 4},
    {"top": 250.0, "left": 240, "column": 6, "row": 5},
    {"top": 260.0, "left": 255, "column": 6, "row": 6},
    {"top": 290.0, "left": 290, "column": 7, "row": 7},
    {"top": 310.0, "left": 295, "column": 8, "row": 8},
    {"top": 320.0, "left": 320, "column": 8, "row": 9},
    {"top": 350.0, "left": 310, "column": 9, "row": 9},
    {"top": 375.0, "left": 325, "column": 10, "row": 10},
    {"top": 430.0, "left": 315, "column": 11, "row": 0},
  ];
  List paddingList9e = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 140.0, "left": 220, "column": 3, "row": 3},
    {"top": 175.0, "left": 245, "column": 4, "row": 4},
    {"top": 210.0, "left": 255, "column": 5, "row": 5},
    {"top": 255.0, "left": 250, "column": 6, "row": 6},
    {"top": 260.0, "left": 290, "column": 6, "row": 7},
    {"top": 290.0, "left": 270, "column": 7, "row": 7},
    {"top": 310.0, "left": 290, "column": 8, "row": 8},
    {"top": 350.0, "left": 310, "column": 9, "row": 9},
    {"top": 375.0, "left": 325, "column": 10, "row": 10},
    {"top": 430.0, "left": 315, "column": 11, "row": 0},
  ];

  /// paddingList10
  List paddingList10a = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 150.0, "left": 185, "column": 3, "row": 2},
    {"top": 180.0, "left": 200, "column": 4, "row": 3},
    {"top": 210.0, "left": 225, "column": 5, "row": 4},
    {"top": 250.0, "left": 225, "column": 6, "row": 5},
    {"top": 280.0, "left": 250, "column": 7, "row": 6},
    {"top": 310.0, "left": 280, "column": 8, "row": 7},
    {"top": 310.0, "left": 290, "column": 8, "row": 8},
    {"top": 330.0, "left": 310, "column": 9, "row": 9},
    {"top": 370.0, "left": 325, "column": 10, "row": 10},
    {"top": 430.0, "left": 350, "column": 11, "row": 0},
  ];
  List paddingList10b = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 140.0, "left": 220, "column": 3, "row": 3},
    {"top": 175.0, "left": 245, "column": 4, "row": 4},
    {"top": 210.0, "left": 255, "column": 5, "row": 5},
    {"top": 255.0, "left": 250, "column": 6, "row": 6},
    {"top": 290.0, "left": 290, "column": 7, "row": 7},
    {"top": 310.0, "left": 290, "column": 8, "row": 8},
    {"top": 330.0, "left": 310, "column": 9, "row": 9},
    {"top": 370.0, "left": 325, "column": 10, "row": 10},
    {"top": 430.0, "left": 350, "column": 11, "row": 0},
  ];
  List paddingList10c = [
    {"top": 105.0, "left": 195, "column": 2, "row": 2},
    {"top": 150.0, "left": 185, "column": 3, "row": 2},
    {"top": 180.0, "left": 200, "column": 4, "row": 3},
    {"top": 210.0, "left": 205, "column": 5, "row": 4},
    {"top": 240.0, "left": 195, "column": 6, "row": 4},
    {"top": 250.0, "left": 230, "column": 6, "row": 5},
    {"top": 255.0, "left": 250, "column": 6, "row": 6},
    {"top": 290.0, "left": 290, "column": 7, "row": 7},
    {"top": 310.0, "left": 290, "column": 8, "row": 8},
    {"top": 330.0, "left": 310, "column": 9, "row": 9},
    {"top": 370.0, "left": 325, "column": 10, "row": 10},
    {"top": 430.0, "left": 350, "column": 11, "row": 0},
  ];
  List paddingList10d = [
    {"top": 100.0, "left": 205, "column": 2, "row": 2},
    {"top": 132.0, "left": 185, "column": 3, "row": 2},
    {"top": 170.0, "left": 200, "column": 4, "row": 3},
    {"top": 210.0, "left": 215, "column": 5, "row": 4},
    {"top": 250.0, "left": 240, "column": 6, "row": 5},
    {"top": 260.0, "left": 255, "column": 6, "row": 6},
    {"top": 290.0, "left": 290, "column": 7, "row": 7},
    {"top": 310.0, "left": 295, "column": 8, "row": 8},
    {"top": 320.0, "left": 320, "column": 8, "row": 9},
    {"top": 350.0, "left": 310, "column": 9, "row": 9},
    {"top": 370.0, "left": 325, "column": 10, "row": 10},
    {"top": 430.0, "left": 350, "column": 11, "row": 0},
  ];
  List paddingList10e = [
    {"top": 105.0, "left": 205, "column": 2, "row": 2},
    {"top": 140.0, "left": 220, "column": 3, "row": 3},
    {"top": 175.0, "left": 245, "column": 4, "row": 4},
    {"top": 210.0, "left": 255, "column": 5, "row": 5},
    {"top": 255.0, "left": 250, "column": 6, "row": 6},
    {"top": 260.0, "left": 290, "column": 6, "row": 7},
    {"top": 290.0, "left": 270, "column": 7, "row": 7},
    {"top": 310.0, "left": 290, "column": 8, "row": 8},
    {"top": 350.0, "left": 310, "column": 9, "row": 9},
    {"top": 370.0, "left": 325, "column": 10, "row": 10},
    {"top": 430.0, "left": 350, "column": 11, "row": 0},
  ];
}

class Light {
  final int column;
  final int row;
  Light(
    this.column,
    this.row,
  );
}
