import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class QuoteRequest extends StatefulWidget {
  final String id;
  const QuoteRequest({super.key, required this.id});

  @override
  State<QuoteRequest> createState() => _QuoteRequestState();
}

class _QuoteRequestState extends State<QuoteRequest> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
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
            customText(
                text: "Quote Request",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: AppColors.black),
            heightSpace(1),
            bodyText("Accept or reject quote")
          ]),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: SvgPicture.asset(AppImages.profile),
              title: customText(
                  text: "Kelechi Amadi",
                  fontSize: 15,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.bold),
              subtitle: customText(
                  text: "Client name",
                  fontSize: 12,
                  textColor: AppColors.textGrey),
            ),
            heightSpace(1),
            ListTile(
              leading: SvgPicture.asset(AppImages.locationIcon),
              title: customText(
                  text: "Elijiji rd, close 20, Woji, Port Harcourt",
                  fontSize: 15,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.bold),
              subtitle: customText(
                  text: "Location",
                  fontSize: 12,
                  textColor: AppColors.textGrey),
            ),
            heightSpace(1),
            ListTile(
              leading: SvgPicture.asset(AppImages.calendarIcon),
              title: customText(
                  text: "AC Maintenance",
                  fontSize: 15,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.bold),
              subtitle: customText(
                  text: "service selected",
                  fontSize: 12,
                  textColor: AppColors.textGrey),
            ),
            heightSpace(1),
            ListTile(
              leading: SvgPicture.asset(AppImages.carIcon),
              title: customText(
                  text: "Toyota",
                  fontSize: 15,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.bold),
              subtitle: customText(
                  text: "Car brand",
                  fontSize: 12,
                  textColor: AppColors.textGrey),
            ),
            heightSpace(1),
            ListTile(
              leading: SvgPicture.asset(AppImages.calendarIcon),
              title: customText(
                  text: "Camry Hybrid 2022",
                  fontSize: 15,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.bold),
              subtitle: customText(
                  text: "car model",
                  fontSize: 12,
                  textColor: AppColors.textGrey),
            ),
            heightSpace(1),
            ListTile(
              leading: SvgPicture.asset(AppImages.time),
              title: customText(
                  text: "2022",
                  fontSize: 15,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.bold),
              subtitle: customText(
                  text: "Year of manufacture",
                  fontSize: 12,
                  textColor: AppColors.textGrey),
            ),
            heightSpace(2),
            const Divider(),
            heightSpace(2),
            Row(
              children: [
                SvgPicture.asset(AppImages.warning),
                widthSpace(2),
                Flexible(
                  child: customText(
                      text:
                          "For your own safety, all transactions should be done in the Ngbuka application.",
                      fontSize: 12,
                      textColor: AppColors.orange),
                )
              ],
            ),
            heightSpace(2),
            Row(
              children: [
                Container(
                  width: 30.w,
                  height: 7.h,
                  decoration: BoxDecoration(
                      color: AppColors.containerGrey,
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                      child: customText(
                          text: "Reject",
                          fontSize: 15,
                          textColor: AppColors.black)),
                ),
                widthSpace(2),
                Expanded(
                  child: InkWell(
                    onTap: () => context.push(AppRoutes.sendQuotes),
                    child: const AppButton(
                      hasIcon: false,
                      buttonText: "Accept request",
                      isOrange: true,
                    ),
                  ),
                )
              ],
            ),
            heightSpace(2)
          ],
        ),
      )),
    );
  }
}
