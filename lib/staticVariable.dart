import 'dart:io';

import 'ApiCall.dart';

class StaticControler {
  static String OTPorPDF = "Send OTP";
  static int totalpages = 0;
  static List Allpages = [];
  static File file = File('assets/images/img_image1.png');
  static String localPath = "null";
  static int timer = 0;
  static String CheckingFab = "null";
  static int defaultpage = 0;
  static int integerforpdf = 1;
  static String SearchPage = "0";
  static String Language = "0";
  static List langList=[];
  static List langCODEList=[];
  // static String URL = "https://airapi.elgi.com";
  static String URL = "http://airapi.elgi.com";
  static String reason = "";
  static int len = 1;
  static bool error = true;
  static String result = "";
  static String? fabnumber;
  static List FinalState = [];
  static List FinalCountry = [];
  static List FinalCountryID = [];
  static int CounId = 0;
  static String? Otps;
  static int onetime = 0;
  static int ConectionDuration = 25;
  static int Status = 0;
  static String statesresult = "";
  static late List<object> items = <object>[];
  static var payload;
  static int OtpTriStatus = 0;
  static String? OtpNS;
  static int? NAStatus;
  static int? StatusNA;
}
