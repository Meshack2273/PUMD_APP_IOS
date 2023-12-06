import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:pumd_app_ios/presentation/frame_three_screen/pdfScreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

int start = 10;

class lodingScreenWithTime extends StatefulWidget {
  @override
  loding createState() => new loding();
}

class loding extends State<lodingScreenWithTime> {
  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
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
    setState(() {
      start = 10;
    });
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        try {
          throw Null;
        } catch (e) {
          print(e);
          showCupertinoDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) {
                return WillPopScope(
                  onWillPop: () async {
                    return false;
                  },
                  child: CupertinoAlertDialog(
                    content: const Text(
                      "You can't go back on this stage",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK',
                              style: TextStyle(fontWeight: FontWeight.bold)))
                    ],
                  ),
                );
              });
          return true;
        }
      },
      child: Scaffold(
          backgroundColor: HexColor("#bbb8b8"),
          body: Container(
              padding: EdgeInsets.only(top: 350),
              child: Column(children: [
                Center(
                    child: SpinKitWave(
                  color: HexColor("#ee3124"),
                  size: 50.0,
                )),
                SizedBox(height: 20),
                Text(
                  'Please wait ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Estimated Time ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "$start",
                      style: TextStyle(
                          color: HexColor("#ee3124"),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      " Sec",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ]))),
    );
  }
}
