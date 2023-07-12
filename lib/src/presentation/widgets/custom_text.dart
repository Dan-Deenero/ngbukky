import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/config/locator/app_locator.dart';
import 'package:ngbuka/src/core/shared/colors.dart';

import 'app_spacer.dart';

Widget bodyText(String text) => Text(
      text,
      style: const TextStyle(fontSize: 15, color: AppColors.textColor),
    );
Widget customHeading(String text) => Text(
      text,
      style: const TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary),
    );

Widget customText(
        {required String text,
        required double fontSize,
        required Color textColor,
        FontWeight? fontWeight,
        TextAlign? textAlignment}) =>
    Text(text,
        textAlign: textAlignment ?? TextAlign.left,
        style: TextStyle(
            fontFamily: 'Fira',
            color: textColor,
            fontWeight: fontWeight ?? FontWeight.w500,
            fontSize: fontSize.dp));

Widget haveanaccount() {
  final router = locator<GoRouter>();

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      bodyText("I already have an account,"),
      widthSpace(1),
      GestureDetector(
        onTap: () => router.push(AppRoutes.login),
        child: customText(
            text: "Log me in", fontSize: 15, textColor: AppColors.orange),
      )
    ],
  );
}
