import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/orders_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/features/presentation/widgets/dashboard_widget/listtile_style.dart';

class Orders extends HookWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    final tabIndex = useState<int>(0);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(19.h),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightSpace(5),
                customText(
                  text: "Orders",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.black,
                ),
                heightSpace(1),
                bodyText("View and keep track of your orders here")
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(5)),
              child: TabBar(
                labelPadding: EdgeInsets.zero,
                unselectedLabelColor: AppColors.primary,
                labelColor: AppColors.primary,
                indicator: const BoxDecoration(),
                onTap: (value) {
                  tabIndex.value = value;
                },
                tabs: [
                  Container(
                    width: 400,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      color: tabIndex.value == 0
                          ? AppColors.white
                          : AppColors.borderGrey,
                      border: tabIndex.value == 0
                          ? Border.all(
                              width: 1.0,
                              color: AppColors.borderGrey,
                            )
                          : Border.all(
                              width: 0, color: AppColors.backgroundGrey),
                    ),
                    child: const Tab(
                      text: "New",
                    ),
                  ),
                  Container(
                    width: 400,
                    height: 40,
                    decoration: BoxDecoration(
                      color: tabIndex.value == 1
                          ? AppColors.white
                          : AppColors.borderGrey,
                      border: tabIndex.value == 1
                          ? Border.all(
                              width: 1.0,
                              color: AppColors.borderGrey,
                            )
                          : Border.all(
                              width: 0, color: AppColors.backgroundGrey),
                    ),
                    child: const Tab(
                      text: "Pending",
                    ),
                  ),
                  Container(
                    width: 400,
                    height: 40,
                    decoration: BoxDecoration(
                      color: tabIndex.value == 2
                          ? AppColors.white
                          : AppColors.borderGrey,
                      border: tabIndex.value == 2
                          ? Border.all(
                              width: 1.0,
                              color: AppColors.borderGrey,
                            )
                          : Border.all(
                              width: 0, color: AppColors.backgroundGrey),
                    ),
                    child: const Tab(
                      text: "Processed",
                    ),
                  ),
                  Container(
                    width: 400,
                    height: 40,
                    decoration: BoxDecoration(
                      color: tabIndex.value == 3
                          ? AppColors.white
                          : AppColors.borderGrey,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      border: tabIndex.value == 3
                          ? Border.all(
                              width: 1.0,
                              color: AppColors.borderGrey,
                            )
                          : Border.all(
                              width: 0, color: AppColors.backgroundGrey),
                    ),
                    child: const Tab(
                      text: "Completed",
                    ),
                  ),
                ],
              ),
            ),
            heightSpace(2),
            Expanded(
              child: TabBarView(
                children: [New(), Awaiting(), Processed(), Completed()],
              ),
            )
          ],
        ),
      ),
    );
  }
}



class New extends HookWidget {
  New({Key? key}) : super(key: key ?? UniqueKey());

  static const bool empty = false;
  static final MechanicRepo mechanicRepo = MechanicRepo();

  @override
  Widget build(BuildContext context) {
    final ordersHistory = useState<List<OrdersModel>>([]);
    final isLoading = useState<bool>(true);

    getOrders() {
      mechanicRepo.getAllOrder('pending').then(
        (value) {
          ordersHistory.value = value;
          isLoading.value = false;
        },
      );
    }

    useEffect(() {
      getOrders();
      return null;
    }, [ordersHistory.value.length]);
    return isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  if (ordersHistory.value.isEmpty)
                    Center(
                      child: Column(
                        children: [
                          heightSpace(5),
                          SvgPicture.asset(AppImages.noInventory),
                          heightSpace(1),
                          SizedBox(
                            width: 400,
                            child: customText(
                              text: 'You have no orders yet',
                              fontSize: 15,
                              textColor: AppColors.textGrey.withOpacity(0.3),
                              textAlignment: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    )
                  else
                    ...ordersHistory.value.map(
                      (e) {
                        var dateString = e.createdAt;
                        var dateTime = DateTime.parse(dateString!).add(const Duration(hours: 1));
                        var formattedDate =
                            DateFormat('dd MMM yyyy').format(dateTime);

                        var formattedTime =
                            DateFormat('hh:mm a').format(dateTime);
                        // var disPrice = e.product!.price! * (e.product!.discount! / 100);
                        // var price = e.product!.price! - disPrice;
                        return ListRect(
                          isOrders: true,
                          image: e.product!.imageUrl,
                          price: e.product!.finalPrice,
                          item: e.product!.name,
                          quantity: e.quantity,
                          ontap: () =>
                              context.push(AppRoutes.ordersInfo, extra: e.id),
                          // length: e.product!.specifications!.length,
                          time: formattedTime,
                          date: formattedDate,
                          status: e.status,
                          deliveryMethod: e.order!.deliveryMethod,
                        );
                      },
                    ),
                  heightSpace(2),
                ],
              ),
            ),
          );
  }
}

class Awaiting extends HookWidget {
  Awaiting({Key? key}) : super(key: key ?? UniqueKey());

  static const bool empty = false;
  static final MechanicRepo mechanicRepo = MechanicRepo();

  @override
  Widget build(BuildContext context) {
    final ordersHistory = useState<List<OrdersModel>>([]);
    final isLoading = useState<bool>(true);

    getOrders() {
      mechanicRepo.getAllOrder('awaiting processing').then(
        (value) {
          ordersHistory.value = value;
          isLoading.value = false;
        },
      );
    }

    useEffect(() {
      getOrders();
      return null;
    }, [ordersHistory.value.length]);
    return isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  if (ordersHistory.value.isEmpty)
                    Center(
                      child: Column(
                        children: [
                          heightSpace(5),
                          SvgPicture.asset(AppImages.noInventory),
                          heightSpace(1),
                          SizedBox(
                            width: 400,
                            child: customText(
                              text: 'You have no orders yet',
                              fontSize: 15,
                              textColor: AppColors.textGrey.withOpacity(0.3),
                              textAlignment: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    )
                  else
                    ...ordersHistory.value.map(
                      (e) {
                        var dateString = e.createdAt;
                        var dateTime = DateTime.parse(dateString!).add(const Duration(hours: 1));
                        var formattedDate =
                            DateFormat('dd MMM yyyy').format(dateTime);

                        var formattedTime =
                            DateFormat('hh:mm a').format(dateTime);
                        // var disPrice = e.product!.price! * (e.product!.discount! / 100);
                        // var price = e.product!.price! - disPrice;
                        return ListRect(
                          isOrders: true,
                          image: e.product!.imageUrl,
                          price: e.product!.finalPrice,
                          item: e.product!.name,
                          quantity: e.quantity,
                          ontap: () =>
                              context.push(AppRoutes.processOrder, extra: e.id),
                          // length: e.product!.specifications!.length,
                          time: formattedTime,
                          date: formattedDate,
                          status: e.status,
                          deliveryMethod: e.order!.deliveryMethod,
                        );
                      },
                    ),
                  heightSpace(2),
                ],
              ),
            ),
          );
  }
}

class Processed extends HookWidget {
  Processed({Key? key}) : super(key: key ?? UniqueKey());

  static const bool empty = false;
  static final MechanicRepo mechanicRepo = MechanicRepo();

  @override
  Widget build(BuildContext context) {
    final ordersHistory = useState<List<OrdersModel>>([]);
    final isLoading = useState<bool>(true);

    getOrders() {
      mechanicRepo.getAllOrder('processed').then(
        (value) {
          ordersHistory.value = value;
          isLoading.value = false;
        },
      );
    }

    useEffect(() {
      getOrders();
      return null;
    }, [ordersHistory.value.length]);
    return isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  if (ordersHistory.value.isEmpty)
                    Center(
                      child: Column(
                        children: [
                          heightSpace(5),
                          SvgPicture.asset(AppImages.noInventory),
                          heightSpace(1),
                          SizedBox(
                            width: 400,
                            child: customText(
                              text: 'You have no orders yet',
                              fontSize: 15,
                              textColor: AppColors.textGrey.withOpacity(0.3),
                              textAlignment: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    )
                  else
                    ...ordersHistory.value.map(
                      (e) {
                        var dateString = e.createdAt;
                        var dateTime = DateTime.parse(dateString!).add(const Duration(hours: 1));
                        var formattedDate =
                            DateFormat('dd MMM yyyy').format(dateTime);

                        var formattedTime =
                            DateFormat('hh:mm a').format(dateTime);
                        // var disPrice = e.product!.price! * (e.product!.discount! / 100);
                        // var price = e.product!.price! - disPrice;
                        return ListRect(
                          isOrders: true,
                          image: e.product!.imageUrl,
                          price: e.product!.finalPrice,
                          item: e.product!.name,
                          quantity: e.quantity,
                          ontap: () =>
                              context.push(AppRoutes.ordersInfo, extra: e.id),
                          // length: e.product!.specifications!.length,
                          time: formattedTime,
                          date: formattedDate,
                          status: e.status,
                          deliveryMethod: e.order!.deliveryMethod,
                        );
                      },
                    ),
                  heightSpace(2),
                ],
              ),
            ),
          );
  }
}

class Completed extends HookWidget {
  Completed({Key? key}) : super(key: key ?? UniqueKey());

  static const bool empty = false;
  static final MechanicRepo mechanicRepo = MechanicRepo();

  @override
  Widget build(BuildContext context) {
    final ordersHistory = useState<List<OrdersModel>>([]);
    final isLoading = useState<bool>(true);

    getOrders() {
      mechanicRepo.getAllOrder('completed').then(
        (value) {
          ordersHistory.value = value;
          isLoading.value = false;
        },
      );
    }

    useEffect(() {
      getOrders();
      return null;
    }, [ordersHistory.value.length]);
    return isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  if (ordersHistory.value.isEmpty)
                    Center(
                      child: Column(
                        children: [
                          heightSpace(5),
                          SvgPicture.asset(AppImages.noInventory),
                          heightSpace(1),
                          SizedBox(
                            width: 400,
                            child: customText(
                              text: 'You have no orders yet',
                              fontSize: 15,
                              textColor: AppColors.textGrey.withOpacity(0.3),
                              textAlignment: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    )
                  else
                    ...ordersHistory.value.map(
                      (e) {
                        var dateString = e.createdAt;
                        var dateTime = DateTime.parse(dateString!).add(const Duration(hours: 1));
                        var formattedDate =
                            DateFormat('dd MMM yyyy').format(dateTime);

                        var formattedTime =
                            DateFormat('hh:mm a').format(dateTime);
                        // var disPrice = e.product!.price! * (e.product!.discount! / 100);
                        // var price = e.product!.price! - disPrice;
                        return ListRect(
                          isOrders: true,
                          image: e.product!.imageUrl,
                          price: e.product!.finalPrice,
                          item: e.product!.name,
                          quantity: e.quantity,
                          ontap: () =>
                              context.push(AppRoutes.ordersInfo, extra: e.id),
                          // length: e.product!.specifications!.length,
                          time: formattedTime,
                          date: formattedDate,
                          status: e.status,
                          deliveryMethod: e.order!.deliveryMethod,
                        );
                      },
                    ),
                  heightSpace(2),
                ],
              ),
            ),
          );
  }
}
