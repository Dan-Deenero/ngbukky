import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ngbuka/src/core/shared/colors.dart';

import '../../../core/shared/app_images.dart';
import 'home.dart';

class BottomNavigationBarView extends HookWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: selectedIndex.value == 0
                ? SvgPicture.asset(
                    AppImages.home,
                    color: AppColors.primary,
                  )
                : SvgPicture.asset(AppImages.home, color: AppColors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: selectedIndex.value == 1
                ? SvgPicture.asset(AppImages.wallet, color: AppColors.primary)
                : SvgPicture.asset(
                    AppImages.wallet,
                  ),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
              icon: selectedIndex.value == 2
                  ? SvgPicture.asset(
                      AppImages.orders,
                      color: AppColors.primary,
                    )
                  : SvgPicture.asset(
                      AppImages.orders,
                      color: AppColors.black,
                    ),
              label: "Wallet"),
          BottomNavigationBarItem(
              icon: selectedIndex.value == 3
                  ? SvgPicture.asset(
                      AppImages.orders,
                      color: AppColors.primary,
                    )
                  : SvgPicture.asset(AppImages.orders),
              label: "Profile"),
        ],
        currentIndex: selectedIndex.value,
        unselectedItemColor: AppColors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
