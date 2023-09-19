import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/domain/data/user_model.dart';
import 'package:ngbuka/src/domain/repository/auth_repository.dart';
import 'package:ngbuka/src/features/presentation/views/main_auth/new_password.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_dropdown.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/utils/helpers/validators.dart';

import '../../../../config/keys/app_routes.dart';
import '../../../../core/shared/colors.dart';

class AddWalletPage extends HookWidget {
  static final accountNumber = TextEditingController();
  static final password = TextEditingController();
  static final bankController= TextEditingController();

  static final _formKey = GlobalKey<FormState>();
  late String selectedAccount;
  final List<String> bankNames = [
    'Access Bank',
    'Zenith Bank',
    'First Bank of Nigeria',
    'Guaranty Trust Bank (GTBank)',
    'United Bank for Africa (UBA)',
    'Fidelity Bank',
    'Ecobank Nigeria',
    'Union Bank of Nigeria',
    'Sterling Bank',
    'Stanbic IBTC Bank',
    'Wema Bank',
    'Heritage Bank',
    'First City Monument Bank (FCMB)',
    'Keystone Bank',
    'Polaris Bank',
    'Unity Bank',
    'Jaiz Bank',
    'SunTrust Bank',
    'Titan Trust Bank',
  ];
  @override
  Widget build(BuildContext context) {
    final isValidated = useState<bool>(false);

    // useEffect(() {
    //   getUserProfile();
    //   return null;
    // }, []);
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Form(
        onChanged: () => isValidated.value = _formKey.currentState!.validate(),
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
                          text: "Withdrawal details",
                          fontSize: 20,
                          textColor: AppColors.white),
                      heightSpace(1),
                      customText(
                          text: "Edit your bank and card details here",
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
                    heightSpace(3),
                    AppDropdown(
                      prefixIcon: SizedBox(
                        width: 2,
                        child: SvgPicture.asset(
                          AppImages.accountDet,
                          width: 1,
                        ),
                      ),
                        // isValue: false,
                        value: bankController.text,
                        validator: (val) {
                          if (val == "select") {
                            return "Select a bank";
                          }
                          return null;
                        },
                        dropdownList: bankNames,
                        label: "Bank",
                        onChange: (val) =>
                            bankController.text = val.toString()),
                    heightSpace(1),
                    CustomTextFormField(
                      validator: stringValidation,
                      textEditingController: accountNumber,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: SvgPicture.asset(
                          AppImages.accountDet,
                        ),
                      ),
                      label: "Account Number",
                      // hintText: "Doe",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: [
                                customText(
                                  text: 'Damini Otobo',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  textColor: AppColors.green,
                                  textAlignment: TextAlign.right,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    heightSpace(2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          isPassword: true,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: SvgPicture.asset(
                              AppImages.passwordIcon,
                            ),
                          ),
                          textEditingController: password,
                          label: "Your Ngbuka login password",
                          validator: passwordValidation,
                          hintText: "Enter password",
                        ),
                        heightSpace(3),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.87,
                              child: AppButton(
                                // isActive: isValidated.value,
                                onTap: () {},
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

class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  Language(this.id, this.flag, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, "🇺🇸", "English", "en"),
      Language(2, "🇫🇷", "français", "fr"),
    ];
  }
}
