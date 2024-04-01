// import 'package:mahajong/res/aap_colors.dart';
// import 'package:mahajong/res/components/text_widget.dart';
// import 'package:flutter/material.dart';
//
// class ChartScreen extends StatefulWidget {
//   const ChartScreen({super.key});
//
//   @override
//   State<ChartScreen> createState() => _ChartScreenState();
// }
//
// class _ChartScreenState extends State<ChartScreen> {
//   List<GameHistoryModel> itemHistory = [
//     GameHistoryModel(period: '223037376289', number: '1'),
//     GameHistoryModel(period: '223037376289', number: '0'),
//     GameHistoryModel(period: '223037376289', number: '3'),
//     GameHistoryModel(period: '223037376289', number: '2'),
//     GameHistoryModel(period: '223037376289', number: '5'),
//     GameHistoryModel(period: '223037376289', number: '4'),
//     GameHistoryModel(period: '223037376289', number: '7'),
//     GameHistoryModel(period: '223037376289', number: '6'),
//     GameHistoryModel(period: '223037376289', number: '9'),
//     GameHistoryModel(period: '223037376289', number: '8'),
//   ];
//
//   List<Widget> generateNumberWidgets(int parse) {
//     return List.generate(10, (index) {
//       List<Color> colors = [
//         const Color(0xFFFFFFFF),
//         const Color(0xFFFFFFFF),
//       ];
//
//       if (index == parse) {
//         if (parse == 0) {
//           colors = [
//             const Color(0xFFfd565c),
//             const Color(0xFFb659fe),
//           ];
//         } else if (parse == 5) {
//           colors = [
//             const Color(0xFF40ad72),
//             const Color(0xFFb659fe),
//           ];
//         } else {
//           colors = parse % 2 == 0
//               ? [
//             const Color(0xFF40ad72),
//             const Color(0xFF40ad72),
//           ]
//               : [
//             const Color(0xFFfd565c),
//             const Color(0xFFfd565c),
//
//           ];
//         }
//       }
//
//       return Container(
//         height: 20,
//         width: 20,
//         margin: const EdgeInsets.all(2),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(),
//           gradient: LinearGradient(
//               colors: colors,
//               stops: const [
//                 0.5,
//                 0.5,
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               tileMode: TileMode.mirror),
//         ),
//         child: textWidget(
//           text: '$index',
//           fontWeight: FontWeight.w600,
//           color: index == parse ? AppColors.primaryTextColor : Colors.black,
//         ),
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     return Column(
//       children: List.generate(
//         itemHistory.length,
//             (index) {
//           return Container(
//             height: 60,
//             width: width,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 textWidget(text: itemHistory[index].period),
//                 Row(
//                     children: generateNumberWidgets(int.parse(itemHistory[index].number))
//                 ),
//                 Container(
//                   height: 20,
//                   width: 20,
//                   margin: const EdgeInsets.all(2),
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     gradient: int.parse(itemHistory[index].number) < 5
//                         ? AppColors.btnBlueGradient
//                         : AppColors.btnYellowGradient,
//                   ),
//                   child: textWidget(
//                     text:
//                     int.parse(itemHistory[index].number) < 5 ? 'S' : 'B',
//                     color: AppColors.primaryTextColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
