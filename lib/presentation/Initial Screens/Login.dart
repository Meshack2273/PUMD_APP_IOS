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

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
    return PopScope(
        onPopInvoked: (tru) async {
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
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: TextField(
                        controller: Username,
                        decoration: const InputDecoration(
                            // hintText: "Enter Username",
                            label: Text("Username"),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: TextField(
                        obscureText: passwordVisible,
                        controller: Password,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(
                                  () {
                                    passwordVisible = !passwordVisible;
                                  },
                                );
                              },
                            ),
                            // hintText: "Enter Password",
                            label: Text("Password"),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      child: TextButton.icon(
                    onPressed: () async {},
                    label: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    icon: Icon(
                      Icons.login,
                      color: Colors.white,
                      weight: 5,
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                            const EdgeInsets.only(
                                top: 15, right: 35, left: 25, bottom: 15)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            HexColor("#ee3124"))),
                  ))
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
