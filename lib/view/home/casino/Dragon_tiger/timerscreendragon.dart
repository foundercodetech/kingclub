// import 'package:flutter/material.dart';
// import 'package:mahajong/generated/assets.dart';
//
// class TimerScreenDragon extends StatefulWidget {
//   const TimerScreenDragon({super.key});
//
//   @override
//   State<TimerScreenDragon> createState() => _TimerScreenDragonState();
// }
//
// class _TimerScreenDragonState extends State<TimerScreenDragon> {
//   @override
//   Widget build(BuildContext context) {
//     final heights = MediaQuery.of(context).size.height;
//     final widths =  MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.deepOrange,
//       body:  Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(Assets.dragontigerDragonTigerRemovebgPreview,height: heights*0.40,),
//           SizedBox(height: heights*0.02,),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: 200,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: const Color(0xffea0b3e), width: 1),
//                 ),
//                 child: LinearProgressIndicator(
//                   value: 1 - (countdownSeconds / WaitingTimeSeconds),
//                   backgroundColor: Colors.grey,
//                   valueColor: const AlwaysStoppedAnimation<Color>(Color(0xffea0b3e)),
//                   minHeight: 6,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               Text(
//                 '  ${(100 - ((countdownSeconds / WaitingTimeSeconds) * 100)).toStringAsFixed(0)}%',
//               ),
//
//               // Text(' ${_linearProgressAnimation.value.toStringAsFixed(2)}%',style: TextStyle(color: Colors.white),),
//             ],
//           ),
//           SizedBox(height: heights*0.02,),
//           Text(
//             " Dragon Tiger is a verifiably 100% ${AppConstants.appName}",
//             style: TextStyle(
//                 fontSize: widths*0.02,
//                 color: Colors.white
//
//             ),
//           )
//
//
//         ],
//       ),
//     );
//   }
// }
