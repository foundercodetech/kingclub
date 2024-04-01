// ignore_for_file: depend_on_referenced_packages, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart' as http;
import 'package:mahajong/res/api_urls.dart';
import 'package:mahajong/res/components/app_btn.dart';
import 'package:mahajong/res/components/text_widget.dart';


class PlinkoRules extends StatefulWidget {
  const PlinkoRules({Key? key}) : super(key: key);

  @override
  State<PlinkoRules> createState() => _PlinkoRulesState();
}

class _PlinkoRulesState extends State<PlinkoRules> {
  var data;
  Future<void> Plinko_rules() async {
    if (kDebugMode) {
      print('aaaaaaa');
    }
    final response = await http.get(Uri.parse(ApiUrl.plinko_ruels));
    final datas = jsonDecode(response.body);
    if (kDebugMode) {
      print('aaaaaaaaaaaa');
      print(ApiUrl.plinko_ruels);
      print(datas);
    }

    if (datas['status'] == "200") {
      setState(() {
        data = datas['data'];
      });
      print(data);
    } else {}
  }

  @override
  void initState() {
    Plinko_rules();
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
          leading: const AppBackBtn(),

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
