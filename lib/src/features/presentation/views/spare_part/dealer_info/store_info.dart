import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/user_model.dart';
import 'package:ngbuka/src/domain/repository/auth_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_phone_field.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/features/presentation/widgets/dropdown_search.dart';
import 'package:ngbuka/src/utils/helpers/validators.dart';



class SpareStoreInfo extends HookWidget {
  static final _formKey = GlobalKey<FormState>();
  static final storeName = TextEditingController();
  static final phone = TextEditingController();
  static final email = TextEditingController();
  const SpareStoreInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = useState<bool>(false);
    final userModel = useState<UserModel?>(null);
    final isValidated = useState<bool>(false);
    
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              onChanged: () =>
                  isValidated.value = _formKey.currentState!.validate(),
              key: _formKey,
              child: Column(
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
                                text:
                                    "Help us complete these info and get started",
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
                                  text: "Store Info",
                                  fontSize: 18,
                                  textColor: AppColors.primary,
                                  fontWeight: FontWeight.w800
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 10.w,
                                    height: 10.h,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: AppColors.green),
                                        shape: BoxShape.circle,
                                        color: AppColors.lightgreen),
                                    child: Center(
                                        child: customText(
                                            text: "1",
                                            fontSize: 15,
                                            textColor: AppColors.green)),
                                  ),
                                  const SizedBox(
                                      width: 20,
                                      child: Divider(
                                        height: 2,
                                        color:
                                            Color.fromARGB(255, 131, 130, 133),
                                      )),
                                  Container(
                                    width: 10.w,
                                    height: 10.h,
                                    decoration: BoxDecoration(
                                      border:
                                            Border.all(color: AppColors.veryLightOrange),
                                        shape: BoxShape.circle,
                                        color: AppColors.white),
                                    child: Center(
                                        child: customText(
                                            text: "2",
                                            fontSize: 15,
                                            textColor: AppColors.textGrey)),
                                  ),
                                  const SizedBox(
                                      width: 20,
                                      child: Divider(
                                        height: 2,
                                        color:
                                            Color.fromARGB(255, 131, 130, 133),
                                      )),
                                  Container(
                                    width: 10.w,
                                    height: 10.h,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.white),
                                    child: Center(
                                        child: customText(
                                            text: "3",
                                            fontSize: 15,
                                            textColor: const  Color.fromARGB(255, 131, 130, 133))),
                                  ),
                                ],
                              )
                            ],
                          ),
                          heightSpace(2),
                          customText(
                            text: 'This is information about your store and the manager/handler', 
                            fontSize: 14, 
                            textColor: AppColors.textColor
                          ),
                          heightSpace(2),
                          CustomTextFormField(
                            validator: stringValidation,
                            textEditingController: storeName,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: SvgPicture.asset(
                                AppImages.nameIcon,
                              ),
                            ),
                            label: "Store name",
                            hintText: "Type in your store name",
                          ),
                          
                          heightSpace(2),
                          CustomTextFormField(
                            textEditingController: email,
                            validator: emailValidation,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: SvgPicture.asset(
                                AppImages.emailIcon,
                              ),
                            ),
                            label: "Store email",
                            hintText: "Type in your store email",
                          ),
                          heightSpace(2),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText(
                                  text: "Store number",
                                  fontSize: 14,
                                  textColor: AppColors.primary),
                              heightSpace(1),
                              CustomPhoneField(
                                controller: phone,
                              ),                             
                              heightSpace(2),
                              CustomTextFormField(
                                textEditingController: email,
                                validator: emailValidation,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: SvgPicture.asset(
                                    AppImages.locationIcon,
                                  ),
                                ),
                                label: "Store address",
                                hintText: "Select location",
                              ),
                              heightSpace(2),
                              Padding(
                                padding: const EdgeInsets.only(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        
                                      },
                                      child: Row(
                                        children: [
                                          customText(
                                              text: 'Use my present location', 
                                              fontSize: 14, textColor: 
                                              AppColors.orange, 
                                              textAlignment: TextAlign.right,
                                          ),
                                          SvgPicture.asset(AppImages.googleText),
                                          widthSpace(1),
                                          SvgPicture.asset(AppImages.googleLocs),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              heightSpace(3),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    child: AppButton(
                                      isActive: isValidated.value,
                                      // onTap: updateInfo,
                                      buttonText: "Save",
                                      isOrange: true,
                                      isSmall: true,
                                    ),
                                  ),
                                  widthSpace(2),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        customText(
                                            text: "Next",
                                            fontSize: 15,
                                            textColor: AppColors.textGrey),
                                        widthSpace(4),
                                        GestureDetector(
                                          onTap: () => context
                                              .push(AppRoutes.spareBusinessInfo),
                                          child: Container(
                                            height: 13.h,
                                            width: 13.w,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors.textGrey),
                                                color: AppColors.white
                                                    .withOpacity(.5),
                                                shape: BoxShape.circle),
                                            child: const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 7.0),
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
                              heightSpace(2),
                              Row(
                                children: [
                                  SvgPicture.asset(AppImages.info),
                                  widthSpace(2),
                                  Flexible(
                                    child: bodyText(
                                        "You can always edit every information entered and saved later if you want"),
                                  )
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
            ),
    );
  }

}