import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/utils/helpers/validators.dart';

class WithdrawFunds extends HookWidget {
  const WithdrawFunds({super.key});
  static final amount = TextEditingController();
  static final password = TextEditingController();

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
                text: "Withdraw funds",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: AppColors.black),
            // heightSpace(1),
            bodyText("Withdraw directly into your local account")
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
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              height: 20.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        AppImages.walletbase,
                      ))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customText(
                    text: "Total Balance",
                    fontSize: 15,
                    textColor: AppColors.white,
                  ),
                  heightSpace(2),
                  customText(
                    text: "₦130,000.00",
                    fontSize: 32,
                    textColor: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            heightSpace(4),
            CustomTextFormField(
              validator: numericValidation,
              textEditingController: amount,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(13.0),
                child: SvgPicture.asset(
                  AppImages.naira,
                ),
              ),
              label: "Amount",
              hintText: "How much do you want to withdraw?",
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
