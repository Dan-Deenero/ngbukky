import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class BookingAlert extends StatelessWidget {
  const BookingAlert({super.key});

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
                text: "New booking alerts",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: AppColors.black),
            heightSpace(1),
            bodyText("View, accept or reject booking")
          ]),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Wrap(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                width: 68.w,
                height: 25.h,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(children: [
                            const Icon(Icons.person),
                            heightSpace(10),
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 11.w,
                              height: 7.h,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.orange.withOpacity(.2)),
                              child: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: SvgPicture.asset(
                                  AppImages.badIcon,
                                  width: 10,
                                  height: 10,
                                  color: AppColors.lightOrange,
                                ),
                              ),
                            )
                          ]),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText(
                                  text: "Kelechi Amadi",
                                  fontSize: 15,
                                  textColor: AppColors.normalBlue,
                                  fontWeight: FontWeight.bold),
                              heightSpace(1),
                              customText(
                                  text: "081212345678",
                                  fontSize: 14,
                                  textColor: AppColors.textGrey),
                              heightSpace(1),
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: AppColors.green,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                      child: customText(
                                          text: "New",
                                          fontSize: 12,
                                          textColor: AppColors.white),
                                    ),
                                  ),
                                  widthSpace(1),
                                  customText(
                                      text: "Booking request",
                                      fontSize: 12,
                                      textColor: AppColors.black)
                                ],
                              ),
                              heightSpace(1),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              heightSpace(2),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () => context
                                        .push(AppRoutes.inspectionBooking),
                                    child: Container(
                                        width: 20.w,
                                        height: 5.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: AppColors.backgroundGrey),
                                        child: Center(
                                          child: customText(
                                              text: "View",
                                              fontSize: 14,
                                              textColor: AppColors.black),
                                        )),
                                  ),
                                  widthSpace(2),
                                  Container(
                                      width: 20.w,
                                      height: 5.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: AppColors.backgroundGrey),
                                      child: Center(
                                        child: customText(
                                            text: "Accept",
                                            fontSize: 14,
                                            textColor: AppColors.black),
                                      )),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ]),
              ),
            ],
          )
        ],
      )),
    );
  }
}
