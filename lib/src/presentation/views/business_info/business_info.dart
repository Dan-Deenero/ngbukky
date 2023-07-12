import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/presentation/widgets/custom_text.dart';

import '../../../core/shared/colors.dart';
import '../../widgets/app_phone_field.dart';

class BusinessInfoPage extends StatelessWidget {
  const BusinessInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            height: 25.h,
            decoration: const BoxDecoration(
                color: AppColors.orange,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 10.h,
                width: 10.w,
                decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(.5),
                    shape: BoxShape.circle),
                child: const Padding(
                  padding: EdgeInsets.only(left: 7.0),
                  child: Center(
                      child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.white,
                  )),
                ),
              ),
              heightSpace(1),
              customText(
                  text: "Enterprise entity",
                  fontSize: 20,
                  textColor: AppColors.white),
              heightSpace(1),
              customText(
                  text: "Help us complete these info and get started",
                  fontSize: 15,
                  textColor: AppColors.white),
            ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  heightSpace(2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                          text: "Business information",
                          fontSize: 18,
                          textColor: AppColors.primary),
                      Row(
                        children: [
                          Container(
                            width: 10.w,
                            height: 10.h,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: AppColors.white),
                            child: Center(
                                child: customText(
                                    text: "1",
                                    fontSize: 15,
                                    textColor: AppColors.black)),
                          ),
                          widthSpace(8),
                          Container(
                            width: 10.w,
                            height: 10.h,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: AppColors.white),
                            child: Center(
                                child: customText(
                                    text: "2",
                                    fontSize: 15,
                                    textColor: AppColors.textGrey)),
                          ),
                        ],
                      )
                    ],
                  ),
                  heightSpace(2),
                  const CustomTextFormField(
                    label: "Business name",
                    hintText: "What is the name of your business",
                  ),
                  heightSpace(2),
                  const CustomTextFormField(
                    label: "Location of your business",
                    hintText: "Enter location",
                  ),
                  heightSpace(2),
                  const CustomTextFormField(
                    label: "Business email (optional)",
                    hintText: "johndoe@gmail.com",
                  ),
                  heightSpace(2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                          text: "Business phone no (optional)",
                          fontSize: 14,
                          textColor: AppColors.primary),
                      heightSpace(2),
                      const CustomPhoneField(),
                      heightSpace(2),
                      const CustomTextFormField(
                        label: "What are you familiar with?",
                        hintText: "Select cars",
                      ),
                      heightSpace(2),
                      const CustomTextFormField(
                        label: "List of services",
                        hintText: "Select your list of services",
                      ),
                      heightSpace(4),
                      customText(
                          text: "Availabiity",
                          fontSize: 17,
                          textColor: AppColors.black),
                      heightSpace(2),
                      const CustomTextFormField(
                        label: "Working hours",
                        hintText: "Set working hours",
                      ),
                      heightSpace(3),
                      AppButton(
                        onTap: () => context.push(AppRoutes.bottomNav),
                        buttonText: "Save",
                        isOrange: true,
                        isSmall: true,
                      ),
                      heightSpace(3),
                    ],
                  )
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
