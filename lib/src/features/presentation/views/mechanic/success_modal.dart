import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class SuccessDialogue extends StatelessWidget {
  String title;
  String subtitle;
  VoidCallback action;

  SuccessDialogue(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.action});
  // static final service = TextEditingController();
  // static final cost = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // Adjust the radius as needed
      ),
      contentPadding: const EdgeInsets.all(16.0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [         
            InkWell(
                onTap: action,
                child: SvgPicture.asset(AppImages.cancelModal))
          ],
        ),
        // heightSpace(1),
        SvgPicture.asset(AppImages.successModal),
        customText(
            text: title,
            fontSize: 24,
            textColor: AppColors.black,
            fontWeight: FontWeight.w600,
            textAlignment: TextAlign.center),
        heightSpace(1),
        customText(
            text: subtitle,
            fontSize: 12,
            textColor: AppColors.black,
            textAlignment: TextAlign.center),
        heightSpace(2),
        AppButton(buttonText: 'Ok, thanks',hasIcon: false, onTap: action,),
        heightSpace(2),
      ],
    );
  }
}
