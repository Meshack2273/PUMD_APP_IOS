import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

// import 'package:pdfx/pdfx.dart';

import 'package:pdf_render/pdf_render.dart';
// import 'package:pdf/pdf.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


import '../../ApiCall.dart';
import '../../routes/app_routes.dart';
import '../../staticVariable.dart';
import '../../widgets/loding_ScrenWithTime.dart';
import '../frame_one_screen/frame_one_screen.dart';


var values = [];
var encodedFab;
String? fabnumberforChecking;
int? totalpage;
int i = 1;
int j = 0;
int k = 1;
FlutterSecureStorage storage = FlutterSecureStorage();
StreamController<int> streamControllerfortolalPage =
StreamController<int>.broadcast();
StreamController<int> streamController = StreamController<int>.broadcast();
StreamController<int> streamControllerForTextFound =
StreamController<int>.broadcast();
StreamController<int> streamControllerForPageInc =
StreamController<int>.broadcast();
StreamController<int> streamControllerForPreviousPage =
StreamController<int>.broadcast();
TextEditingController SearchText = TextEditingController();
// PdfController pdfController = PdfController(
//   document: PdfDocument.openFile(StaticControler.localPath),
// );
Isolate? backgroundIsolate;
Map<dynamic, dynamic> PdfLang = {
  "En": "English",
  "Fr": "French",
  "Du": "Dutch"
};


class PDFScreen extends StatefulWidget {
  PDFScreen({super.key});


  @override
  _PDFScreenState createState() => _PDFScreenState();
}


class _PDFScreenState extends State<PDFScreen> {
  final GlobalKey<_PDFScreenState> pdfViewerKey = GlobalKey();
  // PDFView pdfView=PDFView(filePath: StaticControler.localPath);
  final ScrollController _scrollController = ScrollController();
PdfViewerController pdfcon=PdfViewerController();
PdfViewer pdfViewer=PdfViewer.openFile(StaticControler.localPath);
int increement =2;
  @override
  initState() {
    // values.add("TEST2");
    //
    //
    // Encode();
    // print("Fab With Fab $encodedFab");
// if(()async {
//   await storage.read(key: "Fab");
// }==null) {
//
// }
// else
//   {
//     storage.write(key: "Fab2", value: StaticControler.fabnumber);
//   }
//     storage.write(key: "FABTEST", value:"FABTEST");
    storage.write(
        key: StaticControler.fabnumber!, value: StaticControler.fabnumber!);
    // Anoymous();
    streamControllerOTPorPDF.add("Open PDF");
    // streamControllerfortolalPage.add(pdfController.pagesCount??0);
    super.initState();
  }


  Anoymous() async {
    print("this is list of fab ${await storage.read(key: "FAB")}");
  }


  Encode() async {
    encodedFab = values.join("|");
  }


  @override
  void dispose() {
    super.dispose();
  }


  String? localPath;
  int defaultpage = 0;


  TextButton clickbutton = TextButton(
      onPressed: () {
        final hi = "hi";
      },
      child: Text(""));


  // bool isLoading = true;
  // int totalPages = 0;
  // int currentPage = 0;
  // PDFViewController? pdfViewController;


  @override
  Widget build(BuildContext context) {
    return PopScope(
        onPopInvoked: (tru) async {
          SearchText.text = "";
          print("pop");
          Future.delayed(Duration.zero,(){
            Navigator.pushNamed(context, AppRoutes.frameOneScreen);
          });
        },
        child: Scaffold(
            backgroundColor: HexColor("#bbb8b8"),
            appBar: AppBar(
              title: Text(
                "PUMD MANUAL",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: Stack(children: [
              Padding(
                padding:
                EdgeInsets.only(top: 20, right: 30, left: 30, bottom: 5),
                child: Row(
                  children: [
                    Flexible(
                     child:

                    Container(
                      width: 500,
                      height: 50,
                      child: Material(
                        borderRadius: BorderRadius.circular(32.0),
                        elevation: 20.0,
                        shadowColor: Colors.grey,
                        child: DropdownButtonFormField2<dynamic>(
                          // value:int.parse(StaticControler.foundKeyForZone),
                          value: "En",
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                          ),
                          isExpanded: true,
                          items: PdfLang.entries
                              .map((MapEntry<dynamic, dynamic> entry) {
                            return DropdownMenuItem<String>(
                              value: entry.key,
                              child: Text(entry.value),
                            );
                          }).toList(),


                          onChanged: (newValue) async {

                            Navigator.pushNamed(context, AppRoutes.loding);
                            increement=increement+1;

                            StaticControler.Language = newValue;
                            print("language ${StaticControler.Language}");
                            if (newValue == "Du") {

                                StaticControler.localPath =
                                await ApiCall.TestPDF();



                              setState(() {

                                print("pdf changed");

                              });
                              // await pdfController.loadDocument(
                              //     PdfDocument.openFile(
                              //         StaticControler.localPath));
                              // streamControllerfortolalPage
                              //     .add(await pdfController.pagesCount!);
                              // streamControllerForPageInc
                              //     .add(await pdfController.page!);


                              // print(
                              //     "page count onChanged ${await pdfController.pagesCount}");
                            }
                            if (newValue == "En") {
                              StaticControler.localPath =
                              await ApiCall.loadElgiPDF();
                              // await pdfController.loadDocument(
                              //     PdfDocument.openFile(
                              //         StaticControler.localPath));
                              // streamControllerfortolalPage
                              //     .add(await pdfController.pagesCount!);
                              // streamControllerForPageInc
                              //     .add(await pdfController.page!);
                              // print(
                              //     "page count onChanged ${pdfController.pagesCount}");
                            }
                            if(newValue=="Fr")
                              {
                                StaticControler.localPath =
                                await ApiCall.loadFRPDF();
                                setState(() {
                                  print("pdf changed");
                                });
                              }
                            Navigator.pop(context);
                          }, //onchange
                        ),
                      ),
                    )
                    )],
                ),
              ),

              StreamBuilder<int>(
                  stream: streamController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData == false ||
                        snapshot.data == 0 ||
                        snapshot.data == 1) {
                      if (snapshot.data == 0) {
                        // Navigator.pop(context);
                        snapshot.data?.truncate();
                        const Center(
                            child: Text(
                              "No Text Found",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ));
                      }


                      print("Stream builder is working");
                      print("default page ${StaticControler.defaultpage}");


                      return Container(
                        margin: EdgeInsets.only(top: 100),
                        child: StaticControler.localPath != "null"
                            ? Stack(
                          children: [
                            //PDFView(filePath: pdfView.filePath,)
                              increement.isEven?PdfViewer(doc:PdfDocument.openFile(StaticControler.localPath),viewerController: pdfcon,):
                              PdfViewer(doc:PdfDocument.openFile(StaticControler.localPath),viewerController: pdfcon,)

                            // PdfView(
                            //     controller: pdfController,
                            // )
                                // scrollDirection: Axis.vertical,
                                // onPageChanged: (page) {
                                //   streamControllerForPageInc
                                //       .add(pdfController.page);
                                //   streamControllerfortolalPage
                                //       .add(pdfController.pagesCount!);
                                // },
                                // onDocumentLoaded: (pageload) {
                                //   streamControllerfortolalPage
                                //       .add(pdfController.pagesCount!);
                                // }
                    // )
                          ],
                        )
                        // snapshot.data==0?Text("No Text Found",style: TextStyle(fontWeight: FontWeight.bold),):Text("page")
                            : Center(child: CircularProgressIndicator()),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  })
            ])));
  }


  void disposee() {
    _scrollController.dispose(); // Dispose the ScrollController
    super.dispose();
  }
}

//
// jumpto() {
//   try {
//     pdfController.jumpToPage(
//         StaticControler.defaultpage == 0 ? 0 : StaticControler.defaultpage + 1);
//   } catch (e) {
//     print(e);
//   }
// }


// pageno() {
//   try {
//     streamControllerForPageInc.add(pdfController.page);
//   } catch (e) {
//     print(e);
//   }
// }




invalidOTP(context) {
  showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text("Invalid OTP"),
          // content: Text("Enter the valid OTP"),
        );
      });
}

