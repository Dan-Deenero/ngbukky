import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

import '../../../../../config/keys/app_routes.dart';

class BusinessLocation extends StatelessWidget {
  const BusinessLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(), shape: BoxShape.circle),
                  child: Center(child: SvgPicture.asset(AppImages.badIcon)),
                ),
              ),
              heightSpace(2),
              customText(
                  text: "Select your location",
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.black),
              heightSpace(1),
              bodyText("Let your clients know where your business is"),
              heightSpace(4),
              CustomTextFormField(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: SvgPicture.asset(
                    AppImages.locationIcon,
                  ),
                ),
                label: "State",
                hintText: "Select",
              ),
              heightSpace(2),
              CustomTextFormField(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: SvgPicture.asset(
                    AppImages.locationIcon,
                  ),
                ),
                label: "City",
                hintText: "Select",
              ),
              heightSpace(2),
              CustomTextFormField(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: SvgPicture.asset(
                    AppImages.locationIcon,
                  ),
                ),
                label: "Town",
                hintText: "Select",
              ),
              heightSpace(2),
              CustomTextFormField(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: SvgPicture.asset(
                    AppImages.locationIcon,
                  ),
                ),
                label: "Street",
                hintText: "Type in your business street address",
              ),
              heightSpace(10),
              AppButton(
                onTap: () => context.push(AppRoutes.bottomNav),
                isOrange: true,
                buttonText: "Save",
              ),
              heightSpace(5),
            ],
          ),
        ),
      )),
    );
  }
}
