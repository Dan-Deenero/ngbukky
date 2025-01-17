import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';

import 'custom_text.dart';

class AppButton extends StatelessWidget {
  final bool isActive;
  final String buttonText;
  final VoidCallback? onTap;
  final bool hasIcon;
  final bool isSmall;
  final bool isOrange;
  const AppButton({
    super.key,
    this.isActive = true,
    required this.buttonText,
    this.onTap,
    this.hasIcon = true,
    this.isSmall = false,
    this.isOrange = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !isActive ? null : onTap,
      child: Container(
        width: isSmall ? 225 : double.infinity,
        height: 7.h,
        decoration: BoxDecoration(
            color: (() {
              if (isActive) {
                if (isOrange) {
                  return AppColors.darkOrange;
                }
                return AppColors.normalBlue;
              }
              return AppColors.containerGrey;
            }()),
            borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customText(
                  text: buttonText, textColor: AppColors.white, fontSize: 14),
              widthSpace(2),
              hasIcon
                  ? const Icon(
                      Icons.arrow_forward,
                      color: AppColors.white,
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
