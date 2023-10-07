import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/repository/auth_repository.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class HomeView extends HookWidget {
  static final MechanicRepo _mechanicRepo = MechanicRepo();
  static final AuthRepo _authRepo = AuthRepo();

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final pending = useState<int?>(0);
    final declined = useState<int?>(0);
    final completed = useState<int?>(0);

    final name = useState<String?>('Damini');

    var hour = DateTime.now().hour;
    String greetings = 'good morning';

    if (hour < 12) {
      greetings = 'Good Morning';
    } else if (hour < 17) {
      greetings = 'Good Afternoon';
    } else {
      greetings = 'Good Evening';
    }

    getUserProfile() {
      _authRepo.getMechanicProfile().then((value) {
        name.value = value.lastname!;
      });
    }

    getStatisticsInfo() {
      _mechanicRepo.getBookingStatisticsInfo().then((value) {
        pending.value = value.pENDING;
        declined.value = value.dECLINED;
        completed.value = value.cOMPLETED;
      });
    }

    final tabIndex = useState<int>(0);

    useEffect(() {
      getStatisticsInfo();
      getUserProfile();
      return null;
    }, []);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            12.h,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                      onTap: () => context.push(AppRoutes.notification),
                      child: SvgPicture.asset(AppImages.notification))
                ],
              ),
              heightSpace(2)
            ]),
          ),
        ),
        backgroundColor: AppColors.scaffoldColor,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 50, 20, 40),
                      height: 208,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.veryLightOrange),
                      child: Column(children: [
                        customText(
                            text: "Pending bookings",
                            fontSize: 12,
                            textColor: AppColors.black),
                        heightSpace(2),
                        customText(
                            text: "${pending.value}",
                            fontSize: 24,
                            textColor: AppColors.black),
                        heightSpace(2),
                        customText(
                            text: "Inspection and quote",
                            fontSize: 10,
                            textColor: AppColors.lightOrange)
                      ]),
                    ),
                  ),
                  widthSpace(1),
                  Expanded(
                    child: Column(
                      children: [
                        BookingStatusDiv(completed, AppColors.black,
                            AppColors.green, AppColors.white),
                        heightSpace(1),
                        BookingStatusDiv(declined, AppColors.red,
                            AppColors.lightOrange, AppColors.containerOrange),
                      ],
                    ),
                  )
                ],
              ),
              heightSpace(2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(
                      text: "New inspection booking",
                      fontSize: 15,
                      textColor: AppColors.primary),
                  Row(
                    children: [
                      customText(
                          text: "See all",
                          fontSize: 15,
                          textColor: AppColors.primary),
                      const Icon(Icons.arrow_forward)
                    ],
                  )
                ],
              ),
              heightSpace(4),
              Container(
                width: double.infinity,
                height: 10.h,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                    trailing: Column(children: [
                      Container(
                        width: 60,
                        height: 20,
                        decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: customText(
                            text: "New",
                            fontSize: 10,
                            textColor: AppColors.white,
                          ),
                        ),
                      ),
                      heightSpace(2.2),
                      customText(
                          text: "Car Insepection",
                          fontSize: 8,
                          textColor: AppColors.red),
                    ]),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heightSpace(.5),
                        customText(
                            text: "Camry Hybrid",
                            fontSize: 12,
                            textColor: AppColors.black),
                        heightSpace(.5),
                        Row(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(AppImages.time),
                                customText(
                                    text: "12:20pm",
                                    fontSize: 10,
                                    textColor: AppColors.textGrey)
                              ],
                            ),
                            widthSpace(2),
                            Row(
                              children: [
                                SvgPicture.asset(AppImages.calendarIcon),
                                customText(
                                    text: "12 Jun 2023",
                                    fontSize: 10,
                                    textColor: AppColors.textGrey)
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(top: 9),
                      child: customText(
                          text: "Toyota",
                          fontSize: 14,
                          textColor: AppColors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    leading: SvgPicture.asset(AppImages.carIcon)),
              ),
              heightSpace(4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(
                      text: "New Quote",
                      fontSize: 15,
                      textColor: AppColors.primary),
                  Row(
                    children: [
                      customText(
                          text: "See all",
                          fontSize: 15,
                          textColor: AppColors.primary),
                      const Icon(Icons.arrow_forward)
                    ],
                  )
                ],
              ),
              heightSpace(4),
              Container(
                padding: EdgeInsets.all(5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                    trailing: Column(children: [
                      Container(
                        width: 60,
                        height: 20,
                        decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: customText(
                            text: "New",
                            fontSize: 10,
                            textColor: AppColors.white,
                          ),
                        ),
                      ),
                      heightSpace(2.2),
                      customText(
                          text: "Car Insepection",
                          fontSize: 8,
                          textColor: AppColors.red),
                    ]),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heightSpace(.5),
                        customText(
                            text: "Camry Hybrid",
                            fontSize: 12,
                            textColor: AppColors.black),
                        heightSpace(.6),
                        Row(
                          children: [
                            SvgPicture.asset(AppImages.serviceIcon),
                            Flexible(
                              child: customText(
                                  text: "AC Maintenance, Engine sitting",
                                  fontSize: 10,
                                  textColor: AppColors.black),
                            )
                          ],
                        ),
                        heightSpace(.2),
                        Row(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(AppImages.time),
                                customText(
                                    text: "12:20pm",
                                    fontSize: 10,
                                    textColor: AppColors.textGrey)
                              ],
                            ),
                            widthSpace(2),
                            Row(
                              children: [
                                SvgPicture.asset(AppImages.calendarIcon),
                                customText(
                                    text: "12 Jun 2023",
                                    fontSize: 10,
                                    textColor: AppColors.textGrey)
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(top: 9),
                      child: customText(
                          text: "Toyota",
                          fontSize: 14,
                          textColor: AppColors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    leading: SvgPicture.asset(AppImages.carIcon)),
              ),
              heightSpace(4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(
                      text: "Recent activities",
                      fontSize: 15,
                      textColor: AppColors.primary),
                  Row(
                    children: [
                      customText(
                          text: "See all",
                          fontSize: 15,
                          textColor: AppColors.primary),
                      const Icon(Icons.arrow_forward)
                    ],
                  )
                ],
              ),
              heightSpace(2),
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
                        text: "Payment",
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
                        text: "Withdrawal",
                      ),
                    ),
                  ],
                ),
              ),
              heightSpace(4),
              SizedBox(
                height: 200,
                child: TabBarView(children: [
                  ListView(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 10.h,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                            trailing: Column(children: [
                              customText(
                                  text: "N5,050",
                                  fontSize: 14,
                                  textColor: AppColors.black,
                                  fontWeight: FontWeight.bold),
                              heightSpace(1),
                              Container(
                                width: 19.w,
                                height: 3.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.red.withOpacity(.3)),
                                child: Center(
                                  child: customText(
                                      text: "Cancelled",
                                      fontSize: 12,
                                      textColor: AppColors.red),
                                ),
                              )
                            ]),
                            subtitle: Row(
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(AppImages.time),
                                    customText(
                                        text: "12:20pm",
                                        fontSize: 10,
                                        textColor: AppColors.textGrey)
                                  ],
                                ),
                                widthSpace(2),
                                Row(
                                  children: [
                                    SvgPicture.asset(AppImages.calendarIcon),
                                    customText(
                                        text: "12 Jun 2023",
                                        fontSize: 10,
                                        textColor: AppColors.textGrey)
                                  ],
                                )
                              ],
                            ),
                            title: customText(
                                text: "Kels2323",
                                fontSize: 16,
                                textColor: AppColors.black,
                                fontWeight: FontWeight.bold),
                            leading: Container(
                              width: 10.w,
                              height: 10.h,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.containerGrey),
                            )),
                      ),
                    ],
                  ),
                  const Center(child: Text("BB"))
                ]),
              )
            ],
          ),
        )),
      ),
    );
  }

  Container BookingStatusDiv(
      ValueNotifier<int?> completed, Color txtColor, monthColor, bgColor) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: bgColor),
      child: Column(children: [
        customText(
            text: "Completed Bookings",
            fontSize: 12,
            textColor: AppColors.black,
            textAlignment: TextAlign.center,
        ),
        heightSpace(1),
        customText(
            text: "${completed.value}", fontSize: 20, textColor: txtColor),
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
