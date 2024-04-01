import 'package:mahajong/res/components/app_btn.dart';
import 'package:mahajong/res/components/text_widget.dart';
import 'package:flutter/material.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: height*0.58,
        child: Column(
          children: [
            Container(
              height: height*0.08,
              width: width,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.red),
              child: Row(
                children: [
                  AppBackBtn(),
                  SizedBox(width: width*0.16),
                  Center(
                      child: textWidget(
                          text: "Offers",
                          fontSize: width*0.055,
                          color: Colors.white,
                        fontWeight: FontWeight.bold
                      )
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
