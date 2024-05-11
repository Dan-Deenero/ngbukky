import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/booking_things/booking.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/wallet/wallet.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/profile_settings/profile_page.dart';

import '../../../../core/shared/app_images.dart';
import 'home.dart';

class BottomNavigationBarView extends HookWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static final List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    Bookings(),
    const Wallet(),
    const ProfileSettings(),
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
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: AppColors.bottomNav),
        selectedLabelStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: selectedIndex.value == 0
                ? SvgPicture.asset(
                    AppImages.home,
                    width: 30,
                    color: AppColors.orange,
                  )
                : SvgPicture.asset(
                    AppImages.home,
                    color: AppColors.black,
                    width: 30,
                  ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: selectedIndex.value == 1
                ? SvgPicture.asset(
                    AppImages.orders,
                    color: AppColors.orange,
                    width: 30,
                  )
                : SvgPicture.asset(
                    AppImages.orders,
                    width: 30,
                  ),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: selectedIndex.value == 2
                ? SvgPicture.asset(
                    AppImages.wallet,
                    color: AppColors.orange,
                    width: 30,
                  )
                : SvgPicture.asset(
                    AppImages.wallet,
                    color: AppColors.black,
                    width: 30,
                  ),
            label: "Wallet",
          ),
          BottomNavigationBarItem(
            icon: selectedIndex.value == 3
                ? SvgPicture.asset(
                    AppImages.profile,
                    color: AppColors.orange,
                    width: 30,
                  )
                : SvgPicture.asset(
                    AppImages.profile,
                    width: 30,
                  ),
            label: "Profile",
          ),
        ],
        currentIndex: selectedIndex.value,
        onTap: _onItemTapped,
      ),
    );
  }
}
