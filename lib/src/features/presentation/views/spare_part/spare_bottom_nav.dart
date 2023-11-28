import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/inventory_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/dashboard.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/inventory/inventory.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/orders/orders.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/profile_settings/spare_profile_page.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/wallet/spare_wallet.dart';

import '../../../../core/shared/app_images.dart';

class BottomNavBarView extends HookWidget {
  static final MechanicRepo mechanicRepo = MechanicRepo();

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static  final List<Widget> _widgetOptions = <Widget>[
    DashboardView(),
    const Orders(),
    const Inventory(),
    const SpareWallet(),
    const SpareProfileSettings()
  ];
  const BottomNavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState<int>(0);
    final inventoryHistory = useState<List<InventoryModel>>([]);
    final isLoading = useState<bool>(true);

    getInventory() {
      mechanicRepo.getAllInventory('all').then(
        (value) {
          inventoryHistory.value = value;
          isLoading.value = false;
          if (inventoryHistory.value.isEmpty) {
            selectedIndex.value = 2;
          }
        },
      );
    }

    void _onItemTapped(int index) {
      log(index.toString());
      selectedIndex.value = index;
    }

    useEffect(() {
      getInventory();
      return null;
    }, []);
    return isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: _widgetOptions.elementAt(selectedIndex.value),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: AppColors.black,
              showUnselectedLabels: true,
              unselectedItemColor: AppColors.black,
              // unselectedFontSize: 14,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: selectedIndex.value == 0
                      ? SvgPicture.asset(
                          AppImages.home,
                          color: AppColors.orange,
                        )
                      : SvgPicture.asset(AppImages.home,
                          color: AppColors.black),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: selectedIndex.value == 1
                      ? SvgPicture.asset(AppImages.wallet,
                          color: AppColors.orange)
                      : SvgPicture.asset(
                          AppImages.orders,
                        ),
                  label: 'Orders',
                ),
                BottomNavigationBarItem(
                    icon: selectedIndex.value == 2
                        ? SvgPicture.asset(
                            AppImages.orders,
                            color: AppColors.orange,
                          )
                        : SvgPicture.asset(
                            AppImages.orders,
                            color: AppColors.black,
                          ),
                    label: "Inventory"),
                BottomNavigationBarItem(
                    icon: selectedIndex.value == 3
                        ? SvgPicture.asset(
                            AppImages.profile,
                            color: AppColors.orange,
                          )
                        : SvgPicture.asset(AppImages.wallet),
                    label: "Wallet"),
                BottomNavigationBarItem(
                    icon: selectedIndex.value == 4
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
