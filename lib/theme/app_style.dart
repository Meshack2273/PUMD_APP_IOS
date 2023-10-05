import 'package:flutter/material.dart';
import 'package:pumd_app_ios/core/app_export.dart';

class AppStyle {
  static TextStyle txtRobotoRegular16 = TextStyle(
    color: ColorConstant.bluegray400,
    fontSize: getFontSize(
      16,
    ),
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtInterRegular52 = TextStyle(
    color: ColorConstant.black900,
    fontSize: getFontSize(
      52,
    ),
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtPromptBold13 = TextStyle(
    color: ColorConstant.black900,
    fontSize: getFontSize(
      13,
    ),
    fontFamily: 'Prompt',
    fontWeight: FontWeight.w700,
  );

  static TextStyle txtPromptRegular15 = TextStyle(
    color: ColorConstant.black900,
    fontSize: getFontSize(
      15,
    ),
    fontFamily: 'Prompt',
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtPromptRegular15Black900 = TextStyle(
    color: ColorConstant.black900,
    fontSize: getFontSize(
      15,
    ),
    fontFamily: 'Prompt',
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtRobotoRegular20 = TextStyle(
    color: ColorConstant.black900,
    fontSize: getFontSize(
      20,
    ),
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtPromptRegular15WhiteA700 = TextStyle(
    color: ColorConstant.whiteA700,
    fontSize: getFontSize(
      15,
    ),
    fontFamily: 'Prompt',
    fontWeight: FontWeight.w400,
  );
}
