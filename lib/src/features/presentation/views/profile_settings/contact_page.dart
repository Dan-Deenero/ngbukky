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
import 'package:ngbuka/src/features/presentation/widgets/app_phone_field.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/features/presentation/widgets/dropdown_search.dart';
import 'package:ngbuka/src/utils/helpers/validators.dart';

import '../../../../config/keys/app_routes.dart';
import '../../../../core/shared/colors.dart';

class ContactPage extends HookWidget {
  static final AuthRepo _authRepo = AuthRepo();
  static final firstName = TextEditingController();
  static final lastName = TextEditingController();
  static final email = TextEditingController();
  static final mechanicType = TextEditingController();
  static final phone = TextEditingController();
  static final body = TextEditingController();
  static final title = TextEditingController();
  static final _formKey = GlobalKey<FormState>();
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = useState<bool>(true);
    final userModel = useState<UserModel?>(null);
    final isValidated = useState<bool>(false);
    getUserProfile() {
      _authRepo.getMechanicProfile().then((value) {
        String phoneStr = value.phoneNumber.toString();
        String updatedStr = phoneStr.substring(3);
        // int updatedNumber = int.parse(updatedStr);
        isLoading.value = false;
        userModel.value = value;
        firstName.text = value.firstname!;
        lastName.text = value.lastname!;
        mechanicType.text = value.mechanicType!;
        phone.text = updatedStr;
        email.text = value.email!;
      });
    }

    updateInfo() async {
      var body = {
        "firstname": firstName.text,
        "lastname": lastName.text,
        "mechanicType": mechanicType.text,
      };
      bool result = await _authRepo.updateInfo(body);
      if (result) {
        if (context.mounted) {
          context.push(AppRoutes.profileSettings);
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
                                text: "Contact us",
                                fontSize: 20,
                                textColor: AppColors.white),
                            heightSpace(1),
                            customText(
                                text:
                                    "For questions, suggestions and inquiries",
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
                          heightSpace(4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText(
                                  text: "Send us an email ",
                                  fontSize: 18,
                                  textColor: AppColors.primary,
                                  fontWeight: FontWeight.w800),
                            ],
                          ),
                          heightSpace(3),
                          CustomTextFormField(
                            validator: stringValidation,
                            textEditingController: title,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: SvgPicture.asset(
                                AppImages.nameIcon,
                              ),
                            ),
                            label: "Title",
                            hintText: "Enter Short title here",
                          ),
                          heightSpace(2),
                          CustomTextFormField(
                            validator: stringValidation,
                            label: "Body",
                            hasMaxline: true,
                            textEditingController: body,
                            hintText: 'Type fully what you want to tell us',
                          ),
                          heightSpace(4),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AbsorbPointer(
                                absorbing: true,
                                child: Opacity(
                                  opacity: 0.2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
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
                                      customText(
                                          text: "Phone number",
                                          fontSize: 14,
                                          textColor: AppColors.primary),
                                      heightSpace(1),
                                      CustomPhoneField(
                                        controller: phone,
                                      ),
                                      heightSpace(2),
                                      CustomTextFormField(
                                        textEditingController: email,
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(13.0),
                                          child: SvgPicture.asset(
                                            AppImages.emailIcon,
                                          ),
                                        ),
                                        label: "Personal email",
                                        hintText: "johndoe@gmail.com",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              heightSpace(5),
                              Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.87,
                                    child: AppButton(
                                      // isActive: isValidated.value,
                                      onTap: updateInfo,
                                      buttonText: "Save",
                                      isOrange: true,
                                      isSmall: true,
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
