import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class SpearSetupPage extends StatelessWidget {
  const SpearSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          heightSpace(10),
          Image.asset(AppImages.setools),
          heightSpace(3),
          Image.asset(AppImages.logoBlue),
          heightSpace(6),
          Center(
            child: customText(
                text: "Feels good to have you here",
                fontSize: 24,
                textColor: AppColors.black),
          ),
          heightSpace(1),
          bodyText("Tell us few things about your business"),
          heightSpace(8),
          AppButton(
            onTap: () => context.push(AppRoutes.sparePersonalInfo),
            buttonText: "Continue",
            isOrange: true,
            isSmall: true,
          )
        ],
      )),
    );
  }
}
