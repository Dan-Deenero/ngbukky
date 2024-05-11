import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';


class AccountSelection extends HookWidget {
  const AccountSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
            height: 70.h,
            width: double.infinity,
            color: AppColors.primary,
            child: Center(
              child: SvgPicture.asset(
                AppImages.logo,
                height: 100,
                width: 100,
              ),
            )),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              padding: EdgeInsets.all(4.h),
              width: double.infinity,
              height: 50.h,
              decoration: const BoxDecoration(
                  color: AppColors.lightBlue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customHeading("👋 Hello there!!"),
                  heightSpace(3),
                  bodyText(
                      "Car Mechanic or Spare part dealer? Happy to get you started 😀"),
                  heightSpace(5),
                  AppButton(
                    buttonText: "Car Mechanic",
                    onTap: () => context.push(AppRoutes.onboarding),
                  ),
                  heightSpace(3),
                  const AppButton(buttonText: "Spare part dealer"),
                  heightSpace(3),
                  haveanaccount()
                ],
              )),
        )
      ],
    ));
  }
}
