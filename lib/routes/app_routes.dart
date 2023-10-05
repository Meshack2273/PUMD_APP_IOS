import 'package:flutter/material.dart';
import 'package:pumd_app_ios/presentation/frame_one_screen/frame_one_screen.dart';
import 'package:pumd_app_ios/presentation/frame_two_screen/frame_two_screen.dart';

// import 'package:pumd_app_ios/presentation/frame_three_screen/frame_three_screen.dart';
import 'package:pumd_app_ios/presentation/frame_five_screen/frame_five_screen.dart';
import 'package:pumd_app_ios/presentation/frame_four_screen/frame_four_screen.dart';
import 'package:pumd_app_ios/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:pumd_app_ios/widgets/loding_Scren.dart';
import 'package:pumd_app_ios/widgets/loding_ScrenWithTime.dart';
import 'package:pumd_app_ios/presentation/Initial Screens/Home.dart';
import 'package:pumd_app_ios/presentation/Initial Screens/Login.dart';
import '../presentation/frame_three_screen/pdfScreen.dart';
import '../staticVariable.dart';

class AppRoutes {
  static const String home = '/Home';
  static const String login = '/Login';
  static const String frameOneScreen = '/frame_one_screen';

  static const String frameTwoScreen = '/frame_two_screen';

  static const String frameThreeScreen = '/frame_three_screen';

  static const String frameFiveScreen = '/frame_five_screen';

  static const String frameFourScreen = '/frame_four_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String loding = '/loding';

  static const String lodingWithTime = '/lodingWithTime';

  static const String pdfScreen = "/pdfScreen";

  static Map<String, WidgetBuilder> routes = {
    home: (context) => Home(),
    login: (context) => Login(),
    loding: (context) => lodingScreen(),
    lodingWithTime: (context) => lodingScreenWithTime(),
    pdfScreen: (context) => PDFScreen(),
    frameOneScreen: (context) => const FrameOneScreen(),
    frameTwoScreen: (context) => const FrameTwoScreen(),
    // frameThreeScreen: (context) => const FrameThreeScreen(),
    frameFiveScreen: (context) => const FrameFiveScreen(),
    frameFourScreen: (context) => const FrameFourScreen(),
    appNavigationScreen: (context) => AppNavigationScreen()
  };
}
