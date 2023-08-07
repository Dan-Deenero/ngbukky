import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

import '../../../../core/shared/colors.dart';

class SendQuote extends StatelessWidget {
  const SendQuote({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(16.h),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(
                    text: "Send Quote",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.black),
                Container(
                  height: 10.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.black),
                      color: AppColors.white.withOpacity(.5),
                      shape: BoxShape.circle),
                  child: Center(child: SvgPicture.asset(AppImages.badIcon)),
                ),
              ],
            ),
            bodyText("Let the client know what it will cost")
          ]),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText(
                text: "Select from your services",
                fontSize: 14,
                textColor: AppColors.black),
            heightSpace(1),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              height: 6.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.h),
                  border: Border.all(color: AppColors.borderGrey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(AppImages.serviceIcon),
                  customText(
                      text: "Select services and price",
                      fontSize: 12,
                      textColor: AppColors.textformGrey),
                  const Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
            heightSpace(2),
            customText(
                text: "Not listed?", fontSize: 15, textColor: AppColors.orange),
            heightSpace(2),
            const CustomTextFormField(
              label: "Enter amount (N)",
              hintText: "e.g 1,000",
              hasMaxline: true,
            )
          ],
        ),
      )),
    );
  }
}
