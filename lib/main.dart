import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:pumd_app_ios/core/utils/Model.dart';

import 'package:pumd_app_ios/presentation/frame_one_screen/frame_one_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pumd_app_ios/presentation/frame_three_screen/pdfScreen.dart';
import 'package:pumd_app_ios/routes/app_routes.dart';
import 'package:pumd_app_ios/staticVariable.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.standard,
      ),
      title: 'pumd_app_ios',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.frameOneScreen,
      routes: AppRoutes.routes,
    );
  }
}
