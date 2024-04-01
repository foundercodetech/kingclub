import 'package:mahajong/generated/assets.dart';
import 'package:mahajong/res/aap_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class HorizontalScale extends StatefulWidget {
  final int count;
  const HorizontalScale({super.key, required this.count});

  @override
  _HorizontalScaleState createState() => _HorizontalScaleState();
}

class ScaleData {
  final String value;
  final String indicatorValue;

  ScaleData({required this.value, required this.indicatorValue});
}

class _HorizontalScaleState extends State<HorizontalScale> {
  static const double containerHeight = 25.0;

  //line width middle
  static const double containerWidth = 70.5;

  static const EdgeInsets containerMargin = EdgeInsets.all(0);

  List<ScaleData> scaleData = [
    ScaleData(value: '3000', indicatorValue: '10'),
    ScaleData(value: '7000', indicatorValue: '25'),
    ScaleData(value: '15000', indicatorValue: '50'),
    ScaleData(value: '70000', indicatorValue: '100'),
  ];

  int rowFilledPosition = 0;

  void _updateScale() {
    setState(() {
      filledPositionIndex++;
      rowFilledPosition++;
      if (filledPositionIndex >= scaleData.length||rowFilledPosition >= scaleData.length) {
        filledPositionIndex = 0;
        rowFilledPosition = 0;
      } else {
        currentData = scaleData[filledPositionIndex];
      }
    });
  }
  updateScale(){
    setState(() {
      if(widget.count<int.parse(scaleData[0].indicatorValue)){
        rowFilledPosition=-1;
      }else if(widget.count<int.parse(scaleData[1].indicatorValue)){
        rowFilledPosition=0;
      }else if(widget.count<int.parse(scaleData[2].indicatorValue)){
        rowFilledPosition=1;
      }else if(widget.count<int.parse(scaleData[3].indicatorValue)){
        rowFilledPosition=2;
      }else{
        rowFilledPosition=3;
      }
    });

  }
  @override
  void initState() {
    updateScale();
    // TODO: implement initState
    super.initState();
  }

  bool isContainerFilled = false;

  int filledPositionIndex = 0;

  ScaleData currentData = ScaleData(value: '0', indicatorValue: '0');

  Widget _buildValueIndicator(int index) {
    if (index >= scaleData.length) {
      return Container();
    }

    ScaleData data = scaleData[index];

    return Positioned(
      top: Constants.valueIndicatorTop,
      left: Constants.valueIndicatorLeft + (index * Constants.valueIndicatorSpacing),
      child: _buildValueIndicatorWidget(data, index),
    );
  }

  Widget _buildValueIndicatorWidget(ScaleData data, int index) {
    bool isCurrentValue = index <= filledPositionIndex;

    return Column(
      children: [
        Text(
          data.value,
          style: TextStyle(
            fontWeight: isCurrentValue ? FontWeight.bold : FontWeight.normal,
            color: isCurrentValue ?Colors.yellow:Colors.white,
            fontSize: 15,
          ),
        ),
        Row(
          children: [
            Container(
              height: containerHeight,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isCurrentValue ? Colors.yellow : Colors.white,
                ),
              ),
            ),

          ],
        ),
        Text(
          data.indicatorValue,
          style: TextStyle(
            fontWeight: isCurrentValue ? FontWeight.bold : FontWeight.normal,
            color: isCurrentValue ?Colors.yellow:Colors.white,
            fontSize: 15,
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;

    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
        child: Container(
          width: widths,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [
                    AppColors.gradientFirstColor,
                    AppColors.gradientSecondColor,
                  ]
              ),
              borderRadius: BorderRadius.circular(15)
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(color: Colors.white,Assets.iconsTotalBal,height: 30,),
                      const Text('  Refer and Earn',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700 ),),
                      const SizedBox(width: 50,),
                      const Text('\nBonus ',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w700 ),),
                    ],
                  ),
                  const SizedBox(height: 35,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: List.generate(
                          4,
                              (index) =>
                              Container(
                                margin: containerMargin,
                                width: containerWidth,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                    rowFilledPosition >= index
                                        ? Colors.yellow
                                        : Colors.white,
                                  ),

                                ),

                              ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: heights*0.01,),
                  const Text('User  ',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w700 ),),

                ],
              ),

              for (int i = 0; i < scaleData.length; i++) _buildValueIndicator(i),
            ],
          ),
        ),
      ),
    );
  }
}


class Constants {
  static const double borderWidth = 1.5;
  static const double containerHeight = 155.0;
  static const double containerWidth = 380.0;
  static const double arrowTop =60;
  static const double arrowRight =10.5;

  static const double valueIndicatorTop = 40.5;
  static const double valueIndicatorLeft = 35.0;
  static const double valueIndicatorSpacing = 60.0;
}