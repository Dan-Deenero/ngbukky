import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/presentation/widgets/app_spacer.dart';

import 'custom_text.dart';

class AppButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onTap;
  const AppButton({super.key, required this.buttonText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: double.infinity,
          height: 7.h,
          decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customText(
                    text: buttonText, textColor: AppColors.white, fontSize: 14),
                widthSpace(2),
                const Icon(
                  Icons.arrow_forward,
                  color: AppColors.white,
                )
              ],
            ),
          )),
    );
  }
}
