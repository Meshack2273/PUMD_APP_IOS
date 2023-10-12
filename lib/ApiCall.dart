import 'dart:async';
import 'dart:core';
import 'dart:core';
import 'dart:io';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pdfx/pdfx.dart';
import 'package:pumd_app_ios/staticVariable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pumd_app_ios/presentation/frame_one_screen/frame_one_screen.dart'
    as ScreenOne;
import 'dart:convert';
import 'package:pumd_app_ios/presentation/frame_four_screen/frame_four_screen.dart'
    as ScreenFour;
import 'package:path_provider/path_provider.dart';

import 'main.dart';

class object {
  late final String name;
  late final int Id;

  object(this.name, this.Id) {}
}

class ApiCall {
  static GetToc() async {
    final internetConection = await InternetConnectionChecker().hasConnection;
    print("internet connection for get tok ${internetConection}");
    if (internetConection == false) {
      print("Connection failed");
      return "Connection Failed";
    } else {
      try {
        print("started");
        var headers = {'Content-Type': 'application/json'};
        var request = http.Request(
            'POST', Uri.parse('${StaticControler.URL}/ExcelData/authenticate'));
        request.body = json
            .encode({"Username": "powerapp", "Password": "PowerApp^6787453"});
        request.headers.addAll(headers);
        try {
          http.StreamedResponse response = await request.send().timeout(
            Duration(seconds: StaticControler.ConectionDuration),
            // Set the timeout duration
            onTimeout: () {
              throw TimeoutException('The request timed out.');
            },
          );

          if (response.statusCode == 200) {
            // print(await response.stream.bytesToString());
            final jsonRes = jsonDecode(await response.stream.bytesToString());
            final Token = jsonRes['token'];
            // // print(tox);
            print("Get TOk Completed");

            return Token;
            // Map<String,dynamic> json={await response.stream.bytesToString()} as Map<String, dynamic>;
            // Map<dynamic, dynamic> result = json;
            // Map<String, dynamic> data = Map<String, dynamic>();
            // for (dynamic type in result.keys) {
            //   data[type.toString()] = result[type];
            // }
          } else {
            print("Get token reason ${response.reasonPhrase.toString()}");
            StaticControler.reason = response.reasonPhrase.toString();
            return response.reasonPhrase.toString();
          }
        } on TimeoutException catch (e) {
          print("Timeout Exception Get Token : ${e.message}");
          return "Connection Timeout";
        }
      } catch (e) {
        print("Get Tok $e");
        return "null";
      }
    }
  }

  static otpTrig() async {
    try {
      final token = await GetToc();

      if (token == "Connection Failed") {
        return "Connection Failed";
      } else if (token == "Service Unavailable") {
        return "Service Unavailable";
      } else if (token == "Connection Timeout") {
        return "Connection Timeout";
      } else if (token == "Not Found") {
        return "Not Found";
      }
      else if (token == "Proxy Error")
        {
          return "Proxy Error";
        }
    } catch (e) {
      print("Login GetToken Exception $e");
      return "Connection Exception";
    }
    print("otp tre started");
    var request = http.Request(
        'POST', Uri.parse('${StaticControler.URL}/ProductManual/TriggerOTP'));
    request.body = json.encode({"fabNumber": StaticControler.fabnumber});
    request.headers.addAll(
        {'Authorization': await GetToc(), 'Content-Type': 'application/json'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      try {
        dynamic jsonres = jsonDecode(await response.stream.bytesToString());
        StaticControler.OtpTriStatus = jsonres['status'];
        if (StaticControler.OtpTriStatus == 1) {
          StaticControler.OtpTriStatus = jsonres['status'];
          print(StaticControler.OtpTriStatus);
          final PriEmail = jsonres['fabMaster']['primaryEmail'] as String?;
          final SecEmail = jsonres['fabMaster']['secondaryEmail'] as String?;
          final Otp = jsonres['otp'] as String?;
          final sts = jsonres['status'];
          List rep = ["$PriEmail ", "$SecEmail ", "$Otp ", sts];
          print(rep);
          return rep;
        } else if (StaticControler.OtpTriStatus == 2) {
          List result = [jsonres['result'], "one", "two", 2];

          return result;
        } else {
          List result = [jsonres['result'], "one", "two", 0];

          return result;
        }
      } on SocketException catch (e) {
        CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                print("Connection failed");
                navigatorKey.currentState?.pushNamed('/frame_one_screen');
              },
              child: const Text('OK'),
            ),
          ],
        );
      }
    } else {
      print("Otptrig reason code ${response.statusCode}");
      print("Otptrig reason ${response.reasonPhrase}");
      return response.reasonPhrase;
    }
  }

  static SaveNewAss() async {
    try {
      final token = await GetToc();
      if (token == "Connection Timeout") {
        return "Connection Timeout";
      }
      if (token == "Service Unavailable") {
        return "Service Unavailable";
      }
    } catch (e) {
      print("Login GetToken Exception $e");
      return "Connection Exception";
    }
    var request = http.Request(
        'POST', Uri.parse('${StaticControler.URL}/ProductManual/NewAsset'));

    request.body = json.encode({
      "fabNumber": StaticControler.fabnumber,
      "firstName": ScreenFour.CustomerFirstName.text,
      "lastName": ScreenFour.CustomerLastName.text,
      "primaryEmail": ScreenFour.PrimaryMail.text,
      "secondaryEmail": ScreenFour.SecondaryMail.text,
      "mobileNumber": ScreenFour.Mobilenocon.text,
      "street": ScreenFour.StreetCon.text,
      "city": ScreenFour.CityCon.text,
      "country": ScreenFour.currentSelectedValue,
      "state": ScreenFour.currentSelectedValueID,
      "zipCode": ScreenFour.PinCon.text
    });
    StaticControler.payload = request.body;
    print(request.body);
    request.headers.addAll(
        {'Authorization': await GetToc(), 'Content-Type': 'application/json'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      final jason = jsonDecode(await response.stream.bytesToString());
      final resst = jason['status'];
      print("Status ${resst}");
      return resst;
    } else {
      print("failed ${response.reasonPhrase}");
    }
  }

  static ConfOTPForManuval() async {
    print("confirm otp started");
    // var headers = {'Authorization': GetToc().toString(),
    //   'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('${StaticControler.URL}/ProductManual/VerifyOTP'));
    request.body = json.encode(
        {"fabNumber": StaticControler.fabnumber, "otp": StaticControler.Otps});
    request.headers.addAll(
        {'Authorization': await GetToc(), 'Content-Type': 'application/json'});
    // final byets=request.bodyBytes;
    // print(byets);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
      final jsonres = jsonDecode(await response.stream.bytesToString());
      var statuss = jsonres['status'];
      print("confirm otp status $statuss");
      StaticControler.result = jsonres['result'];
      return jsonres['status'];
    } else {
      print(response.reasonPhrase);
    }
  }

  static ConfOTPForNA() async {
    print("confirm otpNA started");
    // var headers = {'Authorization': GetToc().toString(),
    //   'Content-Type': 'application/json'};
    var request = http.Request('POST',
        Uri.parse('${StaticControler.URL}/ProductManual/VerifyOTPonNewAsset'));
    request.body = json.encode(
        {"fabNumber": StaticControler.fabnumber, "otp": StaticControler.OtpNS});
    request.headers.addAll(
        {'Authorization': await GetToc(), 'Content-Type': 'application/json'});
    // final byets=request.bodyBytes;
    // print(byets);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
      final jsonres = jsonDecode(await response.stream.bytesToString());
      print(jsonres['status']);
      return jsonres['status'];
    } else {
      print(response.reasonPhrase);
    }
  }

  static GetCountry() async {
    print("Get Country started");
    // var headers={ 'Authorization':ApiCall.GetToc().toString()};
    var request = http.Request(
        'POST', Uri.parse("${StaticControler.URL}/ProductManual/GetCountry"));

    //https://countriesnow.space/api/v0.1/countries
    // request.body = jsonEncode(
    //     {
    //   "country": "India"
    // }
    // );
    request.headers.addAll(
        {'Authorization': await GetToc(), 'Content-Type': 'application/json'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // print("${await response.stream.bytesToString()}  Respovced");
      dynamic CountryList =
          jsonDecode(await response.stream.bytesToString())['countryList'];
      print("Country List   $CountryList");
      // List Country=CountryList['country'][1];
      List coun = List.from(CountryList);
      StaticControler.len = await coun.length;
      print("conlist $coun");

      //  var data=([
      //      for(int i=0;i<len;i++) {
      //        coun[i]["name"],
      //        coun[i]["id"]
      //      }]
      // );
      //
      // StaticControler.items= <object>[
      //   object(data.first as String,data.last as int)
      // ];
      StaticControler.FinalCountry = await [
        for (int i = 0; i < StaticControler.len; i++)
          {
            coun[i]["name"],
            // state[1]["stateName"],
            // state[2]["stateName"],
            // state[3]["stateName"]
          }.toString().replaceAll('{' '}', "")
      ];
      StaticControler.FinalCountryID = await [
        for (int i = 0; i < StaticControler.len; i++)
          {
            coun[i]["id"]
            // state[1]["stateName"],
            // state[2]["stateName"],
            // state[3]["stateName"]
          }.toString().replaceAll('{' '}', "")
      ];
      print("final Country ${StaticControler.FinalCountry}");
      return CountryList;
      // return await StaticControler.FinalCountry;
    } else {
      print(" else res ${response.reasonPhrase}");
    }
  }

  static GetState() async {
    print("Get state start");
    // var headers={ 'Authorization':ApiCall.GetToc().toString()};
    var request = http.Request(
        'POST', Uri.parse("${StaticControler.URL}/ProductManual/GetState"));
    request.body = jsonEncode({"CountryID": StaticControler.CounId});
    request.headers.addAll(
        {'Authorization': await GetToc(), 'Content-Type': 'application/json'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // var Statelist = jsonDecode(await response.stream.bytesToString())['data']["states"];
      var jsonRes = jsonDecode(await response.stream.bytesToString());
      StaticControler.statesresult = jsonRes["result"];
      var Statelist = jsonRes["stateList"];
      print(Statelist);
      List state = List.from(Statelist);
      int len = await state.length;
      print(len);
      StaticControler.FinalState = await [
        for (int i = 0; i < len; i++)
          {
            state[i]["name"],
          }.toString().replaceAll('{' '}', "")
      ];
      print("all State ${StaticControler.FinalState}");
      return await StaticControler.FinalState;
    } else {
      print(" else res ${response.reasonPhrase}");
    }
  }

  static final String BASE_URL =
      "${StaticControler.URL}/ProductManual/GetPDF?fab=${StaticControler.fabnumber}.pdf";

  static loadPDF() async {
    var responce;

    if (StaticControler.Language == "En") {
      responce = await http.post(
          Uri.parse(
              "${StaticControler.URL}/ProductManual/GetPDF?fab=${StaticControler.fabnumber}.pdf"),
          headers: {
            'Authorization': await GetToc(),
          });
    } else if (StaticControler.Language == "Fr") {
      responce = await http.post(Uri.parse(
          "https://myessayreview.com/wp-content/uploads/2019/08/E-book-of-30-sample-essays.pdf"));
    } else {
      responce = await http.post(
          Uri.parse(
              "${StaticControler.URL}/ProductManual/GetPDF?fab=${StaticControler.fabnumber}.pdf"),
          headers: {
            'Authorization': await GetToc(),
          });
    }
    var dir = await getApplicationDocumentsDirectory();
    File file = await File("${dir.path}/data.pdf");
    print("pdf data ${responce.bodyBytes}");
    print("type of file ${file.runtimeType}");
    file.writeAsBytesSync(responce.bodyBytes, flush: true);
    StaticControler.localPath = await file.path;
    return await file.path;
  }

  static loadPDFLng() async {
    var responce = await http.get(Uri.parse(
        "https://api29.ilovepdf.com/v1/download/m5phbdz65m0qsAkn4n9vr81xktzpmhvgq6jm973fk9lAfzpbj8ph8wh8mkr81kwdrwd41qvmj7pdmtnvqtkk1brpsy1jyAywvltk95zAhqA5t8d7m2fjmjjjtzpf0ygsdt0m6krg4ynjxf61f8yhnrprymtx10646pAwtts20tsw2s2bxq91"));
    var dir = await getApplicationDocumentsDirectory();
    File file = await File("${dir.path}/lang.pdf");
    print("pdf data ${responce.bodyBytes}");
    print("type of file ${file.runtimeType}");
    file.writeAsBytesSync(responce.bodyBytes, flush: true);
    StaticControler.localPath = await file.path;
    return await file.path;
  }

  // static  loadPDFFile() async {
  //   var responce=await http.post(Uri.parse(
  //       "${StaticControler.URL}/ProductManual/GetPDF?fab=AQIS031834.pdf")
  //
  //       ,headers:{
  //         'Authorization': await GetToc(),
  //       } );
  //   // http.StreamedResponse response = await request.send();
  //   var dir = await getApplicationDocumentsDirectory();
  //   File file = await File("${dir.path}/data.pdf");
  //   print("pdf data ${responce.bodyBytes}");
  //   print("type of file ${file.runtimeType}");
  //   file.writeAsBytesSync(responce.bodyBytes, flush: true);
  //   return await file;
  // }
  // static Future<String> loadPDF2() async {
  //   var response = await http.get(Uri.parse("https://www.ibm.com/downloads/cas/GJ5QVQ7X"));
  //
  //   var dir = await getApplicationDocumentsDirectory();
  //   File file = File("${dir.path}/data.pdf");
  //   file.writeAsBytesSync(response.bodyBytes, flush: true);
  //   return file.path;
  // }
  // static GetPdf()async
  // {
  //   var request = http.Request('POST', Uri.parse(
  //       "${StaticControler.URL}/ProductManual/GetPDF?fab=${StaticControler
  //           .fabnumber}.pdf"));
  //   request.headers.addAll({
  //     'Authorization': await GetToc(),
  //     'Content-Type': 'application/pdf'
  //   }
  //   );
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     // var Statelist = jsonDecode(await response.stream.bytesToString())['data']["states"];
  //     print(await response.stream.bytesToString());
  //   }
  //   else
  //     {
  //       print(response.reasonPhrase.toString());
  //     }
  // }
  static NewAscotpTrig() async {
    print("ass otp tre strat");
    var request = http.Request(
        'POST', Uri.parse('${StaticControler.URL}/ProductManual/TriggerOTP'));
    request.body = json.encode({
      "fabNumber": ScreenOne.fabNum.text,
      "fabMaster": {"primaryEmail": ScreenFour.PrimaryMail.text}
    });
    request.headers.addAll(
        {'Authorization': await GetToc(), 'Content-Type': 'application/json'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

// static PriEmail()async{
//   //late List priEmail= ApiCall.otpTrig().tolist;
//   return await otpTrig();
// }
}
// class Modl {
//   final String stateName;
//
//   Modl._({required this.stateName});
//
//   factory Modl.fromJson(Map<dynamic, dynamic> json) {
//     return Modl._(
//       stateName: json['stateName'],
//
//     );
//   }
// }
