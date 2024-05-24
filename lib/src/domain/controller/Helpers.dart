import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/domain/data/notification_model.dart';
class Helpers {
  static routeToRespectiveNotificationScreens(
      NotificationModel? data, BuildContext context) {
    switch (data!.notifiableType) {
      case "booking":
        context.push(AppRoutes.notificationToBooking, extra: data.id);
        break;
      case "quote request":
        context.push(AppRoutes.notificationToQuote, extra: data.id);
      case "order":
        context.push(AppRoutes.ordersInfo, extra: data.order!.id);
      case "sparepart":
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
