import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class AlertDialogue extends StatelessWidget {
  final String title;
  final String subtitle;
  final TextEditingController service;
  final TextEditingController cost;
  final String content;
  final String action;
  final VoidCallback fction;
  final VoidCallback? cancel;

  const AlertDialogue(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.service,
      required this.cost,
      required this.content,
      required this.action,
      required this.fction,
      this.cancel});
  // static final service = TextEditingController();
  // static final cost = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // Adjust the radius as needed
      ),
      contentPadding: const EdgeInsets.all(20.0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customText(
                text: title,
                fontSize: 24,
                textColor: AppColors.black,
                fontWeight: FontWeight.w700),
            InkWell(
                onTap: cancel,
                child: SvgPicture.asset(AppImages.cancelModal))
          ],
        ),
        heightSpace(1),
        customText(
            text: subtitle,
            fontSize: 12,
            textColor: AppColors.black),
        heightSpace(2),
        modalForm('Air conditioning', service, 4),
        heightSpace(1),
        modalForm('Enter your service cost (₦)', cost, 1),
        heightSpace(1),
        Row(
          children: [
            SvgPicture.asset(AppImages.warning),
            widthSpace(2),
            Flexible(
              child: customText(
                  text:
                      content,
                  fontSize: 11,
                  textColor: AppColors.textGrey),
            )
          ],
        ),
        heightSpace(2),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () => context.pop(),
                  child: customText(
                      text: 'cancel',
                      fontSize: 16,
                      textColor: AppColors.textGrey)),
              Container(
                width: 1,
                height: 40,
                color: AppColors.containerGrey,
              ),
              TextButton(
                  onPressed: fction,
                  child: customText(
                      text: action,
                      fontSize: 16,
                      textColor: AppColors.darkOrange))
            ],
          ),
        )
      ],
    );
  }

  TextFormField modalForm(String hint, TextEditingController control, int line) {
    return TextFormField(
      controller: control,
      maxLines: line,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textformGrey),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textformGrey),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textformGrey),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        contentPadding: const EdgeInsets.only(left: 10, top: 10),
        errorStyle: const TextStyle(fontSize: 14),
        
      ),
    );
  }
}
