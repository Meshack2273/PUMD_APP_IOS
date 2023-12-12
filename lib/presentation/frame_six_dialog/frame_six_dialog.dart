import 'package:pumd_app_ios/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class FrameSixDialog extends StatelessWidget {
  const FrameSixDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        onPopInvoked: (tru) async {
          Navigator.pushNamed(context, AppRoutes.frameOneScreen);
        },
        child: Container(
          width: getHorizontalSize(
            320,
          ),
          padding: getPadding(
            left: 33,
            top: 93,
            right: 33,
            bottom: 93,
          ),
          decoration: AppDecoration.fillWhiteA700.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: getPadding(
                  top: 10,
                ),
                child: const Text(
                  "Asset Has Been Sent For Approval",
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.frameOneScreen);
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red)),
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ));
  }
}
