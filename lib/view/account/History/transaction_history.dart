import 'package:mahajong/generated/assets.dart';
import 'package:mahajong/res/aap_colors.dart';
import 'package:mahajong/res/components/app_bar.dart';
import 'package:mahajong/res/components/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    selectedCatIndex = 0;
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);
  }

  Future<void> _toggleBottomSheet() async {
    if (_controller.status == AnimationStatus.completed) {
      await _controller.reverse();
    } else {
      await _controller.forward();
    }
  }

  List<BetIconModel> betIconList = [
    BetIconModel(title: 'Lottery', image: Assets.imagesLotteryIcon),
    BetIconModel(title: 'Casino', image: Assets.imagesCasinoIcon),
    BetIconModel(title: 'Fishing', image: Assets.imagesFishingIcon),
    BetIconModel(title: 'PVC', image: Assets.imagesPvcIcon),
    BetIconModel(title: 'Original', image: Assets.imagesOriginalIcon),
    BetIconModel(title: 'Slots', image: Assets.imagesSlotsIcon),
  ];
  late int selectedCatIndex;

  List<History> historylist = [
    History("Cancelled", "₹100.00", "7Days - App", "P202389678"),
    History("Completed", "₹100.00", "7Days - App", "P202389678"),
    History("Cancelled", "₹100.00", "7Days - App", "P202389678"),
    History("Completed", "₹100.00", "7Days - App", "P202389678"),
  ];

  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: GradientAppBar(
          title: textWidget(
              text: 'Transaction History',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryGradient),
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: 70,
              width: widths * 0.93,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: betIconList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCatIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        height: 35,
                        width: 115,
                        decoration: BoxDecoration(
                          gradient: selectedCatIndex == index
                              ? AppColors.containerTopToBottomGradient
                              : AppColors.secondaryGradient,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey, width: 0.1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 0.2,
                              blurRadius: 2,
                              offset: const Offset(2, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('${betIconList[index].image}'),
                              height: 25,
                              color: selectedCatIndex == index
                                  ? AppColors.primaryContColor
                                  : AppColors.iconColor,
                            ),
                            textWidget(
                              text: betIconList[index].title,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: selectedCatIndex == index
                                  ? AppColors.primaryContColor
                                  : AppColors.secondaryTextColor,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: widths / 2.2,
                  decoration: BoxDecoration(
                    color: AppColors.primaryContColor,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey, width: 0.1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 0.2,
                        blurRadius: 2,
                        offset: const Offset(2, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textWidget(
                        text: '      Win Go',
                        color: AppColors.secondaryTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.keyboard_arrow_down,
                              color: AppColors.secondaryTextColor))
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: widths/2.3,
                    decoration: BoxDecoration(
                      color: AppColors.primaryContColor,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey, width: 0.1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 0.2,
                          blurRadius: 2,
                          offset: const Offset(2, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('     yyyy-MM-d').format(_selectedDate),
                          style: kButtonTextStyle,
                        ),
                        IconButton(
                            onPressed: () => _toggleBottomSheet(),
                            icon: const Icon(Icons.keyboard_arrow_down,
                                color: AppColors.secondaryTextColor))
                      ],
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: historylist.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context , index){
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 35,
                                    width: widths * 0.30,
                                    decoration:  BoxDecoration(
                                        color:  AppColors.DepositButton,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: textWidget(
                                        text: 'Transaction',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryTextColor),
                                  ),
                                ),
                                textWidget(text: "${historylist[index].method}",
                                    fontSize: widths*0.05,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.methodblue

                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textWidget(text: "Balance",
                                    fontSize: widths*0.04,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondaryTextColor

                                ),
                                textWidget(text: historylist[index].balance,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondaryTextColor


                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textWidget(text: "Type",
                                    fontSize: widths*0.04,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondaryTextColor

                                ),
                                textWidget(text: historylist[index].type,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondaryTextColor

                                ),

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textWidget(text: "Time",
                                    fontSize: widths*0.04,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondaryTextColor
                                ),
                                textWidget(
                                    text: "2024-01-18 17:36:41",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondaryTextColor

                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textWidget(text: "Order number",
                                    fontSize: widths*0.04,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondaryTextColor
                                ),
                                Row(
                                  children: [
                                    textWidget(text: historylist[index].orderno,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.secondaryTextColor
                                    ),
                                    SizedBox(width: widths*0.01,),
                                    Image.asset(Assets.iconsCopy,color: Colors.grey,height: heights*0.03,),

                                  ],
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                    );

                  }),
            ),
            textWidget(text: "No more",
                fontSize: 15,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryTextColor
            ),
            // Image(
            //   image: const AssetImage(Assets.imagesNoDataAvailable),
            //   height: heights / 3,
            //   width: widths / 2,
            // )
          ],
        ),
      ),
      bottomSheet: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return _buildBottomSheet();
        },
      ),
    );
  }

  Widget _buildBottomSheet() {
    return Container(
      height: _animation.value * 300,
      width: 400,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            _buildBottomSheetHeader(),
            SizedBox(height: 200, child: _buildMonthPicker()),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheetHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(onPressed: (){}, child: const Text('Cancel',style: TextStyle(color: AppColors.secondaryTextColor,fontSize: 14),),),
        TextButton(onPressed: (){}, child: const Text('Choose a date',style: TextStyle(color: Colors.black,fontSize: 14),),),
        TextButton(onPressed: (){}, child:  const Text('Confirm',style: TextStyle(color: AppColors.secondaryTextColor,fontSize: 14),),),
      ],
    );
  }

  static const kButtonTextStyle =
  TextStyle(fontSize: 12, color: AppColors.secondaryTextColor);
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildMonthPicker() {
    return Row(
      children: [
        Expanded(
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(
              initialItem: _selectedDate.day - 1,
            ),
            itemExtent: 35,
            onSelectedItemChanged: (dayIndex) {
              setState(() {
                _selectedDate = DateTime(
                    _selectedDate.year, _selectedDate.month, dayIndex + 1);
              });
            },
            children: List.generate(
              _getMaxDaysInMonth(_selectedDate.year, _selectedDate.month),
                  (dayIndex) {
                return Center(
                  child: Text(
                    (dayIndex + 1).toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(
              initialItem: _selectedDate.month - 1,
            ),
            itemExtent: 40,
            onSelectedItemChanged: (monthIndex) {
              setState(() {
                _selectedDate = DateTime(_selectedDate.year, monthIndex + 1, 1);
              });
            },
            children: List.generate(12, (monthIndex) {
              return Center(
                child: Text(
                  DateFormat('M')
                      .format(DateTime(_selectedDate.year, monthIndex + 1, 1)),
                  style: const TextStyle(fontSize: 18),
                ),
              );
            }),
          ),
        ),
        Expanded(
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(
              initialItem: _selectedDate.year - 2003, // Adjust the initial year
            ),
            itemExtent: 40,
            onSelectedItemChanged: (yearIndex) {
              setState(() {
                _selectedDate = DateTime(
                    2023 + yearIndex, _selectedDate.month, _selectedDate.day);
              });
            },
            children: List.generate(2024 + 1 - 2003, (yearIndex) {
              final year = 2003 + yearIndex;
              return Center(
                child: Text(
                  year.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  int _getMaxDaysInMonth(int year, int month) {
    if (month == 2) {
      // February
      return DateTime(year, month + 1, 0).day;
    } else {
      // Other months
      const List<int> daysInMonth = [
        0,
        31,
        28,
        31,
        30,
        31,
        30,
        31,
        31,
        30,
        31,
        30,
        31
      ];
      return daysInMonth[month];
    }
  }
}

class BetIconModel {
  final String title;
  final String? image;
  BetIconModel({required this.title, this.image});
}

class History{
  String method;
  String balance;
  String type;
  String orderno;
  History(this.method,this.balance,this.type,this.orderno);
}