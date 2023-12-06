import 'dart:async';
import 'dart:convert';
import 'dart:io';
// import 'package:pdfx/pdfx.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pumd_app_ios/presentation/frame_one_screen/frame_one_screen.dart'
    as screnone;
import 'package:pumd_app_ios/core/app_export.dart';
import 'package:pumd_app_ios/staticVariable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_screen/flutter_secure_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../../ApiCall.dart';
import '../frame_three_screen/pdfScreen.dart';

bool foc = true;
TextEditingController Otp1 = TextEditingController();
TextEditingController Otp2 = TextEditingController();
TextEditingController Otp3 = TextEditingController();
TextEditingController Otp4 = TextEditingController();
TextEditingController allotp = TextEditingController();

class FrameTwoScreen extends StatefulWidget {
  const FrameTwoScreen({Key? key}) : super(key: key);

  @override
  State<FrameTwoScreen> createState() => _FrameTwoScreenState();
}

class _FrameTwoScreenState extends State<FrameTwoScreen> {
  List otp = [];
  Duration sec = Duration(seconds: 1);
  bool boole = true;
  int start = 30;
  bool wait = false;

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    print("initstay");
    startTimer();
    otp = [Otp1, Otp2, Otp3, Otp4];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          StaticControler.fabnumber = "";
          screnone.fabNum.text = "";
          Navigator.pushNamed(context, AppRoutes.frameOneScreen);
          return true; // return true to allow the pop
        },
        child: SafeArea(
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Container(
                                  padding: getPadding(
                                      left: 19, top: 20, right: 19, bottom: 15),
                                  decoration: AppDecoration.fillBluegray100,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(children: [
                                          TextButton.icon(
                                              onPressed: () {
                                                Navigator.pushNamed(context,
                                                    AppRoutes.frameOneScreen);
                                              },
                                              icon: const Icon(
                                                Icons.home,
                                                size: 30,
                                              ),
                                              label: const Text("")),

                                          // Container(margin: EdgeInsets.only(right:30),
                                          //     child: TextButton.icon(onPressed: (){Navigator.pushNamed(context,AppRoutes.frameOneScreen);},
                                          //         icon:const Icon(Icons.home,size: 30,), label: const Text(""))
                                          // ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: 10, left: 60),
                                              child: CustomImageView(
                                                  imagePath:
                                                      ImageConstant.imgImage1,
                                                  height: 50,
                                                  width: 110)),
                                        ]),
                                        Container(
                                            padding:
                                                getPadding(top: 10, bottom: 30),
                                            width: getHorizontalSize(213),
                                            margin: getMargin(top: 130),
                                            child: Text(
                                                "Email OTP has been Sent To :"
                                                        "\n" +
                                                    screnone.EmailOtp[0] +
                                                    "\n" +
                                                    screnone.EmailOtp[1],
                                                maxLines: null,
                                                textAlign: TextAlign.center,
                                                style: AppStyle
                                                    .txtPromptRegular15)),
                                        Container(
                                          padding: getPadding(top: 10),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                height: 64,
                                                width: 68,
                                                child: TextFormField(
                                                  controller: Otp1,
                                                  autofocus: foc,
                                                  decoration: InputDecoration(
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0))),
                                                  onChanged: (value) {
                                                    if (value.length == 1) {
                                                      FocusScope.of(context)
                                                          .nextFocus();
                                                    }
                                                    if (value.length < 1) {
                                                      FocusScope.of(context)
                                                          .previousFocus();
                                                    }
                                                  },
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  textAlign: TextAlign.center,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                    LengthLimitingTextInputFormatter(
                                                        1)
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 64,
                                                width: 68,
                                                child: TextFormField(
                                                  controller: Otp2,
                                                  decoration: InputDecoration(
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0))),
                                                  onChanged: (value) {
                                                    if (value.length == 1) {
                                                      FocusScope.of(context)
                                                          .nextFocus();
                                                    }
                                                    if (value.length < 1) {
                                                      FocusScope.of(context)
                                                          .previousFocus();
                                                    }
                                                  },
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  textAlign: TextAlign.center,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                    LengthLimitingTextInputFormatter(
                                                        1)
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 64,
                                                width: 68,
                                                child: TextFormField(
                                                  controller: Otp3,
                                                  decoration: InputDecoration(
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0))),
                                                  onChanged: (value) {
                                                    if (value.length == 1) {
                                                      FocusScope.of(context)
                                                          .nextFocus();
                                                    }
                                                    if (value.length < 1) {
                                                      FocusScope.of(context)
                                                          .previousFocus();
                                                    }
                                                  },
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  textAlign: TextAlign.center,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                    LengthLimitingTextInputFormatter(
                                                        1)
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 64,
                                                width: 68,
                                                child: TextFormField(
                                                  controller: Otp4,
                                                  decoration: InputDecoration(
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0))),
                                                  onChanged: (value) async {
                                                    if (value.length == 1) {
                                                      FocusScope.of(context)
                                                          .nextFocus();
                                                    }
                                                    if (value.length < 1) {
                                                      FocusScope.of(context)
                                                          .previousFocus();
                                                    }
                                                    print(
                                                        "otp length ${otp.length}");

                                                    if (Otp1.text.isNotEmpty &&
                                                        Otp2.text.isNotEmpty &&
                                                        Otp3.text.isNotEmpty &&
                                                        Otp4.text.isNotEmpty) {
                                                      Navigator.pushNamed(
                                                          context,
                                                          AppRoutes.loding);
                                                      StaticControler.Otps =
                                                          Otp1.text +
                                                              Otp2.text +
                                                              Otp3.text +
                                                              Otp4.text;
                                                      // StaticControler.Status=await ApiCall.ConfOTP();
                                                      try {
                                                        // ApiCall.loadPDF();
                                                        StaticControler.Status =
                                                            await ApiCall
                                                                .ConfOTPForManuval();
                                                      } on SocketException catch (e) {
                                                        print(e);
                                                        if (e.toString() ==
                                                            "Software caused connection abort") {
                                                          OTPConectionDialog(
                                                              context);
                                                        }
                                                        if (e.toString() ==
                                                            "Connection failed") {
                                                          OTPConectionDialog(
                                                              context);
                                                        }
                                                        if (e.toString() ==
                                                            "Connection timed out") {
                                                          OTPConectionTimeOutDialog(
                                                              context);
                                                        }
                                                      }

                                                      if (StaticControler
                                                              .Status ==
                                                          1) {
                                                        disable(context);

                                                        onTapTxtGroupFour(
                                                            context);
                                                        // ApiCall.GetPdf();
                                                      } else {
                                                        foc = true;
                                                        Otp1.text = "";
                                                        Otp2.text = "";
                                                        Otp3.text = "";
                                                        Otp4.text = "";
                                                        ErrorDialog(context);
                                                      }
                                                      if (StaticControler
                                                              .result ==
                                                          "false") {
                                                        ErrorDialog(context);
                                                      }
                                                      // else
                                                      // {
                                                      //
                                                      //   ErrorDialogWhen(context);
                                                      // }
                                                    } else {
                                                      print("otp not full");
                                                    }
                                                  },
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  textAlign: TextAlign.center,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                    LengthLimitingTextInputFormatter(
                                                        1)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Visibility(
                                            visible: start == 0 ? true : false,
                                            child: TextButton(
                                                onPressed: () async {
                                                  start = 30;
                                                  startTimer();
                                                  final internetConection= await InternetConnectionChecker().hasConnection;
                                                  if(internetConection==true) {
                                                    ApiCall.otpTrig();
                                                  }
                                                  else
                                                    {
                                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Check your internet connection and try again")));
                                                    }
                                                },
                                                child: Text(
                                                  "Resend OTP",
                                                  style: TextStyle(
                                                      color:
                                                          HexColor("#ee3124")),
                                                ))),
                                        RichText(
                                            text: TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: "Wait for  ",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                            TextSpan(
                                              text: "00:$start",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: HexColor("#ee3124")),
                                            ),
                                            const TextSpan(
                                              text: " sec ",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        )),
                                        const Spacer(),
                                        // TextButton(
                                        //     onPressed: () async {
                                        //       Navigator.pushNamed(
                                        //           context, AppRoutes.loding);
                                        //       StaticControler.Otps = Otp1.text +
                                        //           Otp2.text +
                                        //           Otp3.text +
                                        //           Otp4.text;
                                        //       // StaticControler.Status=await ApiCall.ConfOTP();
                                        //       try {
                                        //         StaticControler.Status =
                                        //             await ApiCall.ConfOTP();
                                        //       } on SocketException catch (e) {
                                        //         print(e);
                                        //         if (e.toString() ==
                                        //             "Software caused connection abort") {
                                        //           OTPConectionDialog(context);
                                        //         }
                                        //         if (e.toString() ==
                                        //             "Connection failed") {
                                        //           OTPConectionDialog(context);
                                        //         }
                                        //         if (e.toString() ==
                                        //             "Connection timed out") {
                                        //           OTPConectionTimeOutDialog(
                                        //               context);
                                        //         }
                                        //       }
                                        //
                                        //       if (StaticControler.Status == 1) {
                                        //         disable(context);
                                        //         onTapTxtGroupFour(context);
                                        //       } else {
                                        //         foc = true;
                                        //         Otp1.text = "";
                                        //         Otp2.text = "";
                                        //         Otp3.text = "";
                                        //         Otp4.text = "";
                                        //
                                        //       }
                                        //       if(StaticControler.result=="false") {
                                        //         ErrorDialog(context);
                                        //       }
                                        //       else
                                        //       {
                                        //         ErrorDialogWhen(context);
                                        //       }
                                        //     },
                                        //     child: Container(
                                        //         width: getHorizontalSize(321),
                                        //         margin: getMargin(bottom: 33),
                                        //         padding: getPadding(
                                        //             left: 10,
                                        //             top: 15,
                                        //             right: 10,
                                        //             bottom: 15),
                                        //         decoration: AppDecoration
                                        //             .txtOutlineBlack900
                                        //             .copyWith(
                                        //                 borderRadius:
                                        //                     BorderRadiusStyle
                                        //                         .txtRoundedBorder16),
                                        //         child: Text("Confirm OTP",
                                        //             overflow:
                                        //                 TextOverflow.ellipsis,
                                        //             textAlign: TextAlign.center,
                                        //             style: AppStyle
                                        //                 .txtPromptRegular15WhiteA700))
                                        // )
                                      ])))
                        ])))));
  }

  onStay(context) {
    Navigator.pushNamed(context, AppRoutes.frameTwoScreen);
  }

  ErrorDialog(context) {
    onStay(context);
    showCupertinoDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            StaticControler.result == "false"
                ? "Enter Correct OTP"
                : StaticControler.result,
            style:
                const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          ),
          content: TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(HexColor("#ee3124")),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.white),
              )),
        );
      },
    );
  }

  ErrorDialogWhen(context) {
    onStay(context);
    showCupertinoDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            StaticControler.result == "false"
                ? "Enter Correct OTP"
                : StaticControler.result,
            style:
                const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          ),
          content: TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(HexColor("#ee3124")),
              ),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.frameOneScreen);
              },
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.white),
              )),
        );
      },
    );
  }

  OTPConectionDialog(context) {
    showCupertinoDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('No Connection'),
        content: const Text('Please check your internet connectivity'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              print("Connection failed");
              onStay(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  OTPConectionTimeOutDialog(context) {
    showCupertinoDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Connection timed out'),
        content: const Text('Please check your internet connectivity'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              print("TimeOut");
              onStay(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  bool bol = false;

  disable(BuildContext context) async {
    await FlutterSecureScreen.singleton.setAndroidScreenSecure(boole);
  }

  // onTapTxtGroupFour(BuildContext context) {
  //   Navigator.pushNamed(context, AppRoutes.frameThreeScreen);
  // }
  onTapTxtGroupFour(BuildContext context) async {
    StaticControler.localPath = await ApiCall.loadPDF();
    // totalpage = await pdfController.pagesCount;
    streamController.add(1);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFScreen(),
      ),
    );
  }
}
