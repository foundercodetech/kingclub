// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:mahajong/model/ContactUsmodel.dart';
import 'package:mahajong/model/Slider_model.dart';
import 'package:mahajong/model/aboutus_model.dart';
import 'package:mahajong/model/addaccount_view_model.dart';
import 'package:mahajong/model/beginner_model.dart';
import 'package:mahajong/model/coin_model.dart';
import 'package:mahajong/model/colorprediction_model.dart';
import 'package:mahajong/model/deposit_model.dart';
import 'package:mahajong/model/howtoplay_model.dart';
import 'package:mahajong/model/mlm_model.dart';
import 'package:mahajong/model/notification_model.dart';
import 'package:mahajong/model/promotion_count_model.dart';
import 'package:mahajong/model/termsconditionModel.dart';
import 'package:mahajong/model/user_model.dart';
import 'package:mahajong/model/user_profile_model.dart';
import 'package:mahajong/model/wallet_model.dart';
import 'package:mahajong/model/withdrawhistory_model.dart';
import 'package:mahajong/res/api_urls.dart';
import 'package:mahajong/res/provider/mlm_provider.dart';
import 'package:mahajong/res/provider/user_view_provider.dart';
import 'package:http/http.dart' as http;

class BaseApiHelper {
  /// get profile
  UserViewProvider userProvider = UserViewProvider();

  Future<UserProfile?> fetchProfileData() async {
    //get id
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    try {
      final response = await http.get(Uri.parse(ApiUrl.profile + token),).timeout(const Duration(seconds: 10));
      print(ApiUrl.profile + token);
      print("response");

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body)['user'];
        print(jsonMap);
        print("jsonMap");

        return UserProfile.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  //slider
  // Future<SliderModel?> fetchSliderData() async {
  //   // SliderModel slider = await sliderProvider.getUser();
  //   try {
  //     final response = await http.get(Uri.parse(ApiUrl.banner),
  //     ).timeout(const Duration(seconds: 10));
  //     print(ApiUrl.banner);
  //     print("ApiUrl.banner");
  //     print(response);
  //     print("response");
  //
  //     if (response.statusCode == 200) {
  //       final jsonMap = json.decode(response.body)['data'];
  //       print(jsonMap);
  //       print("jsonMap");
  //
  //       return SliderModel.fromJson(jsonMap);
  //     } else {
  //       throw Exception('Failed to load user data');
  //     }
  //   } on SocketException {
  //     throw Exception('No Internet connection');
  //   }
  // }

  ///slider
  Future<List<SliderModel>> fetchSliderData() async {
    try {
      final response = await http
          .get(Uri.parse(ApiUrl.banner))
          .timeout(const Duration(seconds: 10));
      print(ApiUrl.banner);
      print("ApiUrl.banner");
      print(response);
      print("response");

      // final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body)['data'];
        print(jsonList);
        print("jsonList");

        List<SliderModel> sliderList =
            jsonList.map((jsonMap) => SliderModel.fromJson(jsonMap)).toList();
        return sliderList;
      } else {
        throw Exception('Failed to load slider data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  // Future<List<SliderModel>> fetchSliderData() async {
  //   try {
  //     final response = await http.get(Uri.parse(ApiUrl.banner)).timeout(const Duration(seconds: 10));
  //     print(ApiUrl.banner);
  //     print("ApiUrl.banner");
  //     print(response);
  //     print("response");
  //
  //     final Map<String, dynamic> data = json.decode(response.body);
  //     if (data['msg'] == 200) {
  //       final List<dynamic> jsonList = data['data'];
  //       print(jsonList);
  //       print("data");
  //
  //       List<SliderModel> sliderList = jsonList.map((jsonMap) => SliderModel.fromJson(jsonMap)).toList();
  //       return sliderList;
  //     } else {
  //       throw Exception('Failed to load slider data: ${data['message']}');
  //     }
  //   } on SocketException {
  //     throw Exception('No Internet connection');
  //   }
  // }

  /// promotioncount

  Future<PromotionCountModel?> fetchPromtionCount() async {
    //get id
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    try {
      final response = await http
          .get(
            Uri.parse(ApiUrl.promotionCount + token),
          )
          .timeout(const Duration(seconds: 10));
      print(ApiUrl.promotionCount + token);
      print("ApiUrl.promotionCount + token");
      print(response);
      print("response");

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body);
        print(jsonMap);
        print("jsonMap");

        return PromotionCountModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  ///deposithistory

  Future<List<DepositModel>?> fetchDepositHistoryData() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    try {
      final response = await http.get(Uri.parse(ApiUrl.depositHistory+token)).timeout(const Duration(seconds: 10));
      print(ApiUrl.depositHistory + token);
      print("ApiUrl.depositHistory");
      print(response);
      print("response deposit");

      // final Map<String, dynamic> data = json.decode(response.body)['data'];

      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body);
        if (jsonList['status'] == "200") {
          final List<dynamic> data = json.decode(response.body)['data'];
          List<DepositModel> depositList = data.map((jsonMap) => DepositModel.fromJson(jsonMap)).toList();
          return depositList;
        } else {
          print("else");
          return null;
        }
      }
      // else if(response.statusCode == 400){
      //   final jsonList = json.decode(response.body)['data'];
      //   print(jsonList);
      //   print("jsonList null");
      //
      //   if (jsonList != null) {
      //     List<DepositModel> depositList = jsonList.map((jsonMap) => DepositModel.fromJson(jsonMap)).toList();
      //     return depositList;
      //   } else {
      //     return [];
      //   }
      // }
      else {
        throw Exception('Failed to load data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  ///withdrawHistory

  Future<List<WithdrawModel>?> fetchWithdrawHistoryData() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    try {
      final response = await http.get(Uri.parse(ApiUrl.withdrawHistory)).timeout(const Duration(seconds: 10));
      print(ApiUrl.withdrawHistory+token);
      print("ApiUrl.withdrawHistory");
      print(response);
      print("response withdraw");

      // final Map<String, dynamic> data = json.decode(response.body)['data'];

      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body);
        if (jsonList['status'] == "200") {
          final List<dynamic> data = json.decode(response.body)['data'];
          List<WithdrawModel> withdrawlist = data.map((jsonMap) => WithdrawModel.fromJson(jsonMap)).toList();
          return withdrawlist;
        } else {
          print("else");
          return null;
        }
      }
      else {
        throw Exception('Failed to load data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  ///about us
  Future<AboutusModel?> fetchaboutusData() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.aboutus)).timeout(const Duration(seconds: 10));
      print(ApiUrl.aboutus);
      print("response");

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body)['data'][0];
        print(jsonMap);
        print("jsonMap");

        return AboutusModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  ///termscondition

  Future<TcModel?> fetchdataTC() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.termscon)).timeout(const Duration(seconds: 10));
      print(ApiUrl.aboutus);
      print("response");

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body)['data'][0];
        print(jsonMap);
        print("jsonMap");

        return TcModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  ///privacy policy

  Future<TcModel?> fetchdataPP() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.privacypolicy)).timeout(const Duration(seconds: 10));
      print(ApiUrl.privacypolicy);
      print("response privacypolicy");

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body)['data'][0];
        print(jsonMap);
        print("jsonMap");

        return TcModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  ///contact us

  Future<Contactusmodel?> fetchdataCU() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.contact)).timeout(const Duration(seconds: 10));
      print(ApiUrl.contact);
      print("response contact");

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body)['data'][0];
        print(jsonMap);
        print("jsonMap");

        return Contactusmodel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  ///wallet

  // Future<List<WalletModel>?> fetchWalletData() async {
  //   UserModel user = await userProvider.getUser();
  //   String token = user.id.toString();
  //
  //   try {
  //     final response = await http.get(Uri.parse(ApiUrl.walletdash+token)).timeout(const Duration(seconds: 10));
  //     print(ApiUrl.walletdash + token);
  //     print("ApiUrl.walletdash");
  //     print(response);
  //     print("response walletdash");
  //
  //     // final Map<String, dynamic> data = json.decode(response.body)['data'];
  //
  //     if (response.statusCode == 200) {
  //       final jsonList = json.decode(response.body);
  //       if (jsonList['status'] == "200") {
  //         final List<dynamic> data = json.decode(response.body)['data'][0];
  //         List<WalletModel> walletListt = data.map((jsonMap) => WalletModel.fromJson(jsonMap)).toList();
  //         return walletListt;
  //       } else {
  //         print("else");
  //         return null;
  //       }
  //     }
  //
  //     else {
  //       throw Exception('Failed to load data');
  //     }
  //   } on SocketException {
  //     throw Exception('No Internet connection');
  //   }
  // }

  Future<WalletModel?> fetchWalletData() async {
    //get id
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    try {
      final response = await http.get(Uri.parse(ApiUrl.walletdash + token),).timeout(const Duration(seconds: 10));
      print(ApiUrl.walletdash + token);
      print("response walletdash");

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body)['data'][0];
        print(jsonMap);
        print("jsonMap");

        return WalletModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }
  // Future<WalletModel> fetchWalletData() async {
  //   //get id
  //   UserModel user = await userProvider.getUser();
  //   String token = user.id.toString();
  //
  //   try {
  //     final response = await http.get(Uri.parse(ApiUrl.walletdash+token)).timeout(const Duration(seconds: 10));
  //     print(ApiUrl.walletdash + token);
  //     print("response walletdash");
  //
  //     if (response.statusCode == 200) {
  //       final jsonMap = json.decode(response.body)['data'];
  //       print(jsonMap);
  //       print("jsonMap");
  //
  //       return WalletModel.fromJson(jsonMap);
  //     } else {
  //       throw Exception('Failed to load user data');
  //     }
  //   } on SocketException {
  //     throw Exception('No Internet connection');
  //   }
  // }

  /// add acount view

  Future<List<AddacountViewModel>?> viewAddAccountData() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    try {
      final response = await http.get(Uri.parse(ApiUrl.addAccount_View+token)).timeout(const Duration(seconds: 10));
      print(ApiUrl.addAccount_View+token);
      print("ajay");
      print(response);
      print("response addAccount_View");

      // final Map<String, dynamic> data = json.decode(response.body)['data'];

      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body);
        print(jsonList);
        print('ram');
        if (jsonList['error'] == "200") {
          final List<dynamic> data = json.decode(response.body)['data'];
          List<AddacountViewModel> accountViewList = data.map((jsonMap) => AddacountViewModel.fromJson(jsonMap)).toList();
          return accountViewList;
        } else {
          print("else");
          return null;
        }
      }
      else {
        throw Exception('Failed to load data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  ///how to play

  Future<HowtoplayModel?> fetchHowtoplayData() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    try {
      final response = await http.get(Uri.parse('${ApiUrl.HowtoplayApi}2')).timeout(const Duration(seconds: 10));
      print(ApiUrl.HowtoplayApi);
      print("response HowtoplayApi");

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body)['data'][0];
        print(jsonMap);
        print("jsonMap");

        return HowtoplayModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  ///beginnerguide

  Future<BeginnerModel?> fetchBeginnerData() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.beginnerapi)).timeout(const Duration(seconds: 10));
      print(ApiUrl.beginnerapi);
      print("response");

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body)['data'][0];
        print(jsonMap);
        print("jsonMap");

        return BeginnerModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }


  ///notification

  Future<NotificationModel?> fetchNotificationData() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.notificationapi)).timeout(const Duration(seconds: 10));
      print(ApiUrl.notificationapi);
      print("response NotificationModel");

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body)['data'];
        print(jsonMap);
        print("jsonMap");

        return NotificationModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  ///coins

  Future<List<CoinModel>?> fetchCoinsData() async {

    // UserModel user = await userProvider.getUser();
    // String token = user.id.toString();

    try {
      final response = await http.get(Uri.parse(ApiUrl.coinsapi)).timeout(const Duration(seconds: 10));
      print(ApiUrl.coinsapi);
      print("ApiUrl.coinsapi");
      print(response);
      print("response ApiUrl.coinsapi");

      // final Map<String, dynamic> data = json.decode(response.body)['data'];

      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body);
        if (jsonList['status'] == "200") {
          final List<dynamic> data = json.decode(response.body)['data'];
          List<CoinModel> coinlist = data.map((jsonMap) => CoinModel.fromJson(jsonMap)).toList();
          return coinlist;
        } else {
          print("else");
          return null;
        }
      }
      else {
        throw Exception('Failed to load data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  // Future<CoinModel?> fetchCoinsData() async {
  //   try {
  //     final response = await http.get(Uri.parse(ApiUrl.coinsapi)).timeout(const Duration(seconds: 10));
  //     print(ApiUrl.coinsapi);
  //     print("response coinsapi");
  //
  //     if (response.statusCode == 200) {
  //       final jsonMap = json.decode(response.body)['data'];
  //       print(jsonMap);
  //       print("jsonMap");
  //
  //       return CoinModel.fromJson(jsonMap);
  //     } else {
  //       throw Exception('Failed to load user data');
  //     }
  //   } on SocketException {
  //     throw Exception('No Internet connection');
  //   }
  // }


   ///plan mlm

  // Future<List<Mlm>?> fetchmlmData() async {
  //   try {
  //     final response = await http.get(Uri.parse(ApiUrl.mlm)).timeout(const Duration(seconds: 10));
  //     print(ApiUrl.mlm);
  //     print("ApiUrl.mlm");
  //     print(response);
  //     print("response ApiUrl.mlm");
  //
  //     // final Map<String, dynamic> data = json.decode(response.body)['data'];
  //
  //     if (response.statusCode == 200) {
  //       final jsonList = json.decode(response.body);
  //       if (jsonList['status'] == "200") {
  //         final List<dynamic> data = json.decode(response.body)['data'];
  //         // List<Mlm> mlmlist = data.map((jsonMap) => Mlm.fromJson(jsonMap)).toList();\
  //      //   Provider.of<CommissionProvider>(context, listen: false).updateCommissionData(commissionData);
  //
  //         return mlmlist;
  //       } else {
  //         print("else");
  //         return null;
  //       }
  //     }
  //     else {
  //       throw Exception('Failed to load data');
  //     }
  //   } on SocketException {
  //     throw Exception('No Internet connection');
  //   }
  // }

  // Future<void> fetchDataFromAPI() async {
  //   final response = await http.get(Uri.parse(ApiUrl.mlm)).timeout(const Duration(seconds: 10));
  //
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     final commissionData = CommissionData.fromJson(data);
  //
  //     // Use Provider to update the state
  //     context.read<CommissionDataProvider>().setCommissionData(commissionData);
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }

  ///color prediction

  Future<List<ColorPredictionModel>?> fetchColorPredictionResult(String page) async {
    // UserModel user = await userProvider.getUser();
    // String token = user.id.toString();
    try {
      final response = await http.get(Uri.parse("${ApiUrl.colorPrediction}limit=$page")).timeout(const Duration(seconds: 10));
      print(ApiUrl.colorPrediction);
      print("ApiUrl.colorPrediction");
      print(response);
      print("response colorPrediction");


      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body);
        if (jsonList['error'] == "200") {
          final List<dynamic> data = json.decode(response.body)['data'];
          List<ColorPredictionModel> colorResultList = data.map((jsonMap) => ColorPredictionModel.fromJson(jsonMap)).toList();
          return colorResultList;
        } else {
          print("else");
          return null;
        }
      }
      else {
        throw Exception('Failed to load data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }



}

