import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pumd_app_ios/routes/app_routes.dart';

import '../../core/utils/image_constant.dart';

bool passwordVisible = true;
TextEditingController Username = TextEditingController();
TextEditingController Password = TextEditingController();

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  void initState() {
    setState(() {
      isDeviceConnected = false;
    });
    // getConnectivity();
    super.initState();
  }

  // getConnectivity() =>
  //     subscription = Connectivity().onConnectivityChanged.listen(
  //       (ConnectivityResult result) async {
  //         isDeviceConnected = await InternetConnectionChecker().hasConnection;
  //         print("${isDeviceConnected}  Checking");
  //         if (!isDeviceConnected && isAlertSet == false) {
  //           ConectionDialog();
  //           setState(() => isAlertSet = true);
  //         }
  //       },
  //     );

  ConectionDialog() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  ConectionDialog();
                  setState(() {
                    isAlertSet = true;
                  });
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );

  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: HexColor("#bbb8b8"),
            body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      margin: EdgeInsets.only(top: 50, left: 120, right: 120),
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 20),
                      child: AspectRatio(
                          aspectRatio: 8 / 5, // Set the desired aspect ratio
                          child: Image.asset(
                            ImageConstant.imgImage1,
                          ))),
                  SizedBox(
                    height: 130,
                  ),
                  Container(
                      child: TextButton.icon(
                    onPressed: () async {
                      Navigator.pushNamed(context, AppRoutes.login);
                    },
                    label: const Text(
                      "Engineer",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    icon: Icon(
                      Icons.engineering_rounded,
                      color: Colors.white,
                      weight: 5,
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                            const EdgeInsets.only(
                                top: 15, right: 35, left: 25, bottom: 15)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            HexColor("#ee3124"))),
                  )),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      child: TextButton.icon(
                    onPressed: () async {
                      Navigator.pushNamed(context, AppRoutes.frameOneScreen);
                    },
                    label: const Text(
                      "Guest",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    icon: Icon(
                      Icons.person_2_rounded,
                      color: Colors.white,
                      weight: 5,
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                            const EdgeInsets.only(
                                top: 15, right: 45, left: 35, bottom: 15)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            HexColor("#ee3124"))),
                  )),
                  SizedBox(
                    height: 30,
                  ),
                ]))));
  }

  ConectionDialogForLoginPage() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );

  ConnectionTimeoutDialog() => showCupertinoDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text("Connection Timeout"),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );

  GetConectionDialog() => showCupertinoDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );

  ServiceUnAvilableDialog() => showCupertinoDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Service Unavailable'),
          content: const Text('Check After Some Time'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );

  UsernamePassDialog() {
    showCupertinoDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(""),
        content: const Text('Please check your Username Password'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
