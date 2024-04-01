import 'package:dashed_color_circle/dashed_color_circle.dart';
import 'package:flutter/material.dart';
class BetLockedScreen extends StatefulWidget {
  const BetLockedScreen({super.key});

  @override
  State<BetLockedScreen> createState() => _BetLockedScreenState();
}

class _BetLockedScreenState extends State<BetLockedScreen> {
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Center(
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
                      child: Container(
                        height: 44.0,
                        width: 120,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(15)),
                         color: Colors.grey
                        ),
                        child: const Center(
                            child: Text(
                              'Green',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            )),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 44.0,
                        width: 120,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(15)),
                         color: Colors.grey
                        ),
                        child: const Center(
                            child: Text(
                              'Red',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
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
                      const InkWell(
                          child: Card(
                            color: Colors.grey,
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
                          readOnly: true,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          onChanged: (newValue) {
                            setState(() {
                            });
                          },
                        ),
                      ),
                      const InkWell(
                          child: Card(
                            color: Colors.grey,
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
                        return Container(
                            child:
                            hidecoins(list[index]));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Icon(Icons.lock,size: 100,),
              Text('Bet Locked!',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
            ],
          ),
        )
      ],
    );
  }

  List<int> list = [10, 50, 100, 500, 1000];

  Widget hidecoins(otherdatas) {
    if (otherdatas == 10) {
    } else if (otherdatas == 50) {
    } else if (otherdatas == 100) {
    } else if (otherdatas == 500) {
    } else if (otherdatas == 1000) {
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CircleAvatar(
        backgroundColor: Colors.grey,
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
}
