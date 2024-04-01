// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:mahajong/res/components/commonbottomsheet.dart';
import 'package:mahajong/res/helper/api_helper.dart';
import 'package:mahajong/res/provider/slider_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key});

  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<SliderWidget> {

  @override
  void initState() {
    fetchSliderData();
    // TODO: implement initState
    super.initState();
  }

  int _current = 0;
  final CarouselController _controller = CarouselController();

  // final List<String> _items = [
  //   // Assets.sliderFirst,
  //   // Assets.sliderSecond,
  //   // Assets.sliderThird,
  // ];

  BaseApiHelper baseApiHelper = BaseApiHelper();

  @override
  Widget build(BuildContext context) {

    final sliderData = Provider.of<SliderProvider>(context).sliderList;

    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 180,
      child: Column(
        children: [
          SizedBox(height: 5),
          CarouselSlider(
            items: sliderData.map((item) => Container(
                width: width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),image: DecorationImage(image: NetworkImage(item.image.toString()),fit: BoxFit.fill)),
                )).toList(),
            carouselController: _controller,
            options: CarouselOptions(
              height: 150,
              viewportFraction: 0.9,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
                },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  sliderData.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 4.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
  Future<void> fetchSliderData() async {
    try {
      if (kDebugMode) {
        print("ggggg000");
      }
      final dataSlider = await baseApiHelper.fetchSliderData();
      if (kDebugMode) {
        print(dataSlider);
        print("userData");
      }
      Provider.of<SliderProvider>(context, listen: false).setSliderList(dataSlider);
        } catch (error) {
      // Handle error here
      if (kDebugMode) {
        print(error);
      }
    }
  }



}
