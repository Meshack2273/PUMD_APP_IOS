import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pumd_app_ios/core/app_export.dart';
import 'package:pumd_app_ios/presentation/frame_one_screen/frame_one_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                FrameOneScreen()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: HexColor("#bbb8b8"),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 7.0,
                      color: Colors.white,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child:
                Stack(
                  children: [
                    Wrap(

                      direction: Axis.vertical,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 45),
                            child: Wrap(
                              children: [
                                AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    FadeAnimatedText('ELG',
                                      // textStyle: GoogleFonts.getFont(
                                      //     'Bebas Neue',
                                      textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 66),
                                      // speed: Duration(seconds: 5  )
                                    ),

                                  ],
                                  onTap: () {
                                    print("Tap Event");
                                  },
                                ),
                                Stack(

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5,left: 1),
                                      child: AnimatedTextKit(
                                        repeatForever: true,
                                        animatedTexts: [
                                          FadeAnimatedText('■',

                                            textStyle:

                                            GoogleFonts.getFont(
                                                'Bebas Neue',
                                                textStyle: TextStyle(color:HexColor("#ee3115") ),fontSize: 17),
                                            // speed: Duration(seconds: 5  )
                                          ),

                                        ],
                                        onTap: () {
                                          print("Tap Event");
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 7),
                                      child: AnimatedTextKit(
                                        repeatForever: true,
                                        animatedTexts: [
                                          FadeAnimatedText('𝗜',
                                            // textStyle: GoogleFonts.getFont(
                                            //     'Bebas Neue',
                                            textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 49),
                                            // speed: Duration(seconds: 5  )
                                          ),

                                        ],
                                        onTap: () {
                                          print("Tap Event");
                                        },
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),

                          ),
                        ),
                        AnimatedTextKit(
                          repeatForever: true,
                          animatedTexts: [
                            FadeAnimatedText('Always Better',
                              textStyle: GoogleFonts.getFont(
                                  'Roboto Mono',
                                  textStyle: TextStyle(color: HexColor("#ee3115"),fontWeight: FontWeight.bold,fontSize: 19,letterSpacing: 6)
                              ),
                              // speed: Duration(seconds: 5  )
                            ),

                          ],
                          onTap: () {
                            print("Tap Event");
                          },
                        ),

                      ],
                    ),

                    Positioned(
                      bottom: 71,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 8.0,
                        color: HexColor("#bbb8b8"),
                      ),
                    ),
                    // Positioned(
                    //   bottom: 79,
                    //   left: 166,
                    //   right: 51,
                    //
                    //   child: Container(
                    //     height: 8.7,
                    //     color: HexColor("#ee3124"),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

