import 'package:flutter/material.dart';
import 'package:ngbuka/src/domain/data/notification_model.dart';
import 'package:ngbuka/src/domain/data/orders_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/orders/orders_info.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/orders/process_order.dart';

class NotificationToOrders extends StatefulWidget {
  final String id;

  const NotificationToOrders({
    super.key,
    required this.id,
  });

  @override
  State<NotificationToOrders> createState() => _NotificationToOrdersState();
}

class _NotificationToOrdersState extends State<NotificationToOrders> {
  bool isLoading = true;
  final MechanicRepo _mechanicRepo = MechanicRepo();
  OrdersModel? ordersModel;
  NotificationModel? notifyModel;
  String? id;
  String? status;

  @override
  void initState() {
    super.initState();
    _mechanicRepo.getOneNotification(widget.id).then((value) {
      setState(() {
        notifyModel = value;
      });
      return _mechanicRepo.getOneOrder(notifyModel!.notifiableId);
    }).then((value) {
      setState(() {
        ordersModel = value;
        isLoading = false;
        id = ordersModel!.id;
        status = ordersModel!.status;
      });
    }).catchError((error) {
      // Handle any errors here
      setState(() {
        isLoading = false;
        // Optionally handle the error state
      });
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: SingleChildScrollView(),
      );
    } else {
      if (status == 'awaiting processing') {
        return ProcessOrder(
          id: id!,
        );
      } else if (status == 'pending') {
        return OrdersInfo(
          id: id!,
        );
      } else if (status == 'processed') {
        return OrdersInfo(
          id: id!,
        );
      }else if (status == 'picked_up') {
        return OrdersInfo(
          id: id!,
        );
      }else if (status == 'en_route') {
        return OrdersInfo(
          id: id!,
        );
      }else if (status == 'completed') {
        return OrdersInfo(
          id: id!,
        );
      }else if (status == 'returned') {
        return OrdersInfo(
          id: id!,
        );
      }else if (status == 'declined') {
        return OrdersInfo(
          id: id!,
        );
      } else {
        return const DefaultWidget();
      }
    }
  }
}

class DefaultWidget extends StatelessWidget {
  const DefaultWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Unknown status'),
      ),
    );
  }
}
