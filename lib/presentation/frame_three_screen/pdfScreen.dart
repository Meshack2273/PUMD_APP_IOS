import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pdfx/pdfx.dart';

// import 'package:pdf/pdf.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:pumd_app_ios/ApiCall.dart';
import 'package:pumd_app_ios/core/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pumd_app_ios/presentation/frame_one_screen/frame_one_screen.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../staticVariable.dart';
import '../../widgets/loding_ScrenWithTime.dart';

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
PdfController pdfController = PdfController(
  document: PdfDocument.openFile(StaticControler.localPath),
);
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
  final ScrollController _scrollController = ScrollController();

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
    return WillPopScope(
        onWillPop: () async {
          SearchText.text = "";
          print("pop");
          Navigator.pushNamed(context, AppRoutes.frameOneScreen);
          return true;
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
                    EdgeInsets.only(top: 20, right: 20, left: 30, bottom: 5),
                child: Row(
                  children: [
                    Flexible(
                      child: Container(
                        width: 160,
                        child: Material(
                          borderRadius: BorderRadius.circular(32.0),
                          elevation: 20.0,
                          shadowColor: Colors.grey,
                          child: TextFormField(
                            inputFormatters: [NoLeadingSpaceFormatter()],
                            controller: SearchText,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              contentPadding:
                                  EdgeInsets.fromLTRB(16.0, 12.0, 48.0, 12.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                              suffixIcon: GestureDetector(
                                child: Icon(Icons.search),
                                onTap: () async {
                                  if (SearchText.text == "") {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: const Text(
                                        "Enter any text to search 😕",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      backgroundColor: HexColor("#ee3124"),
                                      elevation: 10,
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.all(5),
                                    ));
                                    return null;
                                  }
                                  i = 1;
                                  j = 0;
                                  print(
                                      "increment ${StaticControler.integerforpdf}");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              lodingScreenWithTime()));

                                  print("clicked");
                                  clickbutton.onPressed?.call();
                                  try {
                                    StaticControler.defaultpage =
                                        await searchText();
                                    streamControllerForPageInc
                                        .add(StaticControler.defaultpage + 1);
                                    streamControllerForTextFound.add(200);
                                    streamController.add(1);
                                    Navigator.pop(context);
                                    jumpto();
                                  } catch (e) {
                                    print(e);
                                    StaticControler.defaultpage = 500;
                                    streamControllerForPageInc
                                        .add(pdfController.page);
                                    streamControllerForTextFound.add(500);
                                    streamController.add(0);
                                    Navigator.pop(context);
                                  }

                                  // streamController.add(await StaticControler.defaultpage);
                                  // streamController.add(await  StaticControler.defaultpage);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 150,
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
                            StaticControler.Language = newValue;
                            print("language ${StaticControler.Language}");
                            if (newValue == "Du") {
                              StaticControler.localPath =
                                  await ApiCall.loadPDFLng();
                              await pdfController.loadDocument(
                                  PdfDocument.openFile(
                                      StaticControler.localPath));
                              streamControllerfortolalPage
                                  .add(await pdfController.pagesCount!);
                              streamControllerForPageInc
                                  .add(await pdfController.page!);

                              print(
                                  "page count onChanged ${await pdfController.pagesCount}");
                            }
                            if (newValue == "En" || newValue == "Fr") {
                              StaticControler.localPath =
                                  await ApiCall.loadPDF();
                              await pdfController.loadDocument(
                                  PdfDocument.openFile(
                                      StaticControler.localPath));
                              streamControllerfortolalPage
                                  .add(await pdfController.pagesCount!);
                              streamControllerForPageInc
                                  .add(await pdfController.page!);
                              print(
                                  "page count onChanged ${pdfController.pagesCount}");
                            }
                            Navigator.pop(context);
                          }, //onchange
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // Container(margin:EdgeInsets.only(top: 80,right: 20,left: 20),child:
              //  DropdownButtonFormField2<dynamic>(
              //    // value:int.parse(StaticControler.foundKeyForZone),
              //    // value:"En",
              //    decoration: InputDecoration(
              //      contentPadding: EdgeInsets.all(15),
              //      border: OutlineInputBorder(
              //          borderRadius:
              //          BorderRadius
              //              .circular(
              //              10.0)
              //      ),
              //
              //    ),
              //    isExpanded: true,
              //    items: PdfLang.entries
              //        .map((MapEntry<dynamic, dynamic> entry) {
              //      return DropdownMenuItem<String>(
              //        value: entry.value,
              //        child: Text(entry.key),
              //      );
              //    })
              //        .toList(),
              //
              //    onChanged: ( newValue) async {
              //    },//onchange
              //
              //  )
              // ),
              Container(
                margin: EdgeInsets.only(
                  top: 90,
                  left: 60,
                ),
                child: StreamBuilder<int>(
                    stream: streamControllerForTextFound.stream,
                    builder: (context, snapshotForTextFound) {
                      return StreamBuilder<int>(
                          stream: streamControllerForPageInc.stream,
                          builder: (context, snapshotForPageInc) {
                            return snapshotForTextFound.data == 500
                                ? const Padding(
                                    padding:
                                        EdgeInsets.only(top: 20, left: 100),
                                    child: Text(
                                      "No Text Found",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ))
                                : Row(children: [
                                    const Text(
                                      "page   ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${snapshotForPageInc.data ?? 1} / ",
                                    ),
                                    StreamBuilder<int>(
                                        stream:
                                            streamControllerfortolalPage.stream,
                                        builder: (context, snapshotTotalpage) {
                                          return Text(
                                            "${snapshotTotalpage.data ?? "..."}",
                                          );
                                        }),
                                    SizedBox(width: 145),
                                    Flexible(
                                        child: Padding(
                                      padding: EdgeInsets.only(),
                                      child: SizedBox(
                                          width: 51,
                                          child: // <-- match_parent
                                              TextButton.icon(
                                            onPressed: () async {
                                              // int  increement=0;
                                              // int inc=increement+1;
                                              try {
                                                final nextpage =
                                                    await StaticControler
                                                        .Allpages[i++];
                                                print("i value is $i");
                                                print(
                                                    "value passing to snap is ${i - 1}");
                                                print(
                                                    "page going  to jump is ${nextpage + 1}");
                                                streamControllerForPreviousPage
                                                    .add(i - 1);
                                                pdfController
                                                    .jumpToPage(nextpage + 1);
                                              } catch (e) {
                                                print(e);
                                                i = 1;
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.arrow_circle_down_outlined,
                                              textDirection: TextDirection.ltr,
                                              size: 27,
                                              weight: 10,
                                            ),
                                            label: Text(""),
                                          )),
                                    ))
                                  ]);
                          });
                    }),
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
                        margin: EdgeInsets.only(top: 150),
                        child: StaticControler.localPath != "null"
                            ? Stack(
                                children: [
                                  PdfView(
                                      controller: pdfController,
                                      scrollDirection: Axis.vertical,
                                      onPageChanged: (page) {
                                        streamControllerForPageInc
                                            .add(pdfController.page);
                                        streamControllerfortolalPage
                                            .add(pdfController.pagesCount!);
                                      },
                                      onDocumentLoaded: (pageload) {
                                        streamControllerfortolalPage
                                            .add(pdfController.pagesCount!);
                                      })
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

jumpto() {
  try {
    pdfController.jumpToPage(
        StaticControler.defaultpage == 0 ? 0 : StaticControler.defaultpage + 1);
  } catch (e) {
    print(e);
  }
}

pageno() {
  try {
    streamControllerForPageInc.add(pdfController.page);
  } catch (e) {
    print(e);
  }
}

searchText() async {
  StaticControler.Allpages = [];
  final document = await PDFDoc.fromPath(StaticControler.localPath);
  // final document = await PDFDoc.fromURL("https://icseindia.org/document/sample.pdf");
  final pageCount = document.length;
  String result = '';

  for (var i = 0; i < pageCount; i++) {
    final page = await document.pageAt(i + 1);
    final pageText = await page.text;
    print("text of pdf ${pageText}");

    if (pageText.contains(SearchText.text)) {
      result += '${i}|';
      StaticControler.Allpages.add(i);
    }
  }
  print("result of page number is $result");
  print("All pages where text available ${StaticControler.Allpages[0]}");
  print(
      "return data ${StaticControler.Allpages[0]},${StaticControler.Allpages[0].runtimeType}");
  final resultint = await StaticControler.Allpages[0];
  print("return data $resultint,${resultint.runtimeType}");
  return resultint;
}

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