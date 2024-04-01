import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mahajong/generated/assets.dart';
import 'package:mahajong/res/api_urls.dart';
import 'package:mahajong/res/components/app_btn.dart';
import 'package:mahajong/res/components/text_widget.dart';


class DragonRules extends StatefulWidget {
  const DragonRules({Key? key}) : super(key: key);

  @override
  State<DragonRules> createState() => _DragonRulesState();
}

class _DragonRulesState extends State<DragonRules> {
  var data;
  Future<void> Dragon_ruelsed() async {
    print('aaaaaaa');
    final response = await http.get(Uri.parse(ApiUrl.Dragon_ruels));
    // .onError((error, stackTrace) => InternetSlowMsg(context));
    final datas = jsonDecode(response.body);
    print('aaaaaaaaaaaa');
    print(ApiUrl.Dragon_ruels);
    print(datas);
    if (datas['status'] == "200") {
      setState(() {
        data = datas['data'];
      });
      print(data);
    } else {}
  }

  @override
  void initState() {
    Dragon_ruelsed();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(

          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red,
          title: textWidget(text: "Rules",fontSize: 18,color: Colors.white),
          leading: AppBackBtn(),

        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            // image: DecorationImage(
            //     fit: BoxFit.fill, image: AssetImage(background)
            // ),
          ),
          child: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                physics: const BouncingScrollPhysics(),
                child: data == null
                    ? const Center(child: CircularProgressIndicator())
                    : HtmlWidget(
                        data['disc'].toString(),
                      ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
