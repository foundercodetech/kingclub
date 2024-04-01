import 'package:mahajong/model/addaccount_view_model.dart';
import 'package:mahajong/res/aap_colors.dart';
import 'package:mahajong/res/components/app_bar.dart';
import 'package:mahajong/res/components/app_btn.dart';
import 'package:mahajong/res/components/text_widget.dart';
import 'package:flutter/material.dart';

class AccountView extends StatefulWidget {
  final AddacountViewModel data;
  const AccountView({super.key,required this.data});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
final height= MediaQuery.of(context).size.height;
final width= MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: GradientAppBar(
            leading: const AppBackBtn(),
            title: textWidget(
                text: 'Account Details',
                fontSize: 25,
                color: AppColors.primaryTextColor),
            gradient: AppColors.primaryGradient),
      body: Column(
        children: [
          SizedBox(height: height*0.04,),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                ListTile(
                  title: textWidget(text: "Name",fontSize: 14,fontWeight: FontWeight.bold),
                  trailing: textWidget(text: widget.data.name.toString(),fontWeight: FontWeight.w600),
                ),
                const Divider(indent: 15,endIndent: 15,),
                ListTile(
                  title: textWidget(text: "Account Number",fontSize: 14,fontWeight: FontWeight.bold),
                  trailing: textWidget(text: widget.data.account_no.toString(),fontWeight: FontWeight.w600),
                ),
                const Divider(indent: 15,endIndent: 15,),

                ListTile(
                  title: textWidget(text: "Bank Name",fontSize: 14,fontWeight: FontWeight.bold),
                  trailing: textWidget(text: widget.data.bank_name.toString(),fontWeight: FontWeight.w600),
                ),
                const Divider(indent: 15,endIndent: 15,),

                ListTile(
                  title: textWidget(text: "Branch",fontSize: 14,fontWeight: FontWeight.bold),
                  trailing: textWidget(text: widget.data.branch.toString(),fontWeight: FontWeight.w600),
                ),
                const Divider(indent: 15,endIndent: 15,),

                ListTile(
                  title: textWidget(text: "IFSC",fontSize: 14,fontWeight: FontWeight.bold),
                  trailing: textWidget(text: widget.data.ifsc.toString(),fontWeight: FontWeight.w600),
                ),


              ],
            ),
          ),
        ],
      )


    );

      }
}
