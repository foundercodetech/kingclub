import 'package:flutter/material.dart';
import 'package:mahajong/res/aap_colors.dart';
import 'package:mahajong/res/components/app_bar.dart';
import 'package:mahajong/res/components/app_btn.dart';
import 'package:mahajong/res/components/text_widget.dart';

class SelectBank extends StatefulWidget {
  const SelectBank({super.key});

  @override
  State<SelectBank> createState() => _SelectBankState();
}

class _SelectBankState extends State<SelectBank> {
  List<BankNameModel> bankNameList = [
    BankNameModel(id: '1', title: 'Bank of Baroda'),
    BankNameModel(id: '2', title: 'Central Bank of India'),
    BankNameModel(id: '3', title: 'Union Bank of India'),
    BankNameModel(id: '4', title: 'Yes Bank'),
    BankNameModel(id: '5', title: 'HDFC Bank'),
    BankNameModel(id: '6', title: 'Karnataka Bank'),
    BankNameModel(id: '7', title: 'Standard Chartered Bank'),
    BankNameModel(id: '8', title: 'Karnataka Bank'),
    BankNameModel(id: '9', title: 'IDBI Bank'),
    BankNameModel(id: '10', title: 'Bank of India'),
    BankNameModel(id: '11', title: 'Punjab National Bank'),
    BankNameModel(id: '12', title: 'ICICI Bank'),
    BankNameModel(id: '13', title: 'Canara Bank'),
    BankNameModel(id: '14', title: 'Kotak Mahindra Bank'),
    BankNameModel(id: '15', title: 'State Bank of India'),
    BankNameModel(id: '16', title: 'Indian Bank'),
    BankNameModel(id: '17', title: 'Axis Bank'),
  ];
  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: GradientAppBar(
          leading: const AppBackBtn(),
          title: textWidget(
              text: 'Select', fontSize: 25, color: AppColors.primaryTextColor),
          gradient: AppColors.primaryGradient),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
                height: 60,
                width: widths,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: AppColors.primaryContColor,
                    borderRadius: BorderRadiusDirectional.circular(30)),
                child: const Center(
                  child: TextField(
                    cursorColor: AppColors.secondaryTextColor,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search,
                            size: 40, color: AppColors.gradientSecondColor),
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
                        ),
                        border: InputBorder.none,
                        hintText: 'Search bank',
                        hintStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryTextColor)),
                  ),
                )),
            const SizedBox(height: 20),
            Container(
                height: heights * 0.77,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: AppColors.primaryContColor,
                    borderRadius: BorderRadiusDirectional.circular(15)),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                        child: textWidget(
                            text: 'Choose a bank',
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: bankNameList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: (){},
                              leading: textWidget(text: ''),
                              title: textWidget(
                                  text: bankNameList[index].title,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                color: AppColors.secondaryTextColor
                              ),
                            );
                          }),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class BankNameModel {
  final String id;
  final String title;

  BankNameModel({
    required this.id,
    required this.title,
  });
}