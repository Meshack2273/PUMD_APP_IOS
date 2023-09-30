import 'dart:async';
import 'dart:io';

import 'package:pumd_app/ApiCall.dart';
import 'package:pumd_app/core/app_export.dart';
import 'package:pumd_app/staticVariable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pumd_app/presentation/frame_six_dialog/frame_six_dialog.dart';
import 'package:flutter/services.dart';
import 'package:pumd_app/presentation/frame_one_screen/frame_one_screen.dart'
    as screnone;
import 'package:pumd_app/presentation/frame_four_screen/frame_four_screen.dart'
    as screnfour;
import 'package:hexcolor/hexcolor.dart';

TextEditingController Otp1 = TextEditingController();
TextEditingController Otp2 = TextEditingController();
TextEditingController Otp3 = TextEditingController();
TextEditingController Otp4 = TextEditingController();

onStay(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.frameFourScreen);
}

class FrameFiveScreen extends StatefulWidget {
  const FrameFiveScreen({Key? key}) : super(key: key);

  @override
  State<FrameFiveScreen> createState() => _FrameFiveScreen();
}

class _FrameFiveScreen extends State<FrameFiveScreen> {
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
  }

  @override
  Widget build(context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushNamed(context, AppRoutes.frameFourScreen);
          return true; // return true to allow the pop
        },
        child: SafeArea(
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Container(
                    width: double.maxFinite,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Container(
                                  padding: getPadding(
                                      left: 17, top: 20, right: 17, bottom: 20),
                                  decoration: AppDecoration.fillBluegray100,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                "Email OTP has been Sent To :\n${screnfour.PrimaryMail.text}\n${screnfour.SecondaryMail.text}",
                                                maxLines: null,
                                                textAlign: TextAlign.center,
                                                style: AppStyle
                                                    .txtPromptRegular15)),
                                        const SizedBox(
                                          height: 50,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              height: 64,
                                              width: 68,
                                              child: TextFormField(
                                                autofocus: true,
                                                controller: Otp1,
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
                                                  LengthLimitingTextInputFormatter(
                                                      1),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
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
                                                  LengthLimitingTextInputFormatter(
                                                      1),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
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
                                                  LengthLimitingTextInputFormatter(
                                                      1),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
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

                                                  if (Otp1.text.isNotEmpty &&
                                                      Otp2.text.isNotEmpty &&
                                                      Otp3.text.isNotEmpty &&
                                                      Otp4.text.isNotEmpty) {
                                                    Navigator.pushNamed(context,
                                                        AppRoutes.loding);
                                                    StaticControler.OtpNS =
                                                        Otp1.text +
                                                            Otp2.text +
                                                            Otp3.text +
                                                            Otp4.text;
                                                    try {
                                                      StaticControler.StatusNA =
                                                          await ApiCall
                                                              .ConfOTPForNA();
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
                                                    print(StaticControler
                                                        .StatusNA);

                                                    if (StaticControler
                                                            .StatusNA ==
                                                        1) {
                                                      onTapTxtGroupThirtySix(
                                                          context);
                                                    } else {
                                                      Navigator.pop(context);
                                                      showDialog(
                                                        barrierDismissible:
                                                            false,
                                                        context: context,
                                                        builder: (_) {
                                                          return AlertDialog(
                                                            title: Text(
                                                              'Enter Correct OTP',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                            content:
                                                                TextButton.icon(
                                                                    onPressed:
                                                                        () {
                                                                      Otp1.text =
                                                                          "";
                                                                      Otp2.text =
                                                                          "";
                                                                      Otp3.text =
                                                                          "";
                                                                      Otp4.text =
                                                                          "";
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .arrow_back),
                                                                    label: Text(
                                                                        "")),
                                                          );
                                                        },
                                                      );
                                                    }
                                                  }
                                                },
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6,
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.center,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      1),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Visibility(
                                            visible: start == 0 ? true : false,
                                            child: TextButton(
                                                onPressed: () {
                                                  start = 30;
                                                  startTimer();
                                                  ApiCall.SaveNewAss();
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
                                              text: "Wait for ",
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
                                        // GestureDetector(
                                        //
                                        //     onTap: ()async {
                                        //       Navigator.pushNamed(context, AppRoutes.loding);
                                        //       StaticControler.OtpNS=Otp1.text+Otp2.text+Otp3.text+Otp4.text;
                                        //
                                        //       try {
                                        //         StaticControler.StatusNA=await ApiCall.ConfOTPForNA();
                                        //       }on SocketException catch (e) {
                                        //         print(e);
                                        //         if(e.toString()=="Software caused connection abort")
                                        //         {
                                        //           OTPConectionDialog(context);
                                        //         }
                                        //         if(e.toString()=="Connection failed")
                                        //         {
                                        //           OTPConectionDialog(context);
                                        //         }
                                        //         if(e.toString()=="Connection timed out")
                                        //         {
                                        //           OTPConectionTimeOutDialog(context);
                                        //         }
                                        //       }
                                        //       print(StaticControler.StatusNA);
                                        //
                                        //       if(StaticControler.StatusNA==1){
                                        //         onTapTxtGroupThirtySix(context);
                                        //       }
                                        //       else{
                                        //         showDialog(
                                        //           barrierDismissible: false,
                                        //           context: context,
                                        //           builder: (_) {
                                        //             return  AlertDialog(
                                        //
                                        //               title: Text('INVALID OTP',style: TextStyle(color: Colors.red),),
                                        //
                                        //               content: TextButton.icon(onPressed:() {
                                        //                 Otp1.text="";
                                        //                 Otp2.text="";
                                        //                 Otp3.text="";
                                        //                 Otp4.text="";
                                        //                 Navigator.pushNamed(context,AppRoutes.frameFiveScreen);
                                        //               }, icon:const Icon(Icons.arrow_back), label: Text("")),
                                        //             );
                                        //           },
                                        //         );
                                        //       }
                                        //
                                        //     },
                                        //     child: Container(
                                        //         width: getHorizontalSize(321),
                                        //         margin: getMargin(
                                        //             left: 1, top: 150, bottom: 33,right: 1),
                                        //         padding: getPadding(
                                        //             left: 105,
                                        //             top: 15,
                                        //             right: 105,
                                        //             bottom: 15),
                                        //         decoration: AppDecoration
                                        //             .txtOutlineBlack900
                                        //             .copyWith(
                                        //                 borderRadius:
                                        //                     BorderRadiusStyle
                                        //                         .txtRoundedBorder16),
                                        //         child: Text("Confirm OTP",
                                        //             overflow: TextOverflow.ellipsis,
                                        //             textAlign: TextAlign.left,
                                        //             style: AppStyle
                                        //                 .txtPromptRegular15WhiteA700)))
                                      ])))
                        ])))));
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

  onTapTxtGroupThirtySix(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => const AlertDialog(
              content: FrameSixDialog(),
              backgroundColor: Colors.transparent,
            ));
  }
}
