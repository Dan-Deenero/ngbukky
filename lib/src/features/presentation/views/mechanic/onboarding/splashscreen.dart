import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_keys.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/config/locator/app_locator.dart';
import 'package:ngbuka/src/config/services/storage_service.dart';
import 'package:ngbuka/src/core/managers/notification_manger.dart';
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
    log(token.toString());

    if (token != null) {
      if(locator<LocalStorageService>().getDataFromDisk(AppKeys.userType) == 'mechanic'){
          locator<GoRouter>().push(AppRoutes.bottomNav);
        }else if(locator<LocalStorageService>().getDataFromDisk(AppKeys.userType) == 'dealer'){
          locator<GoRouter>().push(AppRoutes.spareBottomNav);
        }
    } else {
      context.push(AppRoutes.boarding2);
    }
  }

  checkForOnBoarding() {
    bool firstInstall =
        locator<LocalStorageService>().getDataFromDisk(AppKeys.firstInstall) ??
            true;

    log(firstInstall.toString());
    if (firstInstall) {
      context.push(AppRoutes.onboarding);
    } else {
      checkForLogin();
      context.push(AppRoutes.boarding1);
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      checkForOnBoarding();
      
    });
    NotificationsManager.requestPermissions();
  }
}
