import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_keys.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/config/locator/app_locator.dart';
import 'package:ngbuka/src/config/services/storage_service.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(child: SvgPicture.asset(AppImages.logo)),
    );
  }

  checkForLogin() {
    final token = locator<LocalStorageService>().getDataFromDisk(AppKeys.token);
    if (token != null) {
      context.push(AppRoutes.login);
      // context.push(AppRoutes.bottomNav);
      // selectAccountView();
      return;
    } else {
      context.push(AppRoutes.login);
    }
  }

  checkForOnBoarding() {
    bool firstInstall =
        locator<LocalStorageService>().getDataFromDisk(AppKeys.firstInstall) ??
            true;

    log(firstInstall.toString());
    if (firstInstall) {
      context.push(AppRoutes.onboarding);
      return;
    }
    checkForLogin();
  }

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () => checkForOnBoarding());
  }
}
