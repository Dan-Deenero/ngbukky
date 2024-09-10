import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/dealer_dashboard_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/features/presentation/widgets/dashboard_widget/listtile_style.dart';
import 'package:ngbuka/src/features/presentation/widgets/dashboard_widget/square_card.dart';

class DashboardView extends HookWidget {
  static final MechanicRepo _mechanicRepo = MechanicRepo();

  DashboardView({Key? key}) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    final ongoingOrdersCount = useState<int?>(0);
    final completedOrdersCount = useState<int?>(0);
    final returnedOrdersCount = useState<int?>(0);
    final dashhy = useState<DashboardModel?>(null);

    final name = useState<String?>('Damini');

    final mediaQueryData = MediaQuery.of(context);
    final sw = mediaQueryData.size.width;
    final sh = mediaQueryData.size.height;

    var hour = DateTime.now().hour;

    String greetings = 'good morning';

    if (hour < 12) {
      greetings = 'Good Morning';
    } else if (hour < 17) {
      greetings = 'Good Afternoon';
    } else {
      greetings = 'Good Evening';
    }

    final isLoading = useState<bool>(true);
    Future<dynamic> getDashboardInfo() async {
      await _mechanicRepo.getDealerDahsboardInfo().then(
        (value) {
          dashhy.value = value;
          ongoingOrdersCount.value = value.ongoingOrdersCount;
          completedOrdersCount.value = value.completedOrdersCount;
          returnedOrdersCount.value = value.returnedOrdersCount;
        },
      );
    }

    Future<dynamic> getUserProfile() async {
      await _mechanicRepo.getDealerProfile().then((value) {
        name.value = value.lastname!;
      });
    }

    useEffect(() {
      void refresh() async {
        isLoading.value = true;
        await getDashboardInfo();
        await getUserProfile();
        isLoading.value = false;
      }

      refresh();
      return null;
    }, [isLoading]);
    return isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                10.h,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText(
                                  text: "$greetings, ${name.value}",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  textColor: AppColors.black),
                              bodyText("Great way to start your day "),
                            ],
                          ),
                          GestureDetector(
                            onTap: () =>
                                context.push(AppRoutes.spareNotification),
                            child: SvgPicture.asset(AppImages.notification),
                          )
                        ],
                      ),
                    ]),
              ),
            ),
            backgroundColor: AppColors.scaffoldColor,
            body: RefreshIndicator(
              onRefresh: () async {
                isLoading.value = true;
                await getDashboardInfo();
                await getUserProfile();
                isLoading.value = false;
              },
              child: isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      // physics: const ScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 50, 20, 40),
                                    width: 50.w - 40,
                                    height: 208,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.veryLightOrange),
                                    child: Column(children: [
                                      customText(
                                          text: "Ongoing orders",
                                          fontSize: 12,
                                          textColor: AppColors.black),
                                      heightSpace(2),
                                      customText(
                                          text:
                                              "${dashhy.value!.ongoingOrdersCount}",
                                          fontSize: 24,
                                          textColor: AppColors.black),
                                      heightSpace(2),
                                      customText(
                                          text: "New and pending",
                                          fontSize: 10,
                                          textColor: AppColors.lightOrange)
                                    ]),
                                  ),
                                ),
                                widthSpace(3),
                                Expanded(
                                  child: Column(
                                    children: [
                                      bookingStatusDiv(
                                        dashhy.value!.completedOrdersCount,
                                        AppColors.black,
                                        AppColors.green,
                                        AppColors.white,
                                        'Completed orders',
                                      ),
                                      heightSpace(1),
                                      bookingStatusDiv(
                                        dashhy.value!.returnedOrdersCount,
                                        AppColors.red,
                                        AppColors.lightOrange,
                                        AppColors.containerOrange,
                                        'Returned orders',
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            heightSpace(1),
                            const Divider(),
                            heightSpace(2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customText(
                                  text: "Incoming orders",
                                  fontSize: 15,
                                  textColor: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                                // if (dashhy.value!.incomingOrders!.isEmpty)
                                //   IgnorePointer(
                                //     ignoring: true,
                                //     child: Row(
                                //       children: [
                                //         customText(
                                //           text: "See all",
                                //           fontSize: 15,
                                //           textColor:
                                //               AppColors.primary.withOpacity(0.1),
                                //         ),
                                //         Icon(
                                //           Icons.arrow_forward,
                                //           size: 20,
                                //           color: AppColors.primary.withOpacity(0.1),
                                //         )
                                //       ],
                                //     ),
                                //   )
                                // else
                                //   GestureDetector(
                                //     onTap: () =>
                                //         context.push(AppRoutes.bookingAlert),
                                //     child: Row(
                                //       children: [
                                //         customText(
                                //           text: "See all",
                                //           fontSize: 15,
                                //           textColor: AppColors.orange,
                                //         ),
                                //         const Icon(
                                //           Icons.arrow_forward,
                                //           size: 20,
                                //           color: AppColors.orange,
                                //         )
                                //       ],
                                //     ),
                                //   )
                              ],
                            ),
                            heightSpace(2),
                            if (dashhy.value!.incomingOrders!.isEmpty)
                              Center(
                                child: Column(
                                  children: [
                                    SvgPicture.asset(AppImages.nobookingicon),
                                    heightSpace(1),
                                    SizedBox(
                                      width: 130,
                                      child: customText(
                                        text: 'You do not have any orders yet',
                                        fontSize: 15,
                                        textColor:
                                            AppColors.textGrey.withOpacity(0.3),
                                        textAlignment: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            else
                              ...dashhy.value!.incomingOrders!.map(
                                (e) {
                                  var dateString = e.createdAt;
                                  var dateTime = DateTime.parse(dateString!).add(const Duration(hours: 1));
                                  var formattedDate = DateFormat('dd MMM yyyy')
                                      .format(dateTime);

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
                                    ontap: () {
                                      if (e.status == 'awaiting processing') {
                                        context.push(
                                          AppRoutes.processOrder,
                                          extra: e.id,
                                        );
                                      } else {
                                        context.push(
                                          AppRoutes.ordersInfo,
                                          extra: e.id,
                                        );
                                      }
                                    },
                                    // length: e.product!.specifications!.length,
                                    time: formattedTime,
                                    date: formattedDate,
                                    status: e.status,
                                    deliveryMethod: e.order!.deliveryMethod,
                                  );
                                },
                              ),
                            heightSpace(1),
                            const Divider(),
                            heightSpace(4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customText(
                                  text: "Your top sellers",
                                  fontSize: 15,
                                  textColor: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                            heightSpace(4),
                            if (dashhy.value!.topSellers!.isEmpty)
                              Center(
                                child: Column(
                                  children: [
                                    SvgPicture.asset(AppImages.noquoteicon),
                                    heightSpace(1),
                                    SizedBox(
                                      width: 120,
                                      child: customText(
                                        text: 'No top sellers yet',
                                        fontSize: 15,
                                        textColor:
                                            AppColors.textGrey.withOpacity(0.3),
                                        textAlignment: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            else
                              SizedBox(
                                height: 41.h,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    ...dashhy.value!.topSellers!.map(
                                      (e) {
                                        return SquareCard(
                                          sh: sh * 0.245,
                                          sw: sw * 0.55,
                                          image: e.imageUrl,
                                          item: e.name,
                                          price: e.finalPrice,
                                          quantity: e.quantityInStock,
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            heightSpace(2),
                            heightSpace(1),
                            const Divider(),
                            heightSpace(4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customText(
                                  text: "You’re running out",
                                  fontSize: 15,
                                  textColor: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                            heightSpace(2),
                            if (dashhy.value!.productsLowInStock!.isEmpty)
                              Center(
                                child: Column(
                                  children: [
                                    SvgPicture.asset(AppImages.noquoteicon),
                                    heightSpace(1),
                                    SizedBox(
                                      width: 120,
                                      child: customText(
                                        text: 'You do not have any orders yet',
                                        fontSize: 15,
                                        textColor:
                                            AppColors.textGrey.withOpacity(0.3),
                                        textAlignment: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            else
                              SizedBox(
                                height: 38.h,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    ...dashhy.value!.productsLowInStock!.map(
                                      (e) {
                                        var dateString = e.createdAt;
                                        var dateTime =
                                            DateTime.parse(dateString!);
                                        var formattedDate =
                                            DateFormat('dd MMM yyyy')
                                                .format(dateTime);

                                        var formattedTime =
                                            DateFormat('hh:mm a')
                                                .format(dateTime);
                                        // var disPrice = e.product!.price! * (e.product!.discount! / 100);
                                        // var price = e.product!.price! - disPrice;
                                        return SquareCard(
                                          sh: sh * 0.20,
                                          sw: sw * 0.45,
                                          image: '${e.imageUrl}',
                                          price: e.finalPrice!,
                                          item: e.name,
                                          quantity: e.quantityInStock,
                                          ontap: () => context.push(
                                              AppRoutes.ordersInfo,
                                              extra: e.id),
                                          // length: e.product!.specifications!.length,
                                          time: formattedTime,
                                          date: formattedDate,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            heightSpace(2),
                          ],
                        ),
                      ),
                    ),
            ),
          );
  }

  Container bookingStatusDiv(
      int? completed, Color txtColor, monthColor, bgColor, String txt) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
      height: 100,
      width: 50.w - 15,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: bgColor),
      child: Column(children: [
        customText(
          text: txt,
          fontSize: 12,
          textColor: AppColors.black,
          textAlignment: TextAlign.center,
        ),
        heightSpace(1),
        customText(text: "$completed", fontSize: 20, textColor: txtColor),
        heightSpace(1),
        Container(
          width: 90,
          height: 15,
          decoration: BoxDecoration(
              color: monthColor.withOpacity(.2),
              borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: customText(
                text: "This month", fontSize: 10, textColor: txtColor),
          ),
        )
      ]),
    );
  }

  Widget transactionBox() => Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: const BoxDecoration(
            border: Border(
                right: BorderSide(width: 2, color: AppColors.borderGrey))),
        child: Column(children: [
          customText(
              text: "Earnings", fontSize: 12, textColor: AppColors.textColor),
          heightSpace(2),
          customText(text: "N0k", fontSize: 30, textColor: AppColors.black),
          heightSpace(2),
          Container(
            width: 35.w,
            height: 4.h,
            decoration: BoxDecoration(
                color: AppColors.containerGrey,
                borderRadius: BorderRadius.circular(10)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              customText(text: "+0%", fontSize: 12, textColor: AppColors.green),
              widthSpace(1),
              customText(
                  text: "Since last month",
                  fontSize: 12,
                  textColor: AppColors.black),
            ]),
          )
        ]),
      );
}
