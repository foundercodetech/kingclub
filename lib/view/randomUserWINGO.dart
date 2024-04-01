import 'dart:async';
import 'dart:math';

import 'package:mahajong/res/aap_colors.dart';
import 'package:mahajong/res/components/app_bar.dart';
import 'package:mahajong/res/components/app_btn.dart';
import 'package:mahajong/res/components/text_widget.dart';
import 'package:flutter/material.dart';



class RandomList extends StatefulWidget {
  @override
  _RandomListState createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  Random random = Random();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startGeneratingList();
  }

  void startGeneratingList() {
    // Generate and display the list for one minute
    const oneMinute = Duration(minutes: 1);
    timer = Timer.periodic(oneMinute, (timer) {
      setState(() {}); // Trigger a rebuild every minute to update the list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
          leading: AppBackBtn(),
          title: textWidget(
              text: 'Winners',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryGradient),
      body: ListView.builder(
        itemCount: 40, // Number of items you want to display
        itemBuilder: (context, index) {
          int randomNumber = generateRandomNumber();
          return  Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('User ${generateRandomName()}*${generateRandomName()}'),
                Text('Bet Price: ${generateRandomBetPrice()}'),
                Container(
                  alignment: Alignment.centerRight,
                  width: 25,
                  child:  randomNumber == 4
                      ? const SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.red,

                        ),
                        SizedBox(width: 2),
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.deepPurpleAccent,

                        ),
                      ],
                    ),
                  ):
                  randomNumber == 5
                      ?const SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.green,
                        ),
                        SizedBox(width: 2),
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.deepPurpleAccent,

                        ),
                      ],
                    ),
                  )
                      :randomNumber == 1?
                  const CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.green,

                  ):
                  randomNumber == 2?
                  const CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.deepPurpleAccent,

                  ):
                  const CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.red,

                  ),
                ),

              ],
            ),
          );

          //   ListTile(
          //   leading:
          //   title: Text('User ' +
          //       generateRandomName() +
          //       '*' +
          //       generateRandomName()),
          //   subtitle: Text('Bet Price: ${generateRandomBetPrice()}'),
          // );
        },
      ),
    );
  }

  int generateRandomNumber() {
    return random.nextInt(5) + 1; // Generates random numbers 1, 2, 3, 4, or 5
  }

  int generateRandomBetPrice() {
    return (random.nextInt(50) + 1) * 10; // Generates bet prices between 10 and 500 in increments of 10
  }

  String generateRandomName() {
    const alphabet = '12356790';
    return List.generate(2, (index) => alphabet[random.nextInt(alphabet.length)]).join();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}