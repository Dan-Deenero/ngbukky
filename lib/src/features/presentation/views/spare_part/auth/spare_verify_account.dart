import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/otp_model.dart';
import 'package:ngbuka/src/domain/repository/auth_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_pinput.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class SpareVerifyAccount extends HookWidget {
  static final AuthRepo _authRepo = AuthRepo();
  static final otp = TextEditingController();
  final OTPModel otpModel;
  const SpareVerifyAccount({super.key, required this.otpModel});

  @override
  Widget build(BuildContext context) {
    final isValidated = useState<bool>(false);

    void resendOTP() async {
      await _authRepo.resendOTP();
    }

    void verifyOTP() async {
      log(otpModel.otpType);
      var body = {"email": otpModel.email, "otp": otp.text};
      if (otpModel.otpType == "createAccount") {
        bool result = await _authRepo.verifyOTP(body);
        if (result) {
          if (context.mounted) {
            context.push(AppRoutes.spareSetup);
            return;
          }
        }
      }

      bool result = await _authRepo.verifyPasswordOTP(body);
      if (result) {
        if (context.mounted) {
          context.push(AppRoutes.spareNewPassword);
          return;
        }
      }
    }

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
                    "Because we trust you, you can verify your account yourself",
                fontSize: 15,
                textAlignment: TextAlign.center,
                textColor: AppColors.textColor),
            heightSpace(3),
            customText(
                text: "Enter the 6 digit code sent to ${otpModel.email}",
                fontSize: 15,
                textAlignment: TextAlign.center,
                textColor: AppColors.orange),
            heightSpace(4),
            PinView(onChanged: (val) {
              otp.text = val;
              if (otp.text.length == 6) {
                isValidated.value = true;
              }
            }),
            heightSpace(4),
            AppButton(
              isActive: isValidated.value,
              onTap: verifyOTP,
              buttonText: "Verify",
              hasIcon: false,
            ),
            heightSpace(2),
            InkWell(
              onTap: resendOTP,
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
