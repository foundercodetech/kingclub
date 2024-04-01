import 'package:flutter/material.dart';

class AppColors {
  static const primaryTextColor = Color(0xFFFFFFFF);
  static const secondaryTextColor = Color(0xFFa6a6a6);
  static const gradientFirstColor = Color(0xFFde2325);
  static const gradientSecondColor = Color(0xFFff504a);
  static const dividerColor = Color(0xFFa6a6a6);
  static const iconColor = Color(0xFFa6a6a6);
  static const iconSecondColor = Color(0xFFFFFFFF);
  static const primaryContColor = Color(0xFFFFFFFF);
  static const containerBgColor = Color(0xFFf95959);
  static const TextBlack = Colors.black;
  static const methodblue =Color(0xff598ff9);
  static const DepositButton =Color(0xff34be8a);
  static const ContainerBorderWhite = Color(0xFFFFFFFF);
  static const scaffolddark = Color(0xff292929);

  static Color scaffoldColor = Colors.cyanAccent.withOpacity(0.01);
  static Color circleBorderColor = Colors.blueGrey.withOpacity(0.08);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientFirstColor, gradientSecondColor],
  );
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
  );
  static const LinearGradient inactiveGradient = LinearGradient(
    colors: [Color(0xFFCFD1DF), Color(0xFFC8CADA)],
  );
  static const LinearGradient containerGradient = LinearGradient(
    colors: [Color(0xFFF83A39), Color(0xFFFF746B)],
  );static const LinearGradient containerTopToBottomGradient = LinearGradient(
    colors: [Color(0xFFF83A39), Color(0xFFFF746B)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter
  );
  static const LinearGradient containerGreenGradient = LinearGradient(
    colors: [Color(0xFF15CEA2 ), Color(0xFFB6FFE0)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter
  );
  static const LinearGradient containerYellowGradient = LinearGradient(
    colors: [Color(0xFFF87700 ), Color(0xFFFFCE22)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter
  );
  static const LinearGradient containerBlueGradient = LinearGradient(
    colors: [Color(0xFF5CA6FF ), Color(0xFFA9E5FF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter
  );
  static const LinearGradient btnYellowGradient = LinearGradient(
    colors: [Color(0xFFf3bd14), Color(0xFFf3bd14)],
  );

  static const LinearGradient btnBlueGradient = LinearGradient(
    colors: [Color(0xFF6da7f4), Color(0xFF6da7f4)],
  );
}

