import 'package:flutter/material.dart';
// import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
// import 'package:ngbuka/src/config/router/app_router.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/wallet/wallet.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class Boarding1 extends StatelessWidget {
  const Boarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.normalBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 100,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Center(child: SvgPicture.asset(AppImages.logo))),
              Flexible(
                flex: 4,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                          text: '👋 Hello there!!',
                          fontSize: 24,
                          textColor: AppColors.black,
                          fontWeight: FontWeight.w800),
                      heightSpace(3),
                      Flexible(
                        flex: 1,
                        child: customText(
                            text:
                                'Car Mechanic or Spare part dealer? \nHappy to get you started 😀',
                            fontSize: 15,
                            textColor: AppColors.black),
                      ),
                      heightSpace(6),
                      AppButton(
                          buttonText: 'Car mechanic',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => const Wallet(),
                              ),
                            );
                            //  context.push(AppRoutes.addWallet),
                          }),
                      heightSpace(1),
                      AppButton(
                        buttonText: 'Spare part dealer',
                        onTap: () => context.push(AppRoutes.personalInfo),
                      ),
                      heightSpace(4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customText(
                              text: 'I already have an account,',
                              fontSize: 14,
                              textColor: AppColors.black),
                          widthSpace(1),
                          GestureDetector(
                              onTap: () {
                                context.push(AppRoutes.boarding2);
                              },
                              child: customText(
                                  text: 'Log me in',
                                  fontSize: 14,
                                  textColor: AppColors.orange))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Boarding2 extends StatelessWidget {
  const Boarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.normalBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 100,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Center(child: SvgPicture.asset(AppImages.logo))),
              Flexible(
                flex: 4,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                          text: 'Login',
                          fontSize: 24,
                          textColor: AppColors.black,
                          fontWeight: FontWeight.w800),
                      heightSpace(3),
                      Flexible(
                        flex: 1,
                        child: customText(
                            text: 'Select who you want to login as',
                            fontSize: 15,
                            textColor: AppColors.black),
                      ),
                      heightSpace(6),
                      AppButton(
                        buttonText: 'Car mechanic',
                        onTap: () => context.push(AppRoutes.login),
                      ),
                      heightSpace(1),
                      AppButton(
                        buttonText: 'Spare part dealer',
                        onTap: () => context.push(AppRoutes.spareSetup),
                      ),
                      heightSpace(4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customText(
                              text: 'I already have an account,',
                              fontSize: 14,
                              textColor: AppColors.black),
                          widthSpace(1),
                          GestureDetector(
                              onTap: () {
                                context.push(AppRoutes.login);
                              },
                              child: customText(
                                  text: 'Get started',
                                  fontSize: 14,
                                  textColor: AppColors.orange))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
