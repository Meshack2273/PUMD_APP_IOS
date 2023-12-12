import 'dart:async';
import 'dart:convert';
import 'package:hexcolor/hexcolor.dart';
import 'package:pdfx/pdfx.dart';

// import 'package:pdf/pdf.dart';
// import 'package:pdfx/pdfx.dart';
import 'package:pumd_app_ios/core/utils/Model.dart';

// import 'package:pdfx/pdfx.dart';
import 'dart:io';
import 'package:pumd_app_ios/presentation/frame_four_screen/frame_four_screen.dart';
import 'package:pumd_app_ios/staticVariable.dart';
import 'package:pumd_app_ios/presentation/frame_two_screen/frame_two_screen.dart';
import 'package:pumd_app_ios/core/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:pumd_app_ios/presentation/frame_four_screen/frame_four_screen.dart'
    as ScreenFour;
import 'package:pumd_app_ios/widgets/loding_Scren.dart' as load;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../ApiCall.dart';
import 'package:pumd_app_ios/presentation/frame_two_screen/frame_two_screen.dart'
    as ScreenTwo;
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import '../frame_three_screen/pdfScreen.dart';

// import '../frame_three_screen/pdfScreenSpecificTime.dart'as pdfTime;
// import '../frame_three_screen/pdfScreenSpecificTime.dart';

StreamController<String> streamControllerOTPorPDF =
    StreamController<String>.broadcast();

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

CheckConectiomn() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return ('connected');
    }
  } on SocketException catch (_) {
    return ('not connected');
  }
}

int onetime = 0;
late String fabnumber;
bool lod = true;
bool loding_Screen = true;
late dynamic EmailOtp;
late String? token;
TextEditingController fabNum =
    TextEditingController(text: StaticControler.fabnumber?.toUpperCase());

class FrameOneScreen extends StatefulWidget {
  const FrameOneScreen({super.key});

  @override
  State<FrameOneScreen> createState() => _State();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class _State extends State<FrameOneScreen> {
  late StreamSubscription subscription;

  bool isDeviceConnected = false;
  bool isAlertSet = false;

  void initState() {
    print(storage.read(key: "Fab"));
    getConnectivity();
    super.initState();
  }

  getConnectivity() async {
    if (fabNum.text == await storage.read(key: fabNum.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: HexColor("#ee3124"),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            elevation: 20,
            content: const Text(
              "Now you can open manual without OTP",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
      );
      streamControllerOTPorPDF.add("Open PDF");
    } else {
      streamControllerOTPorPDF.add("Send OTP");
    }
    // if(OTPorPDF == "PDF")
    // {
    //   streamControllerOTPorPDF.add("Open PDF");
    // }
    // else
    // {
    //   streaolled("Send O    // }
    // subscription = Connectivity().onConnectivityChanged.listen(
    //   (ConnectivityResult result) async {
    //     isDeviceConnected = await InternetConnectionChecker().hasConnection;
    //     print("${isDeviceConnected}  Checking");
    //     if (!isDeviceConnected && isAlertSet == false) {
    //       ConectionDialog();
    //       setState(() => isAlertSet = true);
    //     }
    //   },
    // );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Future Scan() async {
    FlutterBarcodeScanner.scanBarcode("#000000", "Cancel", true, ScanMode.QR)
        .then((value) async {
      List valuesbeforeSplit = value.split("/");
      String values = valuesbeforeSplit[0].replaceAll(" ", "").toUpperCase();
      print("values of scan ${values}");
      if (values == '-1') {
        // Handle the cancellation of the scanning process
        values = "";
      } else if (values == null) {
        return fabnull();
      } else {
        // Handle the barcode result
        // setState(() async {
        StaticControler.Allpages = [];
        fabNum.text.toUpperCase();
        fabNum.text = await values;
        Navigator.pushNamed(context, AppRoutes.loding);
        final internetConection =
        await InternetConnectionChecker()
            .hasConnection;
        if (internetConection==true) {
          // LOD();
          // showLoaderDialog(context);
          // isloding=true;
          ScreenFour.currentSelectedValue = "";
          ScreenTwo.Otp1.text = "";
          ScreenTwo.Otp2.text = "";
          ScreenTwo.Otp3.text = "";
          ScreenTwo.Otp4.text = "";
          ScreenFour.CustomerFirstName.text = "";
          ScreenFour.CustomerLastName.text = "";
          ScreenFour.PrimaryMail.text = "";
          ScreenFour.SecondaryMail.text = "";
          ScreenFour.Mobilenocon.text = "";
          ScreenFour.StreetCon.text = "";
          ScreenFour.CountryCon.text = "";
          ScreenFour.CityCon.text = "";
          ScreenFour.StateCon.text = "";
          ScreenFour.PinCon.text = "";
          ScreenFour.fabnum.text = fabNum.text;
          // ScreenFour.formKey.currentState;
          // screenFour.formKey.currentState?.deactivate();
          StaticControler.fabnumber = fabNum.text;
          // ApiCall.otpTrig();
          // const load.loding();
          print("fab going to trigger otp ${StaticControler.fabnumber}");
          // finalres=ApiCall.otpTrig();
          if (values == await storage.read(key: fabNum.text)) {
            print(
                "fabnumber from pdf screen ${storage.read(key: fabNum.text)}");
            Navigator.pushNamed(context, AppRoutes.loding);
            try {
              // pdfController.dispose();
            } catch (e)
            {
              print(e);
            }
            try {
              final token = await ApiCall.GetToc();

              if (token == "Connection Failed" ||
                  token == "Service Unavailable" ||
                  token == "Connection Timeout" ||
                  token == "Not Found" ||
                  token == "Proxy Error") {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "$token",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: HexColor("#ee3124"),
                  elevation: 10,
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(5),
                ));
              } else {
                StaticControler.localPath = await ApiCall.loadElgiPDF();
                // totalpage = await pdfController.pagesCount;

                // pdfController = PdfController(
                //   document: PdfDocument.openFile(StaticControler.localPath),
                // );
                print("show pdf");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PDFScreen(),
                  ),
                );
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "$e",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                backgroundColor: HexColor("#ee3124"),
                elevation: 10,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(5),
              ));
            }
          } else {
            try {
              print("fabnumber from pdf screen ${storage.read(key: value)}");
              EmailOtp = await ApiCall.otpTrig();
              if (EmailOtp == "Connection Exception") {
                ConectionDialogForLogin();
              } else if (EmailOtp == "Connection Failed") {
                ConectionDialogForLogin();
              } else if (EmailOtp == "Connection Timeout") {
                ConnectionTimeoutDialog();
              } else if (EmailOtp == "Service Unavailable") {
                ServiceUnAvilableDialog();
              } else if (EmailOtp == "Not Found") {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text(
                    "404 Not Found Try Again Later",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: HexColor("#ee3124"),
                  elevation: 10,
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(5),
                ));
              } else if (EmailOtp == "Proxy Error") {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text(
                    "Proxy Error Please Try Again Later",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: HexColor("#ee3124"),
                  elevation: 10,
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(5),
                ));
              }
            } on SocketException catch (e) {
              if (e.toString() == "Software caused connection abort") {
                OTPConectionDialog();
              }
              if (e.toString() == "Connection failed") {
                OTPConectionDialog();
              }
              if (e.toString() == "Service Unavailable") {
                OTPConectionDialog();
              }
              if (e.toString() == "Connection timed out") {
                OTPConectionTimeOutDialog();
              }
            }
            print("${EmailOtp[3]}  if state");
            if (EmailOtp[3] == 1) {
              lod = false;
              onTapSendotp(context);
            } else if (EmailOtp[3] == 2) {
              onStay(context);
              return Pending();
            } else if (fabNum.text == "") {
              onStay(context);
              return fabnull();
            } else {
              onStay(context);
              if (EmailOtp.runtimeType != String) {
                Alert();
              }
            }

            // );
          }
        }
        else{
          ConectionDialogForLogin();
        }
      }
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
        onPopInvoked: (tru) async {
          StaticControler.fabnumber == "";

        },
        child: SafeArea(
            child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Form(
              key: _formKey,
              child: Container(
                  width: double.maxFinite,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Container(
                                width: double.maxFinite,
                                padding: getPadding(
                                    left: 19, top: 43, right: 19, bottom: 23),
                                decoration: AppDecoration.fillBluegray100,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomImageView(
                                          imagePath: ImageConstant.imgImage1,
                                          height: 50,
                                          width: 110),
                                      const SizedBox(
                                        height: 100,
                                      ),
                                      TextButton.icon(
                                          icon: const Icon(
                                            Icons.qr_code,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      // Color.fromRGBO(238, 49, 36,5)
                                                      HexColor("#ee3124")),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsetsGeometry?>(
                                                      const EdgeInsets.only(
                                                          top: 15,
                                                          right: 35,
                                                          left: 25,
                                                          bottom: 15))),
                                          label: const Text(
                                            "Scan",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: () {
                                            StaticControler.fabnumber = "";
                                            fabNum.clear;
                                            Scan();
                                          }),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      const Text(
                                        "(OR)",
                                        style: TextStyle(fontSize: 20),
                                        // overflow: TextOverflow.ellipsis,
                                        // textAlign: TextAlign.left,
                                        // style: AppStyle.txtInterRegular52
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      SingleChildScrollView(
                                          child: Column(children: [
                                        TextFormField(
                                            textCapitalization:
                                                TextCapitalization.characters,
                                            inputFormatters: [
                                              UpperCaseTextFormatter(),
                                              NoLeadingSpaceFormatter(),
                                            ],
                                            onChanged: (value) async {
                                              if (value ==
                                                  await storage.read(
                                                      key: value)) {
                                                streamControllerOTPorPDF
                                                    .add("Open PDF");
                                              } else {
                                                streamControllerOTPorPDF
                                                    .add("Send OTP");
                                              }
                                            },
                                            controller: fabNum,
                                            decoration: const InputDecoration(
                                              hintText: "Enter FAB Number",
                                            )),
                                      ])),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      SingleChildScrollView(
                                          child: Column(children: [
                                        TextButton.icon(
                                            icon: const Icon(
                                              Icons.send,
                                              color: Colors.white,
                                              size: 25,
                                            ),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        HexColor("#ee3124")),
                                                padding: MaterialStateProperty
                                                    .all<EdgeInsetsGeometry?>(
                                                        const EdgeInsets.only(
                                                            top: 15,
                                                            right: 35,
                                                            left: 35,
                                                            bottom: 15))),
                                            label: StreamBuilder<String>(
                                                stream: streamControllerOTPorPDF
                                                    .stream,
                                                builder: (context, snapshot) {
                                                  return Text(
                                                    "${snapshot.data}",
                                                    // fabNum.text == OTPorPDF
                                                    //     ? "Open PDF"
                                                    //     : "Send OTP",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  );
                                                }),
                                            onPressed: () async {
                                              // String call= await ApiCall.GetToc();

                                              fabNum.text.toUpperCase();
                                              Navigator.pushNamed(
                                                  context, AppRoutes.loding);
                                              final internetConection =
                                                  await InternetConnectionChecker()
                                                      .hasConnection;
                                              if (internetConection == false) {
                                                print(
                                                    "Connection failed print");
                                                ConectionDialogForLogin();
                                              }
                                              // LOD();
                                              // showLoaderDialog(context);
                                              // isloding=true;
                                              // ScreenFour.keeys.dropkey.currentState?.reset();
                                              else {
                                                StaticControler.Allpages = [];
                                                ScreenFour.SelectTed = null;
                                                ScreenFour
                                                        .currentSelectedValue =
                                                    null;
                                                ScreenFour
                                                        .currentSelectedValueID =
                                                    null;
                                                ScreenTwo.Otp1.text = "";
                                                ScreenTwo.Otp2.text = "";
                                                ScreenTwo.Otp3.text = "";
                                                ScreenTwo.Otp4.text = "";
                                                ScreenFour.CustomerFirstName
                                                    .text = "";
                                                ScreenFour
                                                    .CustomerLastName.text = "";
                                                ScreenFour.PrimaryMail.text =
                                                    "";
                                                ScreenFour.SecondaryMail.text =
                                                    "";
                                                ScreenFour.Mobilenocon.text =
                                                    "";
                                                ScreenFour.StreetCon.text = "";
                                                ScreenFour.CountryCon.text = "";
                                                ScreenFour.CityCon.text = "";
                                                ScreenFour.StateCon.text = "";
                                                ScreenFour.PinCon.text = "";
                                                ScreenFour.fabnum.text =
                                                    fabNum.text;
                                                // ScreenFour.formKey.currentState;
                                                // screenFour.formKey.currentState?.deactivate();
                                                StaticControler.fabnumber =
                                                    fabNum.text;
                                                // ApiCall.otpTrig();
                                                // const load.loding();
                                                print(
                                                    StaticControler.fabnumber);
                                                // final res=ApiCall.otpTrig();
                                                if (fabNum.text ==
                                                    await storage.read(
                                                        key: fabNum.text)) {
                                                  print(
                                                      "fabnumber from pdf screen ${storage.read(key: fabNum.text)}");
                                                  Navigator.pushNamed(context,
                                                      AppRoutes.loding);
                                                  try {
                                                    // pdfController.dispose();
                                                  } catch (e) {
                                                    print(e);
                                                  }
                                                  try {
                                                    final token =
                                                        await ApiCall.GetToc();

                                                    if (token == "Connection Failed" ||
                                                        token ==
                                                            "Service Unavailable" ||
                                                        token ==
                                                            "Connection Timeout" ||
                                                        token == "Not Found" ||
                                                        token ==
                                                            "Proxy Error") {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        content: Text(
                                                          "$token",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        backgroundColor:
                                                            HexColor("#ee3124"),
                                                        elevation: 10,
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        margin:
                                                            EdgeInsets.all(5),
                                                      ));
                                                    } else {
                                                      StaticControler
                                                              .localPath =
                                                          await ApiCall
                                                              .loadElgiPDF();
                                                      // totalpage = await pdfController.pagesCount;
                                                      //
                                                      // pdfController = PdfController(
                                                      //   document: PdfDocument.openFile(StaticControler.localPath),
                                                      // );
                                                      print("show pdf");
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              PDFScreen(),
                                                        ),
                                                      );
                                                    }
                                                  } catch (e) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                        "$e",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      backgroundColor:
                                                          HexColor("#ee3124"),
                                                      elevation: 10,
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      margin: EdgeInsets.all(5),
                                                    ));
                                                  }
                                                } else {
                                                  print(
                                                      "fabnumber from pdf screen ${await storage.read(key: fabNum.text)}");
                                                  try {
                                                    EmailOtp =
                                                        await ApiCall.otpTrig();
                                                    if (EmailOtp ==
                                                        "Connection Exception") {
                                                      ConectionDialogForLogin();
                                                    } else if (EmailOtp ==
                                                        "Connection Failed") {
                                                      ConectionDialogForLogin();
                                                    } else if (EmailOtp ==
                                                        "Connection Timeout") {
                                                      ConnectionTimeoutDialog();
                                                    } else if (EmailOtp ==
                                                        "Service Unavailable") {
                                                      ServiceUnAvilableDialog();
                                                    } else if (EmailOtp ==
                                                        "Not Found") {
                                                      Navigator.pop(context);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        content: const Text(
                                                          "404 Not Found Try Again Later",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        backgroundColor:
                                                            HexColor("#ee3124"),
                                                        elevation: 10,
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        margin:
                                                            EdgeInsets.all(5),
                                                      ));
                                                    } else if (EmailOtp ==
                                                        "Proxy Error") {
                                                      Navigator.pop(context);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        content: const Text(
                                                          "Proxy Error Please Try Again Later",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        backgroundColor:
                                                            HexColor("#ee3124"),
                                                        elevation: 10,
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        margin:
                                                            EdgeInsets.all(5),
                                                      ));
                                                    }
                                                  } on SocketException catch (e) {
                                                    print("OtpTrig $e");
                                                    if (e.toString() ==
                                                        "Software caused connection abort") {
                                                      OTPConectionDialog();
                                                    }
                                                    if (e.toString() ==
                                                        "Failed host lookup: 'prodapi.elgi.com'") {
                                                      OTPConectionDialog();
                                                    }
                                                    if (e.toString() ==
                                                        "Connection failed") {
                                                      OTPConectionDialog();
                                                    }
                                                    if (e.toString() ==
                                                        "Connection timed out") {
                                                      OTPConectionTimeOutDialog();
                                                    }
                                                  }

                                                  // EmailOtp = await ApiCall.otpTrig();
                                                  print(
                                                      "${EmailOtp[3]}  if state");
                                                  if (EmailOtp[3] == 1) {
                                                    lod = false;
                                                    //ApiCall.GetToc();c
                                                    // token=ApiCall.GetToc().toString();
                                                    // ApiCall.GetToc();
                                                    //   EmailOtp=await ApiCall.otpTrig();

                                                    onTapSendotp(context);
                                                  } else if (EmailOtp[3] == 2) {
                                                    onStay(context);
                                                    return Pending();
                                                  } else if (fabNum.text ==
                                                      "") {
                                                    onStay(context);
                                                    return fabnull();
                                                  } else {
                                                    onStay(context);
                                                    if (EmailOtp.runtimeType !=
                                                        String) {
                                                      Alert();
                                                    }
                                                  }
                                                }
                                              }
                                            }),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        //    TextButton(onPressed:() async {
                                        //
                                        //        // StaticControler.file=await ApiCall.loadPDF();
                                        //
                                        //        StaticControler.file=await ApiCall.loadPDFFile();
                                        // print("File data ${StaticControler.file.path}");
                                        //      Navigator.push(context, MaterialPageRoute(builder:(context){
                                        //        return CustomSearchPdfViewer();
                                        //      }));
                                        //    }, child:const Text("pdf check"))
                                      ]))
                                    ])))
                      ]))),
        )));
  }

  LodingScreen(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loding);
  }

  onTapSendotp(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frameTwoScreen);
  }

  onTapNewAsset(BuildContext context) {
    //Navigator.pushNamed(context, AppRoutes.frameThreeScreen);
    Navigator.pushNamed(context, AppRoutes.frameFourScreen);
  }

  onStay(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frameOneScreen);
  }

  // showLoaderDialog(BuildContext context){
  //   AlertDialog alert=AlertDialog(
  //     content: Row(
  //       children: [
  //         const CircularProgressIndicator(),
  //         Container(margin: const EdgeInsets.only(left: 7),child:const Text("Loading..." )),
  //       ],),
  //   );
  //   showDialog(barrierDismissible: false,
  //     context:context,
  //     builder:(BuildContext context){
  //       return alert;
  //     },
  //   );
  // }
  // GetToK() async {
  //   print("get token stated");
  //   var headers = {'Content-Type': 'application/json'};
  //   var request = http.Request(
  //       'POST', Uri.parse('${StaticControler.URL}/ExcelData/authenticate'));
  //   request.body =
  //       json.encode({"Username": "powerapp", "Password": "PowerApp^6787453"});
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     final jsonRes=jsonDecode(await response.stream.bytesToString());
  //     print("completed");
  //     print(jsonRes['token'].toString());
  //     return jsonRes['token'];
  //     // Map<String,dynamic> json={await response.stream.bytesToString()} as Map<String, dynamic>;
  //     // Map<dynamic, dynamic> result = json;
  //     // Map<String, dynamic> data = Map<String, dynamic>();
  //     // for (dynamic type in result.keys) {
  //     //   data[type.toString()] = result[type];
  //     // }
  //   } else {
  //     print (response.reasonPhrase.toString());
  //   }
  // }
  // Boollod() {
  //
  //   if (lod = true) {
  //     LOD();
  //   }
  // }
  // BoolNoTLod()
  // {
  //   if (lod = true) {
  //     LOD();
  //   }
  // }

  ConectionDialog() => showCupertinoDialog<String>(
        context: context,
        barrierDismissible: false,
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

  OTPConectionDialog() => showCupertinoDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                print("hoom");
                onStay(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );

  OTPConectionTimeOutDialog() => showCupertinoDialog<String>(
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

  // LOD() {
  //   const Visibility(
  //      visible: false,
  //      child:
  //         AlertDialog(
  //         shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(10.0))),
  //         title: Text("Loading..."),
  //       )
  //   );
  // }
  Alert() {
    showCupertinoDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          if (EmailOtp == "Not Found") {
            Navigator.pop(context);
          }
          return CupertinoAlertDialog(
            title: Text(
              "New Asset",
              style: TextStyle(
                  color: HexColor("#ee3124"), fontWeight: FontWeight.bold),
            ),
            content: const Text(
              'The given FAB number is not registered. Do you want to register ? ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "No",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text("Yes", style: TextStyle(color: Colors.black)),
                onPressed: () async {
                  // ApiCall.GetCountry();

                  Navigator.pushNamed(context, AppRoutes.loding);
                  // ScreenFour.currentSelectedValue="";
                  // // ApiCall.otpTrig();
                  // ScreenFour.SelectTed="";

                  List Country = await ApiCall.GetCountry();
                  print(Country);

                  onTapNewAsset(context);
                },
              )
            ],
          );
        });
  }

  service() {
    showCupertinoDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            content: Text(
              "Service Unavailable",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    onStay(context);
                  },
                  child:
                      Text('OK', style: TextStyle(fontWeight: FontWeight.bold)))
            ],
          );
        });
  }

  fabnull() {
    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            content: Text(
              "FAB number cannot be null",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    onStay(context);
                  },
                  child:
                      Text('OK', style: TextStyle(fontWeight: FontWeight.bold)))
            ],
          );
        });
  }

  ServiceUnAvilableDialogNOTFOUND() => showCupertinoDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Service Not Found'),
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

  ConectionDialogForLogin() {
    showCupertinoDialog<String>(
      barrierDismissible: false,
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
  }

  Pending() {
    showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return const CupertinoAlertDialog(
            title: Text("FAB number pending for approval"),
          );
        });
  }
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue fabNum,
  ) {
    if (fabNum.text.startsWith(' ')) {
      final String trimedText = fabNum.text.trimLeft();

      return TextEditingValue(
        text: trimedText,
        selection: TextSelection(
          baseOffset: trimedText.length,
          extentOffset: trimedText.length,
        ),
      );
    }
    return fabNum;
  }
}
