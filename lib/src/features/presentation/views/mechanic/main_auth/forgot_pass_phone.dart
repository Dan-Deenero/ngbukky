import 'package:flutter/material.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_phone_field.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class ForgotPasswordPhone extends StatelessWidget {
  const ForgotPasswordPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: customText(
              text: "Forgot Password",
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
                  text:
                      "We can help yout recover your password in \n simple steps",
                  fontSize: 15,
                  textAlignment: TextAlign.center,
                  textColor: AppColors.textColor),
            ),
            heightSpace(3),
            customText(
                text: "Enter your phone number",
                fontSize: 15,
                textAlignment: TextAlign.center,
                textColor: AppColors.orange),
            heightSpace(4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                    text: "Phone number",
                    fontSize: 14,
                    textColor: AppColors.primary),
                heightSpace(2),
                const CustomPhoneField(),
              ],
            ),
            heightSpace(4),
            AppButton(
              onTap: () => AppRoutes.newPassword,
              buttonText: "Send code",
              hasIcon: false,
            ),
            heightSpace(2),
            Center(
              child: customText(
                  text: "Resend Code",
                  fontSize: 15,
                  textColor: AppColors.textGrey),
            )
          ],
        ),
      )),
    );
  }
}
