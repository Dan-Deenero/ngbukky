import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';

class Helpers {
  static routeToRespectiveNotificationScreens(
      String? status, String? id, BuildContext context) {
    switch (status) {
      case "pending":
        context.push(AppRoutes.ordersInfo, extra: id);
        break;
      case "awaiting processing":
        context.push(AppRoutes.processOrder, extra: id);
        break;
      case "processed":
        context.push(AppRoutes.ordersInfo, extra: id);
        break;
      case "picked_up":
        context.push(AppRoutes.ordersInfo, extra: id);
        break;
      case "en_route":
        context.push(AppRoutes.ordersInfo, extra: id);
        break;
      case "completed":
        context.push(AppRoutes.ordersInfo, extra: id);
        break;
      case "returned":
        context.push(AppRoutes.ordersInfo, extra: id);
        break;
      case "declined":
        context.push(AppRoutes.ordersInfo, extra: id);
        break;
    }
  }

  static String formatBalance(dynamic balance) {
    // Create a NumberFormat instance with the desired format
    final NumberFormat formatter = NumberFormat('#,###');

    // Format the balance using the NumberFormat instance
    return formatter.format(balance);
  }

  static onItemTapped(
    int index,
    BuildContext context,
  ) {
    switch (index) {
      case 0:
        context.go(AppRoutes.spareDashboard);
        break;
      case 1:
        context.go(AppRoutes.orders);
        break;
      case 2:
        context.go(AppRoutes.inventory);
        break;
      case 3:
        context.go(AppRoutes.spareWallet);
        break;
      case 4:
        context.go(AppRoutes.spareProfileSettings);
        break;
    }
  }
}
