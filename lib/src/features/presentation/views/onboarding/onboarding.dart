import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_keys.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/config/locator/app_locator.dart';
import 'package:ngbuka/src/config/services/storage_service.dart';
import 'package:ngbuka/src/domain/data/onboarding_model.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';

import '../../../../core/shared/colors.dart';
import '../../widgets/custom_text.dart';

class OnboardingScreen extends HookWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPage = useState<int>(0);
    return Scaffold(
      body: PageView.builder(
          onPageChanged: (val) => currentPage.value = val,
          itemCount: onboarding.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
                    padding: EdgeInsets.zero,
                    height: 70.h,
                    width: double.infinity,
                    child: Image.asset(
                      onboarding[index].image,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      padding: EdgeInsets.all(4.h),
                      width: double.infinity,
                      height: 45.h,
                      decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customHeading(onboarding[index].heading),
                          heightSpace(1),
                          DotsIndicator(
                            dotsCount: onboarding.length,
                            position: currentPage.value,
                            decorator: DotsDecorator(
                              size: const Size.square(9.0),
                              activeSize: const Size(18.0, 9.0),
                              activeShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                          heightSpace(1),
                          bodyText(onboarding[index].description),
                          heightSpace(5),
                          AppButton(
                              buttonText: "Start connecting",
                              onTap: () {
                                locator<LocalStorageService>().saveDataToDisk(
                                    AppKeys.firstInstall, false);
                                context.push(AppRoutes.boarding1);
                              }),
                          heightSpace(3),
                          haveanaccount()
                        ],
                      )),
                )
              ],
            );
          }),
    );
  }
}
