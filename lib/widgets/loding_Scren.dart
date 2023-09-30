//import 'package:flutter/cupertino.dart';
// import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class lodingScreen extends StatefulWidget {
  @override
  lod createState() => new lod();
}

class lod extends State<lodingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'Please wait',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )
            ])));
  }
}
