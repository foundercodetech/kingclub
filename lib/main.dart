import 'package:mahajong/Aviator/AviatorProvider.dart';
import 'package:mahajong/model/colorPredictionResult_provider.dart';
import 'package:mahajong/res/app_constant.dart';
import 'package:mahajong/res/provider/Beginner_provider.dart';
import 'package:mahajong/res/provider/Howtoplay_Provider.dart';
import 'package:mahajong/res/provider/TermsConditionProvider.dart';
import 'package:mahajong/res/provider/aboutus_provider.dart';
import 'package:mahajong/res/provider/addaccount_view_provider.dart';
import 'package:mahajong/res/provider/addacount_controller.dart';
import 'package:mahajong/res/provider/auth_provider.dart';
import 'package:mahajong/res/provider/betColorPrediction_provider.dart';
import 'package:mahajong/res/provider/coins_provider.dart';
import 'package:mahajong/res/provider/contactus_provider.dart';
import 'package:mahajong/res/provider/deposit_provider.dart';
import 'package:mahajong/res/provider/feedback_provider.dart';
import 'package:mahajong/res/provider/giftcode_provider.dart';
import 'package:mahajong/res/provider/notification_provider.dart';
import 'package:mahajong/res/provider/privacypolicy_provider.dart';
import 'package:mahajong/res/provider/profile_provider.dart';
import 'package:mahajong/res/provider/promotion_count_provider.dart';
import 'package:mahajong/res/provider/slider_provider.dart';
import 'package:mahajong/res/provider/user_view_provider.dart';
import 'package:mahajong/res/provider/wallet_provider.dart';
import 'package:mahajong/res/provider/withdrawhistory_provider.dart';
import 'package:mahajong/utils/routes/routes.dart';
import 'package:mahajong/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserAuthProvider()),
        ChangeNotifierProvider(create: (context) => AviatorWallet()),
        ChangeNotifierProvider(create: (context) => UserViewProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => SliderProvider()),
        ChangeNotifierProvider(create: (context) => PromotionCountProvider()),
        ChangeNotifierProvider(create: (context) => DepositProvider()),
        ChangeNotifierProvider(create: (context) => WithdrawHistoryProvider()),
        ChangeNotifierProvider(create: (context) => AboutusProvider()),
        ChangeNotifierProvider(create: (context) => WalletProvider()),
        ChangeNotifierProvider(create: (context) => AddacountProvider()),
        ChangeNotifierProvider(create: (context) => AddacountViewProvider()),
        ChangeNotifierProvider(create: (context) => BeginnerProvider()),
        ChangeNotifierProvider(create: (context) => HowtoplayProvider()),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
        ChangeNotifierProvider(create: (context) => GiftcardProvider()),
        ChangeNotifierProvider(create: (context) => CoinProvider()),
        // ChangeNotifierProvider(create: (context) => MlmProvider()),
        ChangeNotifierProvider(create: (context) => ColorPredictionProvider()),
        ChangeNotifierProvider(create: (context) => BetColorResultProvider()),
        ChangeNotifierProvider(create: (context) => FeedbackProvider()),
        ChangeNotifierProvider(create: (context) => TermsConditionProvider()),
        ChangeNotifierProvider(create: (context) => PrivacyPolicyProvider()),
        ChangeNotifierProvider(create: (context) => ContactUsProvider()),
      ],
      child:  MaterialApp(
        // home: WalletScreen(),
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesName.splashScreen,
        onGenerateRoute: (settings) {
          if (settings.name != null) {
            return MaterialPageRoute(
              builder: Routers.generateRoute(settings.name!),
              settings: settings,
            );
          }
          return null;
        },
      ),
    );
  }
}
