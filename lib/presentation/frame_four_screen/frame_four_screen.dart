// import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:pumd_app_ios/staticVariable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:pumd_app_ios/core/app_export.dart';
import 'package:pumd_app_ios/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:pumd_app_ios/staticVariable.dart';
import 'package:pumd_app_ios/ApiCall.dart';
import 'package:pumd_app_ios/presentation/frame_five_screen/frame_five_screen.dart'
    as ScreenFive;

import 'frame_four_screen.dart';
import 'frame_four_screen.dart';

class Item {
  final String id;
  final String name;

  Item({required this.id, required this.name});
}

late List<Item> items = [
  for (int i = 0; i < StaticControler.len; i++)
    Item(
        id: StaticControler.FinalCountryID[i]
            .replaceAll('{', "")
            .replaceAll('}', ""),
        name: StaticControler.FinalCountry[i]
            .replaceAll('{', "")
            .replaceAll('}', "")),
  // Item(id: 2, name: 'Item 2'),
  // Item(id: 3, name: 'Item 3'),
];
// class DropdownWithID extends StatefulWidget {
//   @override
//   _DropdownWithIDState createState() => _DropdownWithIDState();
// }

// class _DropdownWithIDState extends State<DropdownWithID> {
//   late Item selectedItem;
//  late  List<Item> items =[
//     for (int i = 0; i < StaticControler.len; i++)
//       Item(
//           id:  StaticControler.FinalCountryID[i],
//           name: StaticControler.FinalCountry[i].replaceAll('{' '}', "")),
//     // Item(id: 2, name: 'Item 2'),
//     // Item(id: 3, name: 'Item 3'),
//   ];
//
// //   for(int i=0;i<len;i++)
// //   {
// //   items = [
// //   Item(id: 1, name: 'Item 1'),
// //   Item(id: 2, name: 'Item 2'),
// //   Item(id: 3, name: 'Item 3'),
// //   ];
// // }
//
//   @override
//   void initState() {
//     super.initState();
//     selectedItem = items[0]; // Set initial selected item
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<Item>(
//       value: selectedItem,
//       onChanged: (Item? newValue) {
//         setState(() {
//           selectedItem = newValue!;
//         });
//         // Retrieve the selected item ID
//         String? selectedItemId = newValue?.id;
//         print('Selected Item ID: $selectedItemId');
//       },
//       items: items.map((Item item) {
//         return DropdownMenuItem<Item>(
//           value: item,
//           child: Text(item.name),
//         );
//       }).toList(),
//     );
//   }
// }

late Stream Mystream = Stream.value(0);
late StreamSubscription lisen;
List StateList = [];
String? SelectTed;
String? currentSelectedValue;
String? currentSelectedValueID;

// final List<GlobalObjectKey<FormState>> formKeyList = List.generate(10, (index) => GlobalObjectKey<FormState>(index));

// static final GlobalKey<FormFieldState> dropkey = GlobalKey<FormFieldState>();
// static final GlobalKey<DropdownSearchState<String>> dropdownKeyState =
//     GlobalKey();
// static final GlobalKey<DropdownSearchState<String>> dropdownKeyCountry =
//     GlobalKey();

TextEditingController searchContentSetor = TextEditingController();
TextEditingController fabnum = TextEditingController(
    text: StaticControler.fabnumber.toString().toUpperCase());
TextEditingController StreetCon = TextEditingController(text: "");
TextEditingController Sample = TextEditingController();
TextEditingController CityCon = TextEditingController(text: "");
TextEditingController CountryCon = TextEditingController(text: "");
TextEditingController PinCon = TextEditingController(text: "");
TextEditingController StateCon = TextEditingController(text: "");
TextEditingController PrimaryMail = TextEditingController(text: "");
TextEditingController SecondaryMail = TextEditingController(text: "");
TextEditingController CustomerFirstName = TextEditingController(text: "");
TextEditingController CustomerLastName = TextEditingController(text: "");
TextEditingController Mobilenocon = TextEditingController(text: "");

class FrameFourScreen extends StatefulWidget {
  const FrameFourScreen({Key? key}) : super(key: key);

  @override
  State<FrameFourScreen> createState() => _FrameFourScreenState();
}

class _FrameFourScreenState extends State<FrameFourScreen> {
  Item? selectedItem;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // asyncfun()async{
  //   List  CountryID= await StaticControler.FinalCountryID;
  //   List Country= await StaticControler.FinalCountry;
  // }
  List<Item> items = [
    for (int i = 0; i < StaticControler.len; i++)
      Item(
          id: StaticControler.FinalCountryID[i]
              .replaceAll('{', "")
              .replaceAll('}', ""),
          name: StaticControler.FinalCountry[i]
              .replaceAll('{', "")
              .replaceAll('}', "")),
    // Item(id: 2, name: 'Item 2'),
    // Item(id: 3, name: 'Item 3'),
  ];

  initializ() {
    selectedItem = items.first;
  }

  int _autoValidate = 0;

  Widget build(BuildContext context) {
    return
        // GestureDetector(
        //     onTap: () {
        //   FocusScopeNode currentFocus = FocusScope.of(context);
        //   if (!currentFocus.hasPrimaryFocus) {
        //     currentFocus.unfocus();
        //   }
        // },
        // child :
        WillPopScope(
            onWillPop: () async {
              StaticControler.onetime = 1;
              // currentSelectedValue = "";
              Navigator.pushNamed(context, AppRoutes.frameOneScreen);
              return true; // return true to allow the pop
            },
            child: SafeArea(
                child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
                  child: Container(
                      width: double.maxFinite,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // SearchableDropdown(items: items, onChanged: onChanged);
                            // DropdownSearch<String>(
                            //   mode: Mode.MENU,
                            //   // showSelectedItems: true,
                            //   items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
                            //   dropdownSearchDecoration: InputDecoration(
                            //     labelText: "Menu mode",
                            //     hintText: "country in menu mode",
                            //   ),
                            //   // popupItemDisabled: isItemDisabled,
                            //   // onChanged: itemSelectionChanged,
                            //   //selectedItem: "",
                            //   showSearchBox: true,
                            //   // searchFieldProps: TextFieldProps(
                            //   //   cursorColor: Colors.blue,
                            //   // ),
                            // ),
                            Container(
                                width: double.maxFinite,
                                child: Container(
                                    width: double.maxFinite,
                                    padding: getPadding(
                                        left: 17,
                                        top: 20,
                                        right: 17,
                                        bottom: 30),
                                    decoration: AppDecoration.fillBluegray100,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                margin: const EdgeInsets.only(
                                                    top: 10, left: 60),
                                                child: CustomImageView(
                                                    imagePath:
                                                        ImageConstant.imgImage1,
                                                    height: 50,
                                                    width: 110)),
                                          ]),
                                          Form(
                                              key: formKey,
                                              child: Column(children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 15),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(children: [
                                                    Text("FAB Number",
                                                        style: AppStyle
                                                            .txtPromptBold13),
                                                    const Text(
                                                      "  *",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    )
                                                  ]),
                                                  // overflow: TextOverflow.ellipsis,
                                                  // textAlign: TextAlign.left,
                                                ),

                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: TextFormField(
                                                        textCapitalization:
                                                            TextCapitalization
                                                                .characters,
                                                        controller: fabnum,
                                                        readOnly: true,
                                                        decoration:
                                                            const InputDecoration(
                                                          isDense: true,
                                                          border: OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20.0))),
                                                        ))),
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 15),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(children: [
                                                      Text("Country",
                                                          // overflow: TextOverflow.ellipsis,
                                                          // textAlign: TextAlign.left,
                                                          style: AppStyle
                                                              .txtPromptBold13),
                                                      const Text(
                                                        "  *",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      )
                                                    ])),

                                                DropdownButtonFormField2<Item>(
                                                  autovalidateMode:
                                                      AutovalidateMode.values[
                                                          _autoValidate],
                                                  validator: (value) =>
                                                      selectedItem == ""
                                                          ? "Country couldn't be Empty"
                                                          : null,
                                                  value: selectedItem,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(15),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    20.0)),
                                                    // labelText: "Select State",
                                                    // hintText: "Select Country",
                                                  ),
                                                  isExpanded: true,
                                                  items: items.map((Item item) {
                                                    return DropdownMenuItem<
                                                        Item>(
                                                      value: item,
                                                      // value: item,
                                                      child: Text(item.name),
                                                    );
                                                  }).toList(),
                                                  onChanged:
                                                      (Item? newValue) async {
                                                    Navigator.pushNamed(context,
                                                        AppRoutes.loding);
                                                    setState(() {
                                                      selectedItem = newValue;
                                                    });
                                                    // Retrieve the selected item ID
                                                    String? selectedItemId =
                                                        newValue?.id;
                                                    currentSelectedValue =
                                                        newValue?.name;
                                                    setState(() {
                                                      StaticControler.CounId =
                                                          int.parse(
                                                              selectedItemId!);
                                                    });

                                                    print(
                                                        'Selected Item ID: ${StaticControler.CounId}');

                                                    try {
                                                      StateList = await ApiCall
                                                          .GetState();
                                                      if (StaticControler
                                                                  .statesresult ==
                                                              "State List Has Been Fetched" ||
                                                          StaticControler
                                                                  .statesresult ==
                                                              "No State Is Found") {
                                                        Navigator.pop(context);
                                                      }
                                                    } on SocketException catch (e) {
                                                      print(
                                                          "exceptpion on state $e");
                                                      toscreenoneState(context);
                                                    }
                                                    // Navigator.pushNamed(context,
                                                    //     AppRoutes.loding);
                                                    // lisen = Mystream.listen(
                                                    //     (event) async {
                                                    //   if (event.Stream
                                                    //           .value() ==
                                                    //       1) {
                                                    //     StateList =
                                                    //         await ApiCall
                                                    //             .GetState();
                                                    //   }
                                                    // });
                                                    // StateList = await ApiCall
                                                    //     .GetState();
                                                    setState(() {
                                                      currentSelectedValue =
                                                          newValue?.name;
                                                    });
                                                  },
                                                  //onchange
                                                  // Search implementation using dropdown_button2 package
                                                  searchController:
                                                      searchContentSetor,
                                                  // searchInnerWidget: Text('Search'),
                                                  searchInnerWidgetHeight: 50,
                                                  searchInnerWidget: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 8,
                                                      bottom: 4,
                                                      right: 8,
                                                      left: 8,
                                                    ),
                                                    child: TextFormField(
                                                      controller:
                                                          searchContentSetor,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: false,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 5,
                                                          vertical: 8,
                                                        ),
                                                        labelText:
                                                            'Select Country',
                                                        counterText: '',
                                                        hintStyle:
                                                            const TextStyle(
                                                                fontSize: 14),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  searchMatchFn:
                                                      (rtItem, searchValue) {
                                                    return (rtItem.value.name
                                                        .toLowerCase()
                                                        .contains(searchValue
                                                            .toLowerCase()));
                                                  },
                                                  //This to clear the search value when you close the menu
                                                  onMenuStateChange: (isOpen) {
                                                    if (!isOpen) {
                                                      searchContentSetor
                                                          .clear();
                                                    }
                                                  },
                                                ),

                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 15),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(children: [
                                                      Text("State",
                                                          // overflow: TextOverflow.ellipsis,
                                                          // textAlign: TextAlign.left,
                                                          style: AppStyle
                                                              .txtPromptBold13),
                                                      const Text(
                                                        "  *",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      )
                                                    ])),

                                                DropdownSearch<String>(
                                                  selectedItem:
                                                      currentSelectedValueID,
                                                  mode: Mode.MENU,
                                                  showSelectedItems: true,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      currentSelectedValueID =
                                                          newValue;
                                                    });
                                                  },
                                                  // items:
                                                  //  DropdownMenuItem<String>(
                                                  //     value: map['value'],
                                                  //     child: Text(map['name']),
                                                  //   );
                                                  // ).toList(),
                                                  items: [
                                                    for (int i = 0;
                                                        i <
                                                            StaticControler
                                                                .FinalState
                                                                .length;
                                                        i++)
                                                      {
                                                        StaticControler
                                                            .FinalState[i]
                                                      }
                                                          .toString()
                                                          .replaceAll('{', "")
                                                          .replaceAll('}', "")
                                                    // for (int i = 0;
                                                    //     i < StateList.length;
                                                    //     i++)
                                                    //   {StateList[i]}
                                                    //       .toString()
                                                    //       .replaceAll('{', "")
                                                    //       .replaceAll('}', "")
                                                  ],

                                                  dropdownSearchDecoration:
                                                      InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(18),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    20.0)),
                                                    // labelText: "Select State",
                                                    // hintText: "Select State",
                                                  ),
                                                  // popupItemDisabled:,
                                                  // onChanged: true,
                                                  //selectedItem: "",
                                                  showSearchBox: true,
                                                  searchFieldProps:
                                                      TextFieldProps(
                                                    cursorColor: Colors.blue,
                                                  ),
                                                ),
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 15),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(children: [
                                                      Text(
                                                          "Company Name / Customer Name",
                                                          // overflow: TextOverflow.ellipsis,
                                                          // textAlign: TextAlign.left,
                                                          style: AppStyle
                                                              .txtPromptBold13),
                                                      const Text(
                                                        "  *",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      )
                                                    ])),
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: TextFormField(
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                    .values[
                                                                _autoValidate],
                                                        validator: (value) =>
                                                            CustomerFirstName
                                                                        .text ==
                                                                    ""
                                                                ? "First Name couldn't be Empty"
                                                                : null,
                                                        autofocus: true,
                                                        controller:
                                                            CustomerFirstName,
                                                        decoration:
                                                            const InputDecoration(
                                                          isDense: true,
                                                          border: OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20.0))),
                                                        ))),
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 15),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(children: [
                                                      Text(
                                                          "Last Name (Optional)",
                                                          // overflow: TextOverflow.ellipsis,
                                                          // textAlign: TextAlign.left,
                                                          style: AppStyle
                                                              .txtPromptBold13),
                                                    ])),
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: TextFormField(
                                                        // autovalidateMode:
                                                        //     AutovalidateMode
                                                        //             .values[
                                                        //         _autoValidate],
                                                        // validator: (value) =>
                                                        //     CustomerLastName
                                                        //                 .text ==
                                                        //             ""
                                                        //         ? "Last Name couldn't be Empty"
                                                        //         : null,
                                                        controller:
                                                            CustomerLastName,
                                                        decoration:
                                                            const InputDecoration(
                                                          isDense: true,
                                                          border: OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20.0))),
                                                        ))),

                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 15),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(children: [
                                                      Text("Address",
                                                          // overflow: TextOverflow.ellipsis,
                                                          // textAlign: TextAlign.left,
                                                          style: AppStyle
                                                              .txtPromptBold13),
                                                      const Text(
                                                        "  *",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      )
                                                    ])),
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: TextFormField(
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                    .values[
                                                                _autoValidate],
                                                        validator: (value) =>
                                                            StreetCon.text == ""
                                                                ? "Address couldn't be Empty"
                                                                : null,
                                                        controller: StreetCon,
                                                        decoration:
                                                            const InputDecoration(
                                                          isDense: true,
                                                          border: OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20.0))),
                                                        ))),
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 15),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(children: [
                                                      Text("City",
                                                          // overflow: TextOverflow.ellipsis,
                                                          // textAlign: TextAlign.left,
                                                          style: AppStyle
                                                              .txtPromptBold13),
                                                      const Text(
                                                        "  *",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      )
                                                    ])),
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: TextFormField(
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                    .values[
                                                                _autoValidate],
                                                        validator: (value) =>
                                                            CityCon.text == ""
                                                                ? "City couldn't be Empty"
                                                                : null,
                                                        controller: CityCon,
                                                        decoration:
                                                            const InputDecoration(
                                                          isDense: true,
                                                          border: OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20.0))),
                                                        ))),
                                                // Container(
                                                //     margin: const EdgeInsets.only(top: 10),
                                                //     child: TextFormField(
                                                //         autovalidateMode: AutovalidateMode
                                                //             .values[_autoValidate],
                                                //         validator: (value) => CountryCon
                                                //             .text ==
                                                //             ""
                                                //             ? "Country couldn't be Empty"
                                                //             : null,
                                                //         controller: CountryCon,
                                                //         decoration: const InputDecoration(
                                                //           isDense: true,
                                                //           border: OutlineInputBorder(
                                                //               borderRadius:
                                                //                   BorderRadius.all(
                                                //                       Radius.circular(
                                                //                           20.0))),
                                                //         ))),
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 15),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(children: [
                                                      Text("PIN Code",
                                                          // overflow: TextOverflow.ellipsis,
                                                          // textAlign: TextAlign.left,
                                                          style: AppStyle
                                                              .txtPromptBold13),
                                                      const Text(
                                                        "  *",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      )
                                                    ])),
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: TextFormField(
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                                  .values[
                                                              _autoValidate],
                                                      validator: (value) => PinCon
                                                                  .text ==
                                                              ""
                                                          ? "Pin code couldn't be Empty"
                                                          : null,
                                                      controller: PinCon,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly
                                                      ],
                                                      decoration:
                                                          const InputDecoration(
                                                        isDense: true,
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        20.0))),
                                                      ),
                                                    )),

                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 15),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(children: [
                                                      Text("Primary Email",
                                                          // overflow: TextOverflow.ellipsis,
                                                          // textAlign: TextAlign.left,
                                                          style: AppStyle
                                                              .txtPromptBold13),
                                                      const Text(
                                                        "  *",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      )
                                                    ])),
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: TextFormField(
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                    .values[
                                                                _autoValidate],
                                                        controller: PrimaryMail,
                                                        keyboardType:
                                                            TextInputType
                                                                .emailAddress,
                                                        decoration:
                                                            const InputDecoration(
                                                          isDense: true,
                                                          border: OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20.0))),
                                                        ),
                                                        validator: (input) {
                                                          if (isValidPrimaryEmail() ==
                                                              true) {
                                                            if (PrimaryMail
                                                                    .text ==
                                                                SecondaryMail
                                                                    .text) {
                                                              return "Primary Mail And Secondary Mail Could Not Be Same";
                                                            }
                                                          } else {
                                                            return "Check your email";
                                                          }
                                                        })),

                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 15),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(children: [
                                                      Text(
                                                          "Secondary Mail (Optional)",
                                                          // overflow: TextOverflow.ellipsis,
                                                          // textAlign: TextAlign.left,
                                                          style: AppStyle
                                                              .txtPromptBold13),
                                                    ])),
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType
                                                              .emailAddress,
                                                      controller: SecondaryMail,
                                                      decoration:
                                                          const InputDecoration(
                                                        isDense: true,
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        20.0))),
                                                      ),
                                                    )),
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 15),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(children: [
                                                      Text(
                                                          "Mobile No (Optional)",
                                                          // overflow: TextOverflow.ellipsis,
                                                          // textAlign: TextAlign.left,
                                                          style: AppStyle
                                                              .txtPromptBold13),
                                                    ])),
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: TextFormField(
                                                        // autovalidateMode:
                                                        //     AutovalidateMode
                                                        //             .values[
                                                        //         _autoValidate],
                                                        // validator: (value) =>
                                                        //     Mobilenocon.text ==
                                                        //             ""
                                                        //         ? "Mobile No couldn't be Empty"
                                                        //         : null,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .digitsOnly
                                                        ],
                                                        controller: Mobilenocon,
                                                        decoration:
                                                            const InputDecoration(
                                                          isDense: true,
                                                          border: OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20.0))),
                                                        )))
                                              ])),
                                          const SizedBox(
                                            height: 40,
                                          ),
                                          Center(
                                              child: TextButton.icon(
                                                  icon: const Icon(
                                                    Icons.save,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  Colors.red),
                                                      padding:
                                                          MaterialStateProperty
                                                              .all<EdgeInsetsGeometry?>(
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 18,
                                                                      right: 50,
                                                                      left: 47,
                                                                      bottom:
                                                                          18))),
                                                  label: const Text(
                                                    "Save",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    print(
                                                        "payload json state${StaticControler.payload}");
                                                    print(SelectTed);
                                                    Navigator.pushNamed(context,
                                                        AppRoutes.loding);
                                                    ScreenFive.Otp1.text = "";
                                                    ScreenFive.Otp2.text = "";
                                                    ScreenFive.Otp3.text = "";
                                                    ScreenFive.Otp4.text = "";
                                                    try {
                                                      StaticControler.NAStatus =
                                                          await ApiCall
                                                              .SaveNewAss();
                                                      ApiCall.otpTrig();
                                                    } on SocketException catch (e) {
                                                      print(
                                                          "exceptpion oucce $e");
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
                                                          "Service Unavailable") {
                                                        ServiceUnavilabe(
                                                            context);
                                                      }
                                                      if (e.toString() ==
                                                          "Connection timed out") {
                                                        OTPConectionTimeOutDialog(
                                                            context);
                                                      }
                                                    }
                                                    // StaticControler.NAStatus=await ApiCall.SaveNewAss();
                                                    print(await StaticControler
                                                        .NAStatus);
                                                    print(
                                                        "seleced idprint$currentSelectedValueID");
                                                    if (currentSelectedValueID ==
                                                        null) {
                                                      StateDialoge();
                                                    }
                                                    if (formKey.currentState
                                                            ?.validate() ==
                                                        true) {
                                                      _autoValidate = 1;

                                                      if (StaticControler
                                                              .NAStatus ==
                                                          1) {
                                                        // ApiCall.NewAscotTrig();
                                                        onTapSave(context);
                                                      }
                                                    } else {
                                                      ValidateDialog();
                                                    }
                                                    // if(isValidPrimaryEmail()==true&&isValidSecEmail()==true) {
                                                    //   ApiCall.NewAscotpTrig();
                                                    //   onTapSave(context);
                                                    // }
                                                    // else{
                                                    //   ValidateDialog();
                                                    // }
                                                  })),
                                          // padding(
                                          //     padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
                                          // ),

                                          // CustomButton(
                                          //     height: getVerticalSize(54),
                                          //     text: "Save",
                                          //     margin: EdgeInsets.all(20),
                                          //     onTap: () {
                                          //       print(currentSelectedValue);
                                          //       if (formKey.currentState?.validate() ==
                                          //           true) {
                                          //         _autoValidate = 1;
                                          //         ApiCall.NewAscotpTrig();
                                          //         onTapSave(context);
                                          //       } else {
                                          //         ValidateDialog();
                                          //       }
                                          //       // if(isValidPrimaryEmail()==true&&isValidSecEmail()==true) {
                                          //       //   ApiCall.NewAscotpTrig();
                                          //       //   onTapSave(context);
                                          //       // }
                                          //       // else{
                                          //       //   ValidateDialog();
                                          //       // }
                                          //     }
                                          //     ),
                                          // SizedBox(
                                          //   height:
                                          //       MediaQuery.of(context).viewInsets.bottom,
                                          // ),
                                        ])))
                          ]))),
            )));
  }

  toscreenoneState(context) {
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
              toScreenOne(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  ServiceUnavilabe(context) {
    showCupertinoDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Service Unavailable'),
        content: const Text('Try Again Later'),
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

  LodingScreen(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loding);
  }

  bool isValidPrimaryEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(PrimaryMail.text);
  }

  bool isValidSecEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(SecondaryMail.text);
  }

  onTapSave(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frameFiveScreen);
  }

  toScreenOne(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frameOneScreen);
  }

  onStay(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frameFourScreen);
  }

  ValidateDialog() {
    onStay(context);
    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            // title: const Text('Error',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
            title: Column(
              children: [
                const Text(
                  "Fill The Form With All Mandatory Filed",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Text("Denoted By "),
                const Text(
                  " *",
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
            // content:  Row(
            //   children: [
            //     Text("Denoted By "),
            //
            //
            //     const Text(" *",style: TextStyle(color: Colors.red),)
            // ],
            // )

            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    onStay(context);
                  },
                  child: const Text(
                    "Ok",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ],
          );
        });
  }

  StateDialoge() {
    onStay(context);
    showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            content: Text(
              "Choose any Country and State",
              style: TextStyle(color: Colors.red),
            ),
          );
        });
  }

// padding({required EdgeInsets padding}) {}
}
