import 'dart:developer';

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
import 'package:ngbuka/src/features/presentation/widgets/dropdown_search.dart';
import 'package:ngbuka/src/utils/helpers/validators.dart';

class LocalAccountSetup extends HookWidget {
  LocalAccountSetup({super.key});
  static final accountNumber = TextEditingController();
  static final password = TextEditingController();
  static final bankController = TextEditingController();
  static List<String> banks = [];

  @override
  Widget build(BuildContext context) {
    onChanged(List<String>? list) {
      banks = list!;
      log(banks.toString());
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: AppColors.containerGrey,
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customText(
                text: 'Bank',
                fontSize: 14,
                textColor: AppColors.primary),
            heightSpace(1),
            AppDropdDownSearch(
              listOfSelectedItems: banks,
              hintText: "Bank you want your funds withdrawn to",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(13.0),
                child: SvgPicture.asset(
                  AppImages.accountDet,
                ),
              ),
              selectedItems: const [
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
              ],
              onChanged: onChanged,
            ),
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
              hintText: "Type in business registration number",
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
