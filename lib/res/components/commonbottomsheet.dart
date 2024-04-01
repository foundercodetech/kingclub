// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:mahajong/res/helper/api_helper.dart';
import 'package:mahajong/res/provider/betColorPrediction_provider.dart';
import 'package:mahajong/res/provider/wallet_provider.dart';
import 'package:mahajong/utils/utils.dart';
import 'package:mahajong/view/home/lottery/WinGo/win_go_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommonBottomSheet extends StatefulWidget {
  final List<Color>? colors;
  final String colorName;
  final String predictionType;
  final int gameid;
  const CommonBottomSheet({
    super.key,
    this.colors,
    required this.colorName,
    required this.predictionType, required this.gameid,
  });

  @override
  State<CommonBottomSheet> createState() => _CommonBottomSheetState();
}

var h;
var w;

class _CommonBottomSheetState extends State<CommonBottomSheet> {


  @override
  void initState() {
    walletfetch();
    amount.text=selectedIndex.toString();
    // TODO: implement initState
    super.initState();
  }
  int value = 1;
  int selectedAmount = 1;

  void increment() {
    setState(() {
      selectedMultiplier = selectedMultiplier + 1;
      deductAmount();
    });
  }

  void decrement() {
    setState(() {
      if (selectedMultiplier > 0) {
        selectedMultiplier = selectedMultiplier - 1;
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
  // void deductAmount() {
  //   if (wallbal! >= selectedAmount * value) {
  //     walletApi = wallbal;
  //   }
  //   int amountToDeduct = selectedAmount * value;
  //   if (walletApi! >= amountToDeduct) {
  //     setState(() {
  //       amount.text = (selectedAmount * value).toString();
  //       walletApi = (walletApi! - amountToDeduct).toInt();
  //     });
  //   } else {
  //     Utils.flushBarErrorMessage('Insufficient funds', context, Colors.white);
  //   }
  // }
  List<int> multipliers = [1, 5, 10, 20, 50, 100];
  int selectedMultiplier = 1; // Default multipli

  void updateMultiplier(int multiplier) {
    setState(() {
      selectedMultiplier = multiplier;
      deductAmount();
    });
  }

  void deductAmount() {
    if (wallbal! >= selectedAmount * selectedMultiplier) {
      walletApi = wallbal;
    }
    int amountToDeduct = selectedAmount * selectedMultiplier;
    if (walletApi! >= amountToDeduct) {
      setState(() {
        amount.text = amountToDeduct.toString();
        walletApi = (walletApi! - amountToDeduct).toInt();
      });
    } else {
      Utils.flushBarErrorMessage('Insufficient funds', context, Colors.white);
    }
  }

  List<int> list = [
    1,
    10,
    50,
    100,
    500,

  ];
  int? walletApi;
  int? wallbal;

  int selectedIndex = 1;

  TextEditingController amount = TextEditingController();

  List<Winlist> listwe = [
    Winlist(1,"Win Go", "1 Min",60),
    Winlist(2,"Win Go", "3 Min",180),
    Winlist(3,"Win Go", "5 Min",300),
    Winlist(4,"Win Go", "10 Min",600),
  ];
  String gametitle='Wingo';
  String subtitle='1 Min';
  @override
  Widget build(BuildContext context) {
    final walletdetails = Provider.of<WalletProvider>(context).walletlist;

    walletApi = (walletdetails!.wallet == null ? 0 : double.parse(walletdetails.wallet.toString())).toInt();
    wallbal = (walletdetails.wallet == null ? 0 : double.parse(walletdetails.wallet.toString())).toInt();

    final Betprovider = Provider.of<BetColorResultProvider>(context);


    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    LinearGradient gradient = LinearGradient(
        colors: widget.colors ?? [Colors.white, Colors.black],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        tileMode: TileMode.mirror);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: h / 1.9,
          width: w,
          child: Column(
            children: [
              Container(
                height: 25,
                width: w,
                decoration: BoxDecoration(
                  color:
                  widget.colors == null ? Colors.white : widget.colors!.first,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                alignment: Alignment.center,
                child:  Text(
                  widget.gameid==1?'Win Go 1 Min':widget.gameid==2?'Win Go 3 Min':widget.gameid==3?'Win Go 5 Min':"Win Go 10 Min",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(
                      width: w,
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: widget.predictionType == "1"
                            ? ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return gradient.createShader(bounds);
                          },
                          blendMode: BlendMode.srcATop,
                          child: CustomPaint(
                            painter: _InvertedTrianglePainterSingle(),
                          ),
                        )
                            : Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 200,
                              width: w,
                              child: ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return gradient.createShader(bounds);
                                },
                                blendMode: BlendMode.srcATop,
                                child: CustomPaint(
                                  painter: _InvertedTrianglePainterSingle(),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 35,
                              bottom: 65,
                              child: Transform.rotate(
                                angle: -0.18,
                                child: SizedBox(
                                  height: 200,
                                  width: w,
                                  child: CustomPaint(
                                    painter: _InvertedTrianglePainterDouble(
                                        widget.colors),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        alignment: Alignment.center,
                        width: widget.predictionType == "1" ? w / 2 : w / 1.5,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "Select:  ${widget.colorName}",
                          style: const TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        width: w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Balance",
                              style: TextStyle(fontSize: 18),
                            ),

                            Container(
                              width: 200,
                              height: 30,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: list.length,

                                  itemBuilder: (BuildContext, int index){
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex=list[index];
                                    });
                                    selectam(selectedIndex);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    padding: const EdgeInsets.all(5),
                                      color:selectedIndex==list[index]?widget.colors!.first:Colors.white,

                                    child: Text(list[index].toString(),
                                        style: TextStyle(
                                            fontSize: 18,
                                    color:Colors.black

                                  ),
                                )));
                              }),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        width: w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Quantity",
                              style: TextStyle(fontSize: 18),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: decrement,
                                    child: Container(
                                      width: 35,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(right: 5),
                                      padding: const EdgeInsets.all(5),
                                      color: widget.colors!.first,

                                      child: const Text("--",
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.white)),
                                    ),
                                  ),
                                  Container(
                                    height: 35,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(4),
                                      width: 75,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        border: Border.all(
                                            width: 1, color: Colors.grey.shade500),
                                      ),
                                      child: TextField(
                                       controller: amount,
                                        // readOnly: true,
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          border: InputBorder.none
                                        ),
                                        style: const TextStyle(fontSize: 18, color: Colors.black),
                                      )
                                  ),
                                  InkWell(
                                    onTap: increment,
                                    child: Container(
                                      width: 35,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(left: 5),
                                      padding: const EdgeInsets.all(5),
                                      color:widget.colors!.first,
                                      child: const Text("+",
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.white)),
                                    ),
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: multipliers.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedMultiplier = multipliers[index];
                          });
                          updateMultiplier(selectedMultiplier);
                        },
                      style: ElevatedButton.styleFrom(
                      primary: selectedMultiplier == multipliers[index]
                      ? widget.colors!.first:Colors.white,

                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      ),),
                        child: Text('X${multipliers[index]}',style: TextStyle(color: Colors.black),),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(
                height: 15,
              ),
              const Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.check_circle,
                    color: Colors.red,
                  ),
                  Text(" I agree"),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "(Pre sale rule)",
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {

                        print('yyyybbbbbbbbbbb');
                      });
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.black.withOpacity(0.7),
                      width: w / 3,
                      height: 45,
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                       Betprovider.Colorbet(context,amount.text,widget.predictionType,widget.gameid);
                    },
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        color: widget.colors!.first,
                        width: w / 1.5,
                        height: 45,
                        child: Text(
                          "Total amount ${amount.text}",
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
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

}

class _InvertedTrianglePainterSingle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    final Path path = Path();
    path.moveTo(size.width / -1.8, 0);
    path.lineTo(size.width * 1.5, 0);
    path.lineTo(size.width / 2, size.height / 2.8);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _InvertedTrianglePainterDouble extends CustomPainter {
  final List<Color>? color;

  _InvertedTrianglePainterDouble(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint1 = Paint()
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..color = color!.last
      ..style = PaintingStyle.fill;

    final Path path1 = Path();
    path1.moveTo(size.width / 5, -5);
    path1.lineTo(size.width * 15, 0);
    path1.lineTo(size.width / 2, size.height / 2.8);

    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }


}