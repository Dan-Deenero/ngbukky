import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/controller/helpers.dart';
import 'package:ngbuka/src/domain/data/inspection_booking_model.dart';
import 'package:ngbuka/src/domain/data/notification_model.dart';
import 'package:ngbuka/src/domain/data/quote_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class NewNotification extends StatefulWidget {
  const NewNotification({super.key});

  @override
  State<NewNotification> createState() => _NewNotificationState();
}

class _NewNotificationState extends State<NewNotification> {
  final MechanicRepo _mechanicRepo = MechanicRepo();
  List<NotificationModel> _notificationHistory = [];
  NotificationModel? notifyModel;
  BookingModel? bookingModel;
  QuotesModel? quoteModel;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _mechanicRepo.getAllNotifications().then(
          (value) => setState(
            () {
              _notificationHistory = value;
              isLoading = false;
            },
          ),
        );
    // log(_bookingHistory.toString());
  }

  double calculateTextSize(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * percentage;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  if (_notificationHistory.isEmpty)
                    Center(
                      heightFactor: 3.0,
                      child: Column(
                        children: [
                          SvgPicture.asset(AppImages.bookingWarning),
                          customText(
                              text: 'No notification',
                              fontSize: 15,
                              textColor: AppColors.black,
                              textAlignment: TextAlign.center)
                        ],
                      ),
                    )
                  else
                    ..._notificationHistory.map(
                      (e) {
                        var dateString = e.createdAt!;
                        var dateTime = DateTime.parse(dateString);
                        var formattedDate =
                            DateFormat('dd MMM yyyy').format(dateTime);
                        var formattedTime =
                            DateFormat('hh:mm a').format(dateTime);
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _mechanicRepo.getOneNotification(e.id).then(
                                      (value) => setState(
                                        () {
                                          notifyModel = value;
                                          bookingModel = notifyModel!.booking;
                                          quoteModel =
                                              notifyModel!.quoteRequest;
                                          isLoading = false;
                                          Helpers
                                              .routeToRespectiveNotificationScreens(
                                            notifyModel,
                                            context,
                                          );
                                        },
                                      ),
                                    );
                              },
                              child: Container(
                                width: double.infinity,
                                // height: 120,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 20),
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: AppColors.containerGrey,
                                      offset: Offset(
                                        5.0,
                                        5.0,
                                      ),
                                      blurRadius: 10.0,
                                      spreadRadius: 2.0,
                                    ), //BoxShadow
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ), //BoxShadow
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.white,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(
                                        AppImages.notification,
                                        width: 30,
                                      ),
                                    ),
                                    widthSpace(2),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            customText(
                                              text: e.title!,
                                              fontSize: calculateTextSize(
                                                  context, 0.035),
                                              textColor: AppColors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            SizedBox(
                                              width: calculateTextSize(
                                                  context, 0.45),
                                              child: customText(
                                                  text: e.body!,
                                                  fontSize: calculateTextSize(
                                                      context, 0.03),
                                                  textColor:
                                                      AppColors.textGrey),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        AppImages.time),
                                                    customText(
                                                        text: formattedTime,
                                                        fontSize:
                                                            calculateTextSize(
                                                                context, 0.025),
                                                        textColor:
                                                            AppColors.textGrey)
                                                  ],
                                                ),
                                                widthSpace(.5),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        AppImages.calendarIcon),
                                                    customText(
                                                        text: formattedDate,
                                                        fontSize:
                                                            calculateTextSize(
                                                                context, 0.025),
                                                        textColor:
                                                            AppColors.textGrey)
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    // widthSpace(2),
                                  ],
                                ),
                              ),
                            ),
                            heightSpace(1)
                          ],
                        );
                      },
                    ),
                ],
              ),
            ),
          );
  }
}

class ReadNotification extends StatefulWidget {
  const ReadNotification({super.key});

  @override
  State<ReadNotification> createState() => _ReadNotificationState();
}

class _ReadNotificationState extends State<ReadNotification> {
  final MechanicRepo _mechanicRepo = MechanicRepo();
  List<NotificationModel> _notificationHistory = [];
  NotificationModel? notifyModel;
  BookingModel? bookingModel;
  QuotesModel? quoteModel;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _mechanicRepo.getAllSeenNotifications().then(
          (value) => setState(
            () {
              _notificationHistory = value;
              isLoading = false;
            },
          ),
        );
    // log(_bookingHistory.toString());
  }

  double calculateTextSize(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * percentage;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  if (_notificationHistory.isEmpty)
                    Center(
                      heightFactor: 3.0,
                      child: Column(
                        children: [
                          SvgPicture.asset(AppImages.bookingWarning),
                          customText(
                              text: 'No notification',
                              fontSize: 15,
                              textColor: AppColors.black,
                              textAlignment: TextAlign.center)
                        ],
                      ),
                    )
                  else
                    ..._notificationHistory.map(
                      (e) {
                        var dateString = e.createdAt!;
                        var dateTime = DateTime.parse(dateString);
                        var formattedDate =
                            DateFormat('dd MMM yyyy').format(dateTime);

                        var formattedTime =
                            DateFormat('hh:mm a').format(dateTime);
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _mechanicRepo.getOneNotification(e.id).then(
                                      (value) => setState(
                                        () {
                                          notifyModel = value;
                                          bookingModel = notifyModel!.booking;
                                          quoteModel =
                                              notifyModel!.quoteRequest;
                                          isLoading = false;

                                          Helpers.routeToRespectiveNotificationScreens(
                                            notifyModel,
                                            context,
                                          );
                                        },
                                      ),
                                    );
                              },
                              child: Container(
                                width: double.infinity,
                                // height: 120,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 20),
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: AppColors.containerGrey,
                                      offset: Offset(
                                        5.0,
                                        5.0,
                                      ),
                                      blurRadius: 10.0,
                                      spreadRadius: 2.0,
                                    ), //BoxShadow
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ), //BoxShadow
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.white,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(
                                        AppImages.notification,
                                        width: 30,
                                      ),
                                    ),
                                    widthSpace(2),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            customText(
                                              text: e.title!,
                                              fontSize: calculateTextSize(
                                                  context, 0.035),
                                              textColor: AppColors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            SizedBox(
                                              width: calculateTextSize(
                                                  context, 0.45),
                                              child: customText(
                                                  text: e.body!,
                                                  fontSize: calculateTextSize(
                                                      context, 0.03),
                                                  textColor:
                                                      AppColors.textGrey),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        AppImages.time),
                                                    customText(
                                                        text: formattedTime,
                                                        fontSize:
                                                            calculateTextSize(
                                                                context, 0.025),
                                                        textColor:
                                                            AppColors.textGrey)
                                                  ],
                                                ),
                                                widthSpace(.5),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        AppImages.calendarIcon),
                                                    customText(
                                                        text: formattedDate,
                                                        fontSize:
                                                            calculateTextSize(
                                                                context, 0.025),
                                                        textColor:
                                                            AppColors.textGrey)
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    // widthSpace(2),
                                  ],
                                ),
                              ),
                            ),
                            heightSpace(1)
                          ],
                        );
                      },
                    ),
                ],
              ),
            ),
          );
  }
}

class Notification extends HookWidget {
  const Notification({super.key});

  @override
  Widget build(BuildContext context) {
    final tabIndex = useState<int>(0);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(29.h),
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                    text: "Notification",
                    fontSize: 25,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.bold),
                heightSpace(1),
                customText(
                    text: "You will see all your day to day activities",
                    fontSize: 12,
                    textColor: AppColors.textGrey),
                heightSpace(1),
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.borderGrey,
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
                            color: tabIndex.value == 0
                                ? AppColors.white
                                : AppColors.borderGrey,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Tab(
                          text: "New notification",
                        ),
                      ),
                      Container(
                        width: 400,
                        height: 40,
                        decoration: BoxDecoration(
                            color: tabIndex.value == 1
                                ? AppColors.white
                                : AppColors.borderGrey,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Tab(
                          text: "Read",
                        ),
                      ),
                    ],
                  ),
                ),
                heightSpace(2),
                const Divider(),
                heightSpace(1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.containerGrey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SvgPicture.asset(AppImages.sort),
                          customText(
                              text: "New to old",
                              fontSize: 12,
                              textColor: AppColors.black)
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.containerGrey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SvgPicture.asset(AppImages.filter),
                          customText(
                              text: "All",
                              fontSize: 12,
                              textColor: AppColors.black)
                        ],
                      ),
                    ),
                  ],
                ),
                heightSpace(1),
                const Divider()
              ],
            ),
          ),
        ),
        body: const Column(
          children: [
            Expanded(
                child: TabBarView(
                    children: [NewNotification(), ReadNotification()]))
          ],
        ),
      ),
    );
  }
}
