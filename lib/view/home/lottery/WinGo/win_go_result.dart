// // ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison
//
// import 'package:mahajong/generated/assets.dart';
// import 'package:mahajong/model/colorPredictionResult_provider.dart';
// import 'package:mahajong/res/aap_colors.dart';
// import 'package:mahajong/res/components/text_widget.dart';
// import 'package:mahajong/res/helper/api_helper.dart';
// import 'package:mahajong/view/account/History/betting_history.dart';
// import 'package:mahajong/view/home/lottery/WinGo/chart_screen.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class WinGoResult extends StatefulWidget {
//   const WinGoResult({super.key});
//
//   @override
//   State<WinGoResult> createState() => _WinGoResultState();
// }
//
// class _WinGoResultState extends State<WinGoResult> {
//   int selectedTabIndex = 0;
//   List<GameHistoryModel> itemHistory = [
//     GameHistoryModel(period: '22303737628947', number: '1'),
//     GameHistoryModel(period: '22303737628947', number: '0'),
//     GameHistoryModel(period: '22303737628947', number: '3'),
//     GameHistoryModel(period: '22303737628947', number: '2'),
//     GameHistoryModel(period: '22303737628947', number: '5'),
//     GameHistoryModel(period: '22303737628947', number: '4'),
//     GameHistoryModel(period: '22303737628947', number: '7'),
//     GameHistoryModel(period: '22303737628947', number: '6'),
//     GameHistoryModel(period: '22303737628947', number: '9'),
//     GameHistoryModel(period: '22303737628947', number: '8'),
//   ];
//
//   BaseApiHelper baseApiHelper = BaseApiHelper();
//
//
//   @override
//   void initState() {
//     fetchColorResult();
//     // TODO: implement initState
//     super.initState();
//   }
//
//   int pageNumber = 1;
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     final colorResultmain = Provider.of<ColorPredictionProvider>(context).ResultListColorlist;
//     print(colorResultmain);
//     print("colorResultmain");
//
//     final widths = MediaQuery.of(context).size.width;
//     final heights = MediaQuery.of(context).size.width;
//     if (colorResultmain!= null) {
//       return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             buildTabContainer('Game History', 0, widths, Colors.red,),
//             buildTabContainer('Chart', 1, widths, Colors.red),
//             buildTabContainer('My History', 2, widths, Colors.red),
//           ],
//         ),
//         const SizedBox(
//           height: 15,
//         ),
//         selectedTabIndex == 0
//             ? Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 15),
//               margin: const EdgeInsets.only(left: 10, right: 10),
//               decoration: const BoxDecoration(
//                   color: Colors.red,
//                   borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(10),
//                       topLeft: Radius.circular(10))),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     alignment: Alignment.center,
//                     width: widths*0.3,
//                     child: textWidget(
//                         text: 'Period',
//                         fontSize: 16,
//                         fontWeight: FontWeight.w900,
//                         color: AppColors.primaryTextColor),
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     width: widths*0.21,
//                     child: textWidget(
//                         text: 'Number',
//                         fontSize: 16,
//                         fontWeight: FontWeight.w900,
//                         color: AppColors.primaryTextColor),
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     width: widths*0.21,
//                     child: textWidget(
//                         text: 'Big Small',
//                         fontSize: 16,
//                         fontWeight: FontWeight.w900,
//                         color: AppColors.primaryTextColor),
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     width: widths*0.21,
//                     child: textWidget(
//                         text: 'Color',
//                         fontSize: 16,
//                         fontWeight: FontWeight.w900,
//                         color: AppColors.primaryTextColor),
//                   ),
//                 ],
//               ),
//             ),
//             ListView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: colorResultmain.length,
//               itemBuilder: (context, index) {
//                 List<Color> colors;
//
//                 if (colorResultmain[index].number == '0') {
//                   colors = [
//                     const Color(0xFFfd565c),
//                     const Color(0xFFb659fe),
//                   ];
//                 } else if (colorResultmain[index].number == '5') {
//                   colors = [
//                     const Color(0xFF40ad72),
//                     const Color(0xFFb659fe),
//                   ];
//                 } else {
//                   int number = int.parse(colorResultmain[index].number.toString());
//                   colors = number.isOdd
//                       ? [
//                     const Color(0xFF40ad72),
//                     const Color(0xFF40ad72),
//                   ]
//                       : [
//                     const Color(0xFFfd565c),
//                     const Color(0xFFfd565c),
//                   ];
//                 }
//
//                 return Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           alignment: Alignment.center,
//                           width: widths*0.3,
//                           child: textWidget(
//                             text: colorResultmain[index].gamesno.toString(),
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                             maxLines: 1,
//                           ),
//                         ),
//                         Container(
//                           alignment: Alignment.center,
//                           width: widths*0.21,
//                           child: GradientText(
//                             colorResultmain[index].number.toString(),
//                             style: const TextStyle(
//                                 fontSize: 40,
//                                 fontWeight: FontWeight.w900),
//                             gradient: LinearGradient(
//                                 colors: colors,
//                                 stops: const [
//                                   0.5,
//                                   0.5,
//                                 ],
//                                 begin: Alignment.topCenter,
//                                 end: Alignment.bottomCenter,
//                                 tileMode: TileMode.mirror),
//                           ),
//                         ),
//                         Container(
//                           alignment: Alignment.center,
//                           width: widths*0.21,
//                           child: textWidget(
//                             text:
//                             int.parse(colorResultmain[index].number.toString()) < 5
//                                 ? 'Small'
//                                 : 'Big',
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             maxLines: 1,
//                           ),
//                         ),
//                         Container(
//                             alignment: Alignment.center,
//                             width: widths*0.21,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: List.generate(
//                                   colorResultmain[index].number == '0' ||
//                                       colorResultmain[index].number ==
//                                           '5'
//                                       ? 2
//                                       : 1,
//                                       (indexed) => Text(
//                                     "●",
//                                     style: TextStyle(
//                                         color: colorResultmain[index]
//                                             .number ==
//                                             '0'
//                                             ? colors[indexed]
//                                             : colorResultmain[index]
//                                             .number ==
//                                             '5'
//                                             ? colors[indexed]
//                                             : int.parse(colorResultmain[
//                                         index]
//                                             .number.toString())
//                                             .isOdd
//                                             ? Colors.red
//                                             : Colors.green,
//                                         fontSize: 40,
//                                         fontWeight:
//                                         FontWeight.w900),
//                                   )),
//                             )
//                         ),
//                       ],
//                     ),
//                     const Divider()
//                   ],
//                 );
//               },
//             ),
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.center,
//             //   children: [
//             //     Container(
//             //       height: heights / 10,
//             //       width: widths / 10,
//             //       decoration: BoxDecoration(
//             //           color: Colors.red,
//             //           borderRadius: BorderRadius.circular(10)),
//             //       child: const Icon(
//             //         Icons.navigate_before,
//             //         color: Colors.white,
//             //       ),
//             //     ),
//             //     const SizedBox(width: 16),
//             //     textWidget(
//             //         text: '1/10',
//             //         fontSize: 13,
//             //         fontWeight: FontWeight.w600,
//             //         color: AppColors.secondaryTextColor,
//             //         maxLines: 1),
//             //     const SizedBox(width: 16),
//             //     Container(
//             //       height: heights / 10,
//             //       width: widths / 10,
//             //       decoration: BoxDecoration(
//             //           color: Colors.red,
//             //           borderRadius: BorderRadius.circular(10)),
//             //       child: const Icon(Icons.navigate_next, color: Colors.white),
//             //     ),
//             //   ],
//             // ),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     if (pageNumber > 1) {
//                       setState(() {
//                         pageNumber--;
//                         fetchColorResult();
//                       });
//                     }
//                   },
//                   child: Container(
//                     height: heights / 10,
//                     width: widths / 10,
//                     decoration: BoxDecoration(
//                       color: Colors.red,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: const Icon(
//                       Icons.navigate_before,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 textWidget(
//                   text: '$pageNumber/10',
//                   fontSize: 13,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.secondaryTextColor,
//                   maxLines: 1,
//                 ),
//                 const SizedBox(width: 16),
//                 GestureDetector(
//                   onTap: () {
//                     if (pageNumber < 10) {
//                       setState(() {
//                         pageNumber++;
//                       });
//                       fetchColorResult();
//                     }
//                   },
//                   child: Container(
//                     height: heights / 10,
//                     width: widths / 10,
//                     decoration: BoxDecoration(
//                       color: Colors.red,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: const Icon(Icons.navigate_next, color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10)
//           ],
//         )
//             :  selectedTabIndex == 1? const ChartScreen():BetHistory(),
//       ],
//     );
//     } else {
//       return Container();
//     }
//   }
//   Future<void> fetchColorResult() async {
//     try {
//       if (kDebugMode) {
//         print("srdfgyuhj");
//       }
//       final colorRes = await baseApiHelper.fetchColorPredictionResult("$pageNumber");
//       if (kDebugMode) {
//         print(colorRes);
//         print("colorRes");
//       }
//       Provider.of<ColorPredictionProvider>(context, listen: false).setColorResultList(colorRes!);
//     } catch (error) {
//       if (kDebugMode) {
//         print("hiiii $error");
//       }
//     }
//   }
//
//
//   Widget buildTabContainer(String label, int index, double widths, Color selectedTextColor) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           selectedTabIndex = index;
//         });
//       },
//       child: Container(
//         height: 40,
//         width: widths / 3.3,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//             color: selectedTabIndex == index
//                 ? Colors.red
//                 : Colors.black.withOpacity(0.05),
//             borderRadius: BorderRadius.circular(8)),
//         child: Text(
//           label,
//           style: TextStyle(
//             fontSize: widths / 24,
//             fontWeight:
//             selectedTabIndex == index ? FontWeight.bold : FontWeight.w500,
//             color: selectedTabIndex == index ? Colors.white : Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class GameHistoryModel {
//   final String period;
//   final String number;
//
//   GameHistoryModel({
//     required this.period,
//     required this.number,
//   });
// }
//
// class GradientText extends StatelessWidget {
//   const GradientText(
//       this.text, {
//         super.key,
//         required this.gradient,
//         this.style,
//       });
//
//   final String text;
//   final TextStyle? style;
//   final Gradient gradient;
//
//   @override
//   Widget build(BuildContext context) {
//     return ShaderMask(
//       blendMode: BlendMode.srcIn,
//       shaderCallback: (bounds) => gradient.createShader(
//         Rect.fromLTWH(0, 0, bounds.width, bounds.height),
//       ),
//       child: Text(text, style: style),
//     );
//   }
// }