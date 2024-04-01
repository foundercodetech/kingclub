// ignore_for_file: constant_identifier_names

class ApiUrl {
  static const String version = "1.0.1";
  static const String baseUrl = 'https://kingclub.co.in';
  static const String configModel = "$baseUrl/admin/index.php/Mahajongapi/";
  static const String laravelBaseUrl = "https://admin.kingclub.co.in/api/";
  static const String avaitorBaseUrl = "${laravelBaseUrl}aviator/";
  static const String baseurlDragon = "${laravelBaseUrl}dragon/";
  static const String baseurlPlinko = "https://admin.kingclub.co.in/api/";





  static const String uploadimage = "$baseUrl/admin/uploads/";
  static const String login = " ${configModel}login";
  static const String register = "${configModel}register";
  static const String profile = "${configModel}profile?id=";
  static const String banner = "${configModel}colour_slider";
  static const String promotionCount = "${configModel}promotion_dashboard_count?id=";
  static const String walletdash = "${configModel}wallet_dashboard?id=";
  static const String depositHistory = "${configModel}deposit_history?id=";
  static const String withdrawHistory = "${configModel}withdraw_history?id=";
  static const String aboutus = "${configModel}about_us";
  static const String addacount = "${configModel}add_account";
  static const String addAccount_View = "$baseUrl/admin/index.php/Mobile_app/account_get?user_id=";
  static const String HowtoplayApi = "$baseUrl/admin/index.php/Mobile_app/howtoplay?game_id=";
  static const String beginnerapi = "${configModel}beginner_guied_line";
  static const String notificationapi = "${configModel}notification";
  static const String giftcardapi = "${configModel}gift_cart_apply?";
  static const String coinsapi = "${configModel}coins";
  static const String mlm = "${configModel}level_getuserbyrefid?id=";
  static const String colorPrediction = "$baseUrl/admin/api/game_result.php?";
  static const String betColorPrediction = "$baseUrl/admin/api/bet.php";
  static const String withdrawl = "${configModel}withdraw";
  static const String feedback = "${configModel}feedback";
  static const String versionlink = "${configModel}version_apk_link";
  static const String profileUpdate = "${configModel}update_profile";
  static const String deposit = "${configModel}add_money";
  static const String getwayList = "${configModel}pay_modes?userid=";
  static const String colorresult = "$baseUrl/admin/api/colour_result.php?";
  static const String betHistory = "${configModel}bet_history?id=";
  static const String planMlm = "${configModel}mlm_plan";
  static const String privacypolicy = "${configModel}privacy_policy";
  static const String termscon = "${configModel}terms_condition";
  static const String contact = "${configModel}contact_us";
  static const String AttendenceList = "${configModel}attendance_list_get?userid=";
  static const String AttendenceGet = "${configModel}attendance?";
  static const String attendenceDays = "${configModel}attendance_claim?userid=";
  static const String attendenceHistory = "${configModel}attendance_history?userid=";
  static const String changepasswordapi = "${configModel}change_password";
  static const String MLM_PLAN = "${configModel}level_getuserbyrefid?id=";
  static const String walletHistory = "${configModel}wallet_history?userid=";
  static const String game_win = "${configModel}game_win?userid=";
  static const String  OTP_url= "https://otp.hopegamings.in/send_otp.php?";
  static const String  OTP_verify= "https://otp.hopegamings.in/verifyotp.php?";


///avaitor

  static const String betPlaced = "${avaitorBaseUrl}bet_now?";
  static const String aviatorCashout = "${avaitorBaseUrl}cash_out?";
  static const String betAvaiHistory = "${avaitorBaseUrl}bet_histroy?";
  static const String resultHistory = "${avaitorBaseUrl}result?limit=";
  static const String crashCheckApi = "${avaitorBaseUrl}result_bet?";


  ///Dragon Tiger
  static const String dragonbetting = "${baseurlDragon}Dragon_bet";
  static const String lastresult = "${baseurlDragon}lastresult";
  static const String last15result = "${baseurlDragon}last15result";
  static const String Dragon_ruels = "${baseurlDragon}dragon_ruels";
  static const String bethistory = "${baseurlDragon}dragonbet_history?userid=";


  ///Plinko

  static const String greenListTable = "${baseurlPlinko}plinko-green-table";
  static const String redListTable = "${baseurlPlinko}plinko-red-table";
  static const String lastResult = "${baseurlPlinko}last12result";
  static const String plinkoBet = "${baseurlPlinko}plinko_bet";
  static const String plinkoBetHistory = "${baseurlPlinko}plinko_bet_history?userid=";
  static const String plinko_ruels = "${baseurlPlinko}plinko_ruels";


}

