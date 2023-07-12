import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/presentation/widgets/app_pinput.dart';
import 'package:ngbuka/src/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/presentation/widgets/custom_text.dart';

class VerifyAccount extends StatelessWidget {
  const VerifyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
              onTap: () => context.pop(),
              child:
                  const Icon(Icons.arrow_back_ios, color: AppColors.primary)),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: customText(
              text: "Verify account",
              fontSize: 25,
              fontWeight: FontWeight.bold,
              textColor: AppColors.primary)),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            heightSpace(4),
            customText(
                text:
                    "Becaues we trust you, you can verify your account yourself",
                fontSize: 15,
                textAlignment: TextAlign.center,
                textColor: AppColors.textColor),
            heightSpace(3),
            customText(
                text: "Enter the 6 digit code sent to d*****@gmail.com",
                fontSize: 15,
                textAlignment: TextAlign.center,
                textColor: AppColors.orange),
            heightSpace(4),
            PinView(onChanged: (val) => print(val)),
            heightSpace(4),
            AppButton(
              onTap: () => context.push(AppRoutes.setup),
              buttonText: "Verify",
              hasIcon: false,
            ),
            heightSpace(2),
            customText(
                text: "Resend Code",
                fontSize: 15,
                textColor: AppColors.textGrey)
          ],
        ),
      )),
    );
  }
}
