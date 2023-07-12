import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/presentation/widgets/custom_text.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(
                    text: "Good moring, Damini",
                    fontSize: 18,
                    textColor: AppColors.black),
                SvgPicture.asset(AppImages.notification)
              ],
            ),
            bodyText("Great way to start your day "),
            heightSpace(2),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              height: 30.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                      image: AssetImage(AppImages.homeBackground))),
              child: Column(children: [
                customText(
                    text: "Your income",
                    fontSize: 17,
                    textColor: AppColors.white),
                customText(
                    text: "0",
                    fontSize: 50,
                    textColor: AppColors.white,
                    fontWeight: FontWeight.bold),
                customText(
                    text: "Naira", fontSize: 17, textColor: AppColors.white),
                heightSpace(2),
                SvgPicture.asset(AppImages.welcomeImage)
              ]),
            ),
            heightSpace(2),
            SizedBox(
              height: 20.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [transactionBox(), transactionBox()],
              ),
            ),
            heightSpace(2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(
                    text: "New inspection booking",
                    fontSize: 15,
                    textColor: AppColors.primary),
                Row(
                  children: [
                    customText(
                        text: "See all",
                        fontSize: 15,
                        textColor: AppColors.primary),
                    const Icon(Icons.arrow_forward)
                  ],
                )
              ],
            ),
            heightSpace(4),
            Center(
              child: SvgPicture.asset(AppImages.noBooking),
            ),
            heightSpace(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(
                    text: "New Quote",
                    fontSize: 15,
                    textColor: AppColors.primary),
                Row(
                  children: [
                    customText(
                        text: "See all",
                        fontSize: 15,
                        textColor: AppColors.primary),
                    const Icon(Icons.arrow_forward)
                  ],
                )
              ],
            ),
            heightSpace(4),
            Center(
              child: SvgPicture.asset(AppImages.noQuote),
            ),
            heightSpace(4),
            customText(
                text: "Recent activities",
                fontSize: 15,
                textColor: AppColors.primary),
          ],
        ),
      )),
    );
  }

  Widget transactionBox() => Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: const BoxDecoration(
            border: Border(
                right: BorderSide(width: 2, color: AppColors.borderGrey))),
        child: Column(children: [
          customText(
              text: "Earnings", fontSize: 12, textColor: AppColors.textColor),
          heightSpace(2),
          customText(text: "N0k", fontSize: 30, textColor: AppColors.black),
          heightSpace(2),
          Container(
            width: 35.w,
            height: 4.h,
            decoration: BoxDecoration(
                color: AppColors.containerGrey,
                borderRadius: BorderRadius.circular(10)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              customText(text: "+0%", fontSize: 12, textColor: AppColors.green),
              widthSpace(1),
              customText(
                  text: "Since last month",
                  fontSize: 12,
                  textColor: AppColors.black),
            ]),
          )
        ]),
      );
}
