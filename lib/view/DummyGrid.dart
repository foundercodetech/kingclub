import 'package:flutter/material.dart';
import 'package:mahajong/generated/assets.dart';
import 'package:mahajong/res/aap_colors.dart';
import 'package:mahajong/res/components/text_widget.dart';
class BetNumbers {

  String photo;
  final Color colorone;
  final Color colortwo;
  String number;
  BetNumbers(this.photo, this.colorone,this.colortwo,this.number);

}
class DummyGrid extends StatefulWidget {
  const DummyGrid({super.key});

  @override
  State<DummyGrid> createState() => _DummyGridState();
}

class _DummyGridState extends State<DummyGrid> {


  List<BetNumbers> betNumbers = [
    BetNumbers(Assets.images0,Colors.red,Colors.purple,"0"),//
    BetNumbers(Assets.images1,Colors.green,Colors.green,"1"),
    BetNumbers(Assets.images2,Colors.red,Colors.red,"2"),
    BetNumbers(Assets.images3,Colors.green,Colors.green,"3"),
    BetNumbers(Assets.images4,Colors.red,Colors.red,"4"),
    BetNumbers(Assets.images5,Colors.red,Colors.purple,"5"),//
    BetNumbers(Assets.images6,Colors.red,Colors.red,"6"),
    BetNumbers(Assets.images7,Colors.green,Colors.green,"7"),
    BetNumbers(Assets.images8,Colors.red,Colors.red,"8"),
    BetNumbers(Assets.images9,Colors.green,Colors.green,"9"),
  ];

  @override
  Widget build(BuildContext context) {
    final widths = MediaQuery.of(context).size.width;
    final heights = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(

                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: widths * 0.28,
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  child: textWidget(
                      text: 'Green',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryTextColor),
                ),
              ),
              InkWell(
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: widths * 0.28,
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius:
                      BorderRadius.all(Radius.circular(10))),
                  child: textWidget(
                      text: 'Violet',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryTextColor),
                ),
              ),
              InkWell(
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: widths * 0.28,
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: textWidget(
                      text: 'Red',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryTextColor),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            padding: const EdgeInsets.symmetric(
                vertical: 3, horizontal: 3),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius:
                const BorderRadius.all(Radius.circular(10))),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              shrinkWrap: true,
              itemCount: 10,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(

                  child: Image(
                    image: AssetImage(
                        betNumbers[index].photo.toString()),
                    height: heights / 15,
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: widths * 0.35,
                  decoration: const BoxDecoration(
                      gradient: AppColors.containerGreenGradient,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomLeft: Radius.circular(50))),
                  child: textWidget(
                      text: 'Big',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryTextColor),
                ),
              ),
              InkWell(

                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: widths * 0.35,
                  decoration: const BoxDecoration(
                      gradient: AppColors.btnBlueGradient,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                  child: textWidget(
                      text: 'Small',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryTextColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
