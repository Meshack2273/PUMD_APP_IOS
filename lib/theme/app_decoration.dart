import 'package:flutter/material.dart';
import 'package:pumd_app/core/app_export.dart';
import 'package:hexcolor/hexcolor.dart';

class AppDecoration {
  static BoxDecoration get outlineBlack900 => BoxDecoration(
        color: ColorConstant.black900,
        border: Border.all(
          color: ColorConstant.black900,
          width: getHorizontalSize(
            1,
          ),
        ),
      );

  static BoxDecoration get fillBluegray100 => BoxDecoration(
        color: HexColor("#bbb8b8"),
      );

  static BoxDecoration get txtOutlineBlack900 => BoxDecoration(
        color: HexColor("#ee3124"),
        border: Border.all(
          color: HexColor("#ee3124"),
          width: getHorizontalSize(
            1,
          ),
        ),
      );

  static BoxDecoration get fillWhiteA700 => BoxDecoration(
        color: ColorConstant.whiteA700,
      );
}

class BorderRadiusStyle {
  static BorderRadius roundedBorder16 = BorderRadius.circular(
    getHorizontalSize(
      16,
    ),
  );

  static BorderRadius txtRoundedBorder16 = BorderRadius.circular(
    getHorizontalSize(
      16,
    ),
  );
}
