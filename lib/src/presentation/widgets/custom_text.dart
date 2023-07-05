import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
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
        required Color textColor}) =>
    Text(text,
        style:
            TextStyle(fontFamily: '', color: textColor, fontSize: fontSize.dp));

Widget haveanaccount() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        bodyText("I already have an account,"),
        widthSpace(1),
        customText(text: "Log me in", fontSize: 15, textColor: AppColors.orange)
      ],
    );
