import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class SpareHistoryDetail extends StatelessWidget {
  const SpareHistoryDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(25.h),
          child: Container(
            height: 130,
            decoration: BoxDecoration(color: AppColors.green.withOpacity(0.1)),
            child: Padding(
              padding: const EdgeInsets.only(right: 20, top: 40),
              child: GestureDetector(
                onTap: () => context.pop(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.black)),
                      child: Center(child: SvgPicture.asset(AppImages.badIcon)),
                    ),
                  ],
                ),
              ),
            ),
          )),
      backgroundColor: AppColors.backgroundGrey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(
              height: 0,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration:
                  BoxDecoration(color: AppColors.green.withOpacity(0.1)),
              child: Column(
                children: [
                  SvgPicture.asset(AppImages.successModal),
                  heightSpace(1.5),
                  customText(
                      text: "N5,050",
                      fontSize: 24,
                      textColor: AppColors.green,
                      fontWeight: FontWeight.bold),
                  heightSpace(2),
                  customText(
                      text: "Booking Completed  - Paid🎉",
                      fontSize: 14,
                      textColor: AppColors.green),
                  heightSpace(1),
                  customText(
                    text: "Booking status",
                    fontSize: 12,
                    textColor: AppColors.textGrey,
                  ),
                  heightSpace(1),
                  customText(
                    text: "Receipt no: 234",
                    fontSize: 12,
                    textColor: AppColors.black,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                      text: "Personal",
                      fontSize: 14,
                      textColor: AppColors.orange,
                      fontWeight: FontWeight.bold),
                  heightSpace(1),
                  ListTile(
                    leading: SvgPicture.asset(AppImages.profile),
                    title: customText(
                        text: 'Kels2323',
                        fontSize: 14,
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
                        text: 'Elijiji rd, close 20, Woji, Port Harcourt',
                        fontSize: 14,
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
                        text: 'Toyota',
                        fontSize: 14,
                        textColor: AppColors.black,
                        fontWeight: FontWeight.bold),
                    subtitle: customText(
                        text: 'Car brand',
                        fontSize: 12,
                        textColor: AppColors.textGrey),
                  ),
                  ListTile(
                    leading: SvgPicture.asset(AppImages.calendarIcon),
                    title: customText(
                        text: "Camry Hybrid 2022",
                        fontSize: 14,
                        textColor: AppColors.black,
                        fontWeight: FontWeight.bold),
                    subtitle: customText(
                        text: 'Car model',
                        fontSize: 12,
                        textColor: AppColors.textGrey),
                  ),
                  heightSpace(1),
                  ListTile(
                    leading: SvgPicture.asset(AppImages.carIcon),
                    title: customText(
                        text: '2022',
                        fontSize: 14,
                        textColor: AppColors.black,
                        fontWeight: FontWeight.bold),
                    subtitle: customText(
                        text: "Year of manufacture",
                        fontSize: 12,
                        textColor: AppColors.textGrey),
                  ),
                  const Divider(),
                  customText(
                      text: "Service rendered",
                      fontSize: 14,
                      textColor: AppColors.orange,
                      fontWeight: FontWeight.bold),
                  heightSpace(3),
                  Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppImages.serviceIcon),
                          widthSpace(2),
                          customText(
                              text: 'AC Maintenance',
                              fontSize: 13,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.w600),
                          heightSpace(4),
                        ],
                      ),
                      heightSpace(2),
                      Row(
                        children: [
                          SvgPicture.asset(AppImages.serviceIcon),
                          widthSpace(2),
                          customText(
                              text: 'Electrical Repair',
                              fontSize: 13,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.w600),
                          heightSpace(4),
                        ],
                      ),
                    ],
                  ),
                  heightSpace(1),
                  const Divider(),
                  heightSpace(1),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText(
                              text: 'Sub-total (₦)',
                              fontSize: 13,
                              textColor: AppColors.black),
                          customText(
                              text: '5,000.00',
                              fontSize: 13,
                              textColor: AppColors.black)
                        ],
                      ),
                      heightSpace(2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText(
                              text: 'Ngbuka Charge (1%)',
                              fontSize: 13,
                              textColor: AppColors.black),
                          customText(
                              text: '50.00',
                              fontSize: 13,
                              textColor: AppColors.black)
                        ],
                      ),
                      heightSpace(2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText(
                              text: 'Total',
                              fontSize: 13,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.w600),
                          customText(
                              text: '5,050.00',
                              fontSize: 13,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.w600)
                        ],
                      )
                    ],
                  ),
                  heightSpace(3),
                  const Divider(),
                  heightSpace(3),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 3,
                            height: 7.h,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.0, color: AppColors.textGrey),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                customText(
                                  text: "Download",
                                  fontSize: 15,
                                  textColor: AppColors.orange,
                                ),
                                widthSpace(2),
                                SvgPicture.asset(AppImages.download)
                              ],
                            ),
                          ),
                        ),
                      ),
                      widthSpace(4),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 30.w,
                            height: 7.h,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.0, color: AppColors.textGrey),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                customText(
                                  text: "Share",
                                  fontSize: 15,
                                  textColor: AppColors.orange,
                                ),
                                widthSpace(2),
                                SvgPicture.asset(AppImages.share)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
