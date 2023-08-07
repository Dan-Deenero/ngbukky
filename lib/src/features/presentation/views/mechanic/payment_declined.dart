import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class PaymentDeclined extends StatelessWidget {
  const PaymentDeclined({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                height: 10.h,
                width: 10.w,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black),
                    color: AppColors.white.withOpacity(.5),
                    shape: BoxShape.circle),
                child: const Padding(
                  padding: EdgeInsets.only(left: 7.0),
                  child: Center(
                      child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.black,
                  )),
                ),
              ),
            ),
            customText(
                text: "Payment declined",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: AppColors.black),
            heightSpace(1),
            bodyText("View all payments declined by clients")
          ]),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 10.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                  trailing: Column(children: [
                    customText(
                        text: "N 5,050",
                        fontSize: 14,
                        textColor: AppColors.textGrey,
                        fontWeight: FontWeight.bold),
                    heightSpace(1),
                    Container(
                      width: 28.w,
                      height: 3.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.red.withOpacity(.3)),
                      child: Center(
                        child: customText(
                            text: "Payment declined",
                            fontSize: 10,
                            textColor: AppColors.red),
                      ),
                    )
                  ]),
                  subtitle: Row(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppImages.time),
                          customText(
                              text: "12:20pm",
                              fontSize: 10,
                              textColor: AppColors.textGrey)
                        ],
                      ),
                      widthSpace(2),
                      Row(
                        children: [
                          SvgPicture.asset(AppImages.calendarIcon),
                          customText(
                              text: "12 Jun 2023",
                              fontSize: 10,
                              textColor: AppColors.textGrey)
                        ],
                      )
                    ],
                  ),
                  title: customText(
                      text: "Kelechi Amadi",
                      fontSize: 16,
                      textColor: AppColors.black,
                      fontWeight: FontWeight.bold),
                  leading: Container(
                    width: 10.w,
                    height: 10.h,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.containerGrey),
                  )),
            ),
          ],
        ),
      )),
    );
  }
}
