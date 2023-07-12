import 'package:flutter/material.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/presentation/widgets/custom_text.dart';

class NewPassword extends StatelessWidget {
  const NewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: customText(
              text: "New Password",
              fontSize: 25,
              fontWeight: FontWeight.bold,
              textColor: AppColors.primary)),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightSpace(4),
            Center(
              child: customText(
                  text: "Create new password here",
                  fontSize: 15,
                  textAlignment: TextAlign.center,
                  textColor: AppColors.textColor),
            ),
            heightSpace(3),
            const CustomTextFormField(
              isPassword: true,
              label: "New password",
              hintText: "Enter password",
            ),
            heightSpace(2),
            const CustomTextFormField(
              isPassword: true,
              label: "Confirm new password",
              hintText: "Enter password",
            ),
            heightSpace(2),
            AppButton(
              onTap: () => AppRoutes.verifyAccount,
              buttonText: "New password",
              hasIcon: false,
            ),
            heightSpace(2),
          ],
        ),
      )),
    );
  }
}
