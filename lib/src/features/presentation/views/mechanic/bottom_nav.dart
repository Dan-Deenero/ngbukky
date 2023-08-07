import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/booking.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/wallet/wallet.dart';
import 'package:ngbuka/src/features/presentation/views/profile_settings/profile_page.dart';

import '../../../../core/shared/app_images.dart';
import 'home.dart';

class BottomNavigationBarView extends HookWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    Bookings(),
    Wallet(),
    ProfileSettings(),
  ];
  const BottomNavigationBarView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState<int>(0);

    void _onItemTapped(int index) {
      log(index.toString());
      selectedIndex.value = index;
    }

    return Scaffold(
      body: _widgetOptions.elementAt(selectedIndex.value),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.black,
        showUnselectedLabels: true,
        unselectedItemColor: AppColors.black,
        unselectedFontSize: 14,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: selectedIndex.value == 0
                ? SvgPicture.asset(
                    AppImages.home,
                    color: AppColors.orange,
                  )
                : SvgPicture.asset(AppImages.home, color: AppColors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: selectedIndex.value == 1
                ? SvgPicture.asset(AppImages.wallet, color: AppColors.orange)
                : SvgPicture.asset(
                    AppImages.orders,
                  ),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
              icon: selectedIndex.value == 2
                  ? SvgPicture.asset(
                      AppImages.wallet,
                      color: AppColors.orange,
                    )
                  : SvgPicture.asset(
                      AppImages.wallet,
                      color: AppColors.black,
                    ),
              label: "Wallet"),
          BottomNavigationBarItem(
              icon: selectedIndex.value == 3
                  ? SvgPicture.asset(
                      AppImages.profile,
                      color: AppColors.orange,
                    )
                  : SvgPicture.asset(AppImages.profile),
              label: "Profile"),
        ],
        currentIndex: selectedIndex.value,
        onTap: _onItemTapped,
      ),
    );
  }
}
