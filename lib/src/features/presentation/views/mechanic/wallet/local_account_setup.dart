import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_dropdown.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/utils/helpers/validators.dart';

class LocalAccountSetup extends HookWidget {
  LocalAccountSetup({super.key});
  static final accountNumber = TextEditingController();
  static final password = TextEditingController();
  static final bankController= TextEditingController();
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
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: AppColors.backgroundGrey,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText(
                text: "Local account setup",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: AppColors.black),
            // heightSpace(1),
            bodyText("Set up your local bank account ")
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () => context.pop(),
              child: SvgPicture.asset(AppImages.cancelModal),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                onChange: (val) => bankController.text = val.toString()),
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
            heightSpace(3),
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
          ],
        ),
      ),
    );
  }
}
