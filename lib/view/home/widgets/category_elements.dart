import 'package:mahajong/Aviator/home_page_aviator.dart';
import 'package:mahajong/generated/assets.dart';
import 'package:mahajong/res/aap_colors.dart';
import 'package:mahajong/res/components/text_widget.dart';
import 'package:mahajong/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mahajong/utils/utils.dart';
import 'package:mahajong/view/home/casino/Dragon_tiger/homepageDragon.dart';
import 'package:mahajong/view/home/casino/Plinko/Plinko_HomePage.dart';

class CategoryElement extends StatefulWidget {
  final int selectedCategoryIndex;
  const CategoryElement({super.key, required this.selectedCategoryIndex});

  @override
  State<CategoryElement> createState() => _CategoryElementState();
}

class _CategoryElementState extends State<CategoryElement> {
  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    List<LotteryModel> lotteryList = [
      LotteryModel(
          titleText: 'Win Go',
          subTitleText: 'Guess Number',
          gameText: 'Green/Red/Purple to win',
          decorationImage: Assets.imagesDecorationFirst,
          decoImage: Assets.imagesDecoFirst,
          member: 'zbttdtnh',
          memberImage: Assets.person1,
          winAmount: '196.00',
        onTap: (){
            Navigator.pushNamed(context, RoutesName.winGoScreen);
        }
      ),
      LotteryModel(
          titleText: 'K3 Lotre',
          subTitleText: 'Guess Number',
          gameText: 'Big/Small/Odd/Even',
          decorationImage: Assets.imagesDecorationSecond,
          decoImage: Assets.imagesDecoSecond,
          member: 'zeejnngs',
          memberImage: Assets.person2,
          winAmount: '188.16',
          onTap: (){
            Utils.showImageComming(context);
          }
      ),
      LotteryModel(
          titleText: '5D Lotre',
          subTitleText: 'Guess Number',
          gameText: 'Big/Small/Odd/Even',
          decorationImage: Assets.imagesDecorationFour,
          decoImage: Assets.imagesDecoThird,
          member: 'lxqldcer',
          memberImage: Assets.person3,
          winAmount: '194.00',
          onTap: (){
            Utils.showImageComming(context);
          }
      ),
      LotteryModel(
          titleText: 'Trx Win',
          subTitleText: 'Guess Number',
          gameText: 'Green/Red/Purple to win',
          decorationImage: Assets.imagesDecorationThird,
          decoImage: Assets.imagesDecoFour,
          member: 'zsifarlr',
          memberImage: Assets.person4,
          winAmount: '1960.00',
          onTap: (){
            Utils.showImageComming(context);
          }
      ),
    ];
    List<MiniGameModel> miniGameList = [
      MiniGameModel(image: Assets.imagesAviatorFirst,onTap: (){
        // Navigator.pushNamed(context, RoutesName.aviatorGame);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>GameAviator()));
      }),
    ];
    List<CassinoModel> cassinoList = [
      CassinoModel(image: Assets.imagesPlinko,onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const PlinkoHomePage()));
      }),
      CassinoModel(image:Assets.imagesDragontiger,onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const DragontigerPage()));
      }),
    ];

    return widget.selectedCategoryIndex == 0
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: lotteryList.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap:lotteryList[index].onTap,
                          child: Container(
                            width: widths,
                            height: heights * 0.17,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      lotteryList[index].decorationImage),
                                  fit: BoxFit.fill),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 0, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textWidget(
                                      text: lotteryList[index].titleText,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 30,
                                      color: AppColors.primaryTextColor),
                                  const Spacer(),
                                  textWidget(
                                      text: lotteryList[index].subTitleText,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: AppColors.primaryTextColor),
                                  textWidget(
                                      text: lotteryList[index].gameText,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: AppColors.primaryTextColor)
                                ],
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 50,
                        //   width: widths,
                        //   child: Padding(
                        //     padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        //     child: Row(
                        //       children: [
                        //         Image.asset(lotteryList[index].memberImage!,
                        //             width: 40),
                        //         const SizedBox(width: 20),
                        //         Row(
                        //           children: [
                        //             textWidget(
                        //               text: 'Member',
                        //               fontWeight: FontWeight.w600,
                        //               fontSize: 12,
                        //             ),
                        //             textWidget(
                        //               text: lotteryList[index]
                        //                   .member!
                        //                   .toUpperCase(),
                        //               fontWeight: FontWeight.w600,
                        //               fontSize: 12,
                        //             ),
                        //           ],
                        //         ),
                        //         const Spacer(),
                        //         Row(
                        //           children: [
                        //             textWidget(
                        //               text: 'winningAmount',
                        //               fontWeight: FontWeight.w600,
                        //               fontSize: 12,
                        //             ),
                        //             textWidget(
                        //               text: '₹${lotteryList[index].winAmount!}',
                        //               fontWeight: FontWeight.w600,
                        //               fontSize: 12,
                        //             ),
                        //           ],
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  Positioned(
                      top: 5,
                      right: 10,
                      child: SvgPicture.asset(lotteryList[index].decoImage!,
                          height: 100)),
                ],
              );
            })
        : widget.selectedCategoryIndex == 1?
           Padding(
            padding: const EdgeInsets.fromLTRB(10, 25, 10, 5),
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: miniGameList.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 5, mainAxisSpacing: 5, crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: miniGameList[index].onTap,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(miniGameList[index].image))),
                    ),
                  );
                }),
          ):
    widget.selectedCategoryIndex == 2?
    Padding(
      padding: const EdgeInsets.fromLTRB(10, 25, 10, 5),
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: cassinoList.length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 3
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: cassinoList[index].onTap,
              child: Container(
                height: heights*0.50,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(cassinoList[index].image),fit: BoxFit.fill)),
              ),
            );
          }),
    ):
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(Assets.imagesCommingsoon,height: heights*0.20,),
    );
  }
}

class LotteryModel {
  final String titleText;
  final String subTitleText;
  final String gameText;
  final String? member;
  final String? memberImage;
  final String decorationImage;
  final String? decoImage;
  final String? winAmount;
  final VoidCallback? onTap;
  LotteryModel(
      {required this.titleText,
      required this.subTitleText,
      required this.gameText,
      this.member,
      this.memberImage,
      required this.decorationImage,
      this.decoImage,
      this.winAmount,
      this.onTap});
}

class MiniGameModel {
  final String image;
  final VoidCallback? onTap;
  MiniGameModel({required this.image,this.onTap});
}
class CassinoModel {
  final String image;
  final VoidCallback? onTap;
  CassinoModel({required this.image,this.onTap});
}
