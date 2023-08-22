import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/domain/data/user_model.dart';
import 'package:ngbuka/src/domain/repository/auth_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/features/presentation/widgets/dropdown_search.dart';
import 'package:ngbuka/src/utils/helpers/validators.dart';

import '../../../../config/keys/app_routes.dart';
import '../../../../core/shared/colors.dart';

class PersonalInfoPage extends HookWidget {
  static final AuthRepo _authRepo = AuthRepo();
  static final firstName = TextEditingController();
  static final lastName = TextEditingController();
  static final mechanicType = TextEditingController();
  static final phone = TextEditingController();
  static final description = TextEditingController();
  static final otherLanguages = TextEditingController();
  static List<String> languages = [];
  static final _formKey = GlobalKey<FormState>();
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = useState<bool>(true);
    final userModel = useState<UserModel?>(null);
    final isValidated = useState<bool>(false);
    getUserProfile() {
      _authRepo.getMechanicProfile().then((value) {
        isLoading.value = false;
        userModel.value = value;
        firstName.text = value.firstname!;
        lastName.text = value.lastname!;
      });
    }

    onChanged(List<String>? list) {
      languages = list!;
      log(languages.toString());
    }

    List<String> otherLang = otherLanguages.text.split(',');

    updateInfo() async {
      var body = {
        "firstname": firstName.text,
        "lastname": lastName.text,
        "mechanicType": mechanicType.text,
        "about": description.text,
        "languages": languages + otherLang,
      };
      bool result = await _authRepo.updateInfo(body);
      if (result) {
        if (context.mounted) {
          context.push(AppRoutes.businessInfo);
        }
      }
    }

    useEffect(() {
      getUserProfile();
      return null;
    }, []);
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
                                  text: "Personal information",
                                  fontSize: 18,
                                  textColor: AppColors.primary),
                              Row(
                                children: [
                                  Container(
                                    width: 10.w,
                                    height: 10.h,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: AppColors.orange),
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
                            validator: stringValidation,
                            textEditingController: firstName,
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
                            validator: stringValidation,
                            textEditingController: lastName,
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
                          // CustomTextFormField(
                          //   textEditingController: email,
                          //   prefixIcon: Padding(
                          //     padding: const EdgeInsets.all(13.0),
                          //     child: SvgPicture.asset(
                          //       AppImages.emailIcon,
                          //     ),
                          //   ),
                          //   label: "Personal email",
                          //   hintText: "johndoe@gmail.com",
                          // ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // customText(
                              //     text: "Phone number",
                              //     fontSize: 14,
                              //     textColor: AppColors.primary),
                              // heightSpace(2),
                              // CustomPhoneField(
                              //   controller: phone,
                              // ),
                              heightSpace(2),
                              CustomTextFormField(
                                textEditingController: mechanicType,
                                validator: stringValidation,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: SvgPicture.asset(
                                    AppImages.mechanicIcon,
                                  ),
                                ),
                                label: "What kind of mechanic are you?",
                                hintText:
                                    "Diesel mechanic, auto electrician etc",
                              ),
                              heightSpace(2),
                              customText(
                                  text: 'Select languages',
                                  fontSize: 14,
                                  textColor: AppColors.primary),
                              heightSpace(1),
                              AppDropdDownSearch(
                                hintText: "What languages do you speak?",
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: SvgPicture.asset(
                                    AppImages.languageIcon,
                                  ),
                                ),
                                selectedItems: const [
                                  'None',
                                  'Hausa',
                                  'Igbo',
                                  'Yoruba',
                                  'Pidgin',
                                ],
                                onChanged: onChanged,
                              ),
                              heightSpace(2),

                              CustomTextFormField(
                                textEditingController: otherLanguages,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: SvgPicture.asset(
                                    AppImages.languageIcon,
                                  ),
                                ),
                                label: "What other languages",
                                hintText: "Separate with a comma",
                              ),
                              heightSpace(2),
                              CustomTextFormField(
                                validator: stringValidation,
                                label: "Tell us little about yourself",
                                hasMaxline: true,
                                textEditingController: description,
                              ),
                              heightSpace(3),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppButton(
                                    isActive: isValidated.value,
                                    onTap: updateInfo,
                                    buttonText: "Save",
                                    isOrange: true,
                                    isSmall: true,
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
                                              .push(AppRoutes.businessInfo),
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
