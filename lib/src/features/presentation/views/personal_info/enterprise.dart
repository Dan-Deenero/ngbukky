import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

import '../../../../config/keys/app_routes.dart';
import '../../../../core/shared/colors.dart';
import '../../widgets/app_phone_field.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Column(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              height: 25.h,
              decoration: const BoxDecoration(
                  color: AppColors.orange,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          text: "Personal information",
                          fontSize: 18,
                          textColor: AppColors.primary),
                      Row(
                        children: [
                          Container(
                            width: 10.w,
                            height: 10.h,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.orange),
                                shape: BoxShape.circle,
                                color: AppColors.white),
                            child: Center(
                                child: customText(
                                    text: "1",
                                    fontSize: 15,
                                    textColor: AppColors.black)),
                          ),
                          const SizedBox(
                              width: 30,
                              child: Divider(
                                height: 2,
                                color: Color.fromARGB(255, 131, 130, 133),
                              )),
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
                  CustomTextFormField(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: SvgPicture.asset(
                        AppImages.nameIcon,
                      ),
                    ),
                    label: "First name",
                    hintText: "John",
                  ),
                  heightSpace(2),
                  CustomTextFormField(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: SvgPicture.asset(
                        AppImages.nameIcon,
                      ),
                    ),
                    label: "Last name",
                    hintText: "Doe",
                  ),
                  heightSpace(2),
                  CustomTextFormField(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: SvgPicture.asset(
                        AppImages.emailIcon,
                      ),
                    ),
                    label: "Personal email",
                    hintText: "johndoe@gmail.com",
                  ),
                  heightSpace(2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                          text: "Phone number",
                          fontSize: 14,
                          textColor: AppColors.primary),
                      heightSpace(2),
                      const CustomPhoneField(),
                      heightSpace(2),
                      CustomTextFormField(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: SvgPicture.asset(
                            AppImages.mechanicIcon,
                          ),
                        ),
                        label: "What kind of mechanic are you?",
                        hintText: "Diesel mechanic, auto electrician etc",
                      ),
                      heightSpace(2),
                      CustomTextFormField(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: SvgPicture.asset(
                            AppImages.languageIcon,
                          ),
                        ),
                        label: "Select languages",
                        hintText: "What languages do you speak?",
                      ),
                      heightSpace(2),
                      const CustomTextFormField(
                        label: "Tell us little about yourself",
                        hasMaxline: true,
                      ),
                      heightSpace(3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppButton(
                            onTap: () => context.push(AppRoutes.businessInfo),
                            buttonText: "Save",
                            isOrange: true,
                            isSmall: true,
                          ),
                          widthSpace(5),
                          Expanded(
                            child: Row(
                              children: [
                                customText(
                                    text: "Next",
                                    fontSize: 15,
                                    textColor: AppColors.textGrey),
                                widthSpace(4),
                                GestureDetector(
                                  onTap: () =>
                                      context.push(AppRoutes.businessInfo),
                                  child: Container(
                                    height: 13.h,
                                    width: 13.w,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.textGrey),
                                        color: AppColors.white.withOpacity(.5),
                                        shape: BoxShape.circle),
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 7.0),
                                      child: Center(
                                          child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: AppColors.textGrey,
                                      )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
