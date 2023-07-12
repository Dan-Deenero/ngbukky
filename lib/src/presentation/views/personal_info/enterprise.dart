import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/presentation/widgets/custom_text.dart';

import '../../../config/keys/app_routes.dart';
import '../../../core/shared/colors.dart';
import '../../widgets/app_phone_field.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({super.key});

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
                          text: "Personal information",
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
                    label: "First name",
                    hintText: "John",
                  ),
                  heightSpace(2),
                  const CustomTextFormField(
                    label: "Last name",
                    hintText: "Doe",
                  ),
                  heightSpace(2),
                  const CustomTextFormField(
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
                      const CustomTextFormField(
                        label: "What kind of mechanic are you?",
                        hintText: "Diesel mechanic, auto electrician etc",
                      ),
                      heightSpace(2),
                      const CustomTextFormField(
                        label: "Select languages",
                        hintText: "What languages do you speak?",
                      ),
                      heightSpace(2),
                      const CustomTextFormField(
                        label: "Tell us little about yourself",
                        hasMaxline: true,
                      ),
                      heightSpace(3),
                      AppButton(
                        onTap: () => context.push(AppRoutes.businessInfo),
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
