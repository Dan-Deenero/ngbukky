import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ngbuka/src/config/keys/app_keys.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/config/locator/app_locator.dart';
import 'package:ngbuka/src/config/services/storage_service.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/inspection_booking_model.dart';
import 'package:ngbuka/src/domain/data/quote_model.dart';
import 'package:ngbuka/src/domain/data/transaction_model.dart';
import 'package:ngbuka/src/domain/repository/auth_repository.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/features/presentation/widgets/wallet_tile.dart';

class HomeView extends HookWidget {
  static final MechanicRepo _mechanicRepo = MechanicRepo();
  static final AuthRepo _authRepo = AuthRepo();

  HomeView({Key? key}) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    final pending = useState<int?>(0);
    final declined = useState<int?>(0);
    final completed = useState<int?>(0);
    final pending2 = useState<int?>(0);
    final declined2 = useState<int?>(0);
    final completed2 = useState<int?>(0);
    final pending3 = useState<int?>(0);
    final declined3 = useState<int?>(0);
    final completed3 = useState<int?>(0);
    final bookingHistory = useState<List<BookingModel>>([]);
    final quoteHistory = useState<List<QuotesModel>>([]);

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

    Future<dynamic> getUserProfile() async {
      await _authRepo.getMechanicProfile().then((value) {
        name.value = value.lastname!;
      });
      locator<LocalStorageService>()
              .saveDataToDisk(AppKeys.userType, 'mechanic');
    }

    Future<dynamic> getStatisticsInfo() async {
      await _mechanicRepo.getBookingStatisticsInfo().then(
        (value) {
          pending.value = value.pENDING!;
          declined.value = value.dECLINED!;
          completed.value = value.cOMPLETED!;
        },
      );
      await _mechanicRepo.getQuoteStatisticsInfo().then(
        (value) {
          pending2.value = value.pENDING!;
          declined2.value = value.dECLINED;
          completed2.value = value.cOMPLETED;
          pending3.value = (pending.value ?? 0) + (pending2.value ?? 0);
          declined3.value = (declined.value ?? 0) + (declined2.value ?? 0);
          completed3.value = (completed.value ?? 0) + (completed2.value ?? 0);
        },
      );
    }

    Future<dynamic> getNewBookings() async {
      await _mechanicRepo.get5bookingAlert('pending').then(
        (value) {
          bookingHistory.value = value;
        },
      );
    }

    Future<dynamic> getNewQuotes() async {
      await _mechanicRepo.get5QuotesAlert('pending').then(
        (value) {
          quoteHistory.value = value;
        },
      );
    }

    final isLoading = useState<bool>(true);

    final tabIndex = useState<int>(0);

    useEffect(() {
      void refresh() async {
        isLoading.value = true;
        await getStatisticsInfo();
        await getNewBookings();
        await getNewQuotes();
        await getUserProfile();
        isLoading.value = false;
      }

      refresh();
      return null;
    }, [isLoading]);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            8.h,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 40,
              left: 20,
              right: 20,
            ),
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
                      onTap: () => context.push(AppRoutes.notification),
                      child: SvgPicture.asset(AppImages.notification),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        backgroundColor: AppColors.scaffoldColor,
        body: RefreshIndicator(
          onRefresh: () async {
            isLoading.value = true;
            await getStatisticsInfo();
            await getNewBookings();
            await getNewQuotes();
            await getUserProfile();
            isLoading.value = false;
          },
          child: isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 50, 20, 40),
                                width: 50.w - 40,
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
                                      text: "${pending3.value}",
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
                            widthSpace(3),
                            Expanded(
                              child: Column(
                                children: [
                                  bookingStatusDiv(
                                    completed3,
                                    AppColors.black,
                                    AppColors.green,
                                    AppColors.white,
                                    'Completed Bookings',
                                  ),
                                  heightSpace(1),
                                  bookingStatusDiv(
                                    declined3,
                                    AppColors.red,
                                    AppColors.lightOrange,
                                    AppColors.containerOrange,
                                    'Declined bookings',
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
                              text: "Inspection booking alerts",
                              fontSize: 15,
                              textColor: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                            if (bookingHistory.value.isEmpty)
                              IgnorePointer(
                                ignoring: true,
                                child: Row(
                                  children: [
                                    customText(
                                      text: "See all",
                                      fontSize: 15,
                                      textColor:
                                          AppColors.primary.withOpacity(0.1),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      size: 20,
                                      color: AppColors.primary.withOpacity(0.1),
                                    )
                                  ],
                                ),
                              )
                            else
                              GestureDetector(
                                onTap: () =>
                                    context.push(AppRoutes.bookingAlert),
                                child: Row(
                                  children: [
                                    customText(
                                        text: "See all",
                                        fontSize: 15,
                                        textColor: AppColors.primary),
                                    const Icon(
                                      Icons.arrow_forward,
                                      size: 20,
                                    )
                                  ],
                                ),
                              )
                          ],
                        ),
                        heightSpace(4),
                        if (bookingHistory.value.isEmpty)
                          Center(
                            child: Column(
                              children: [
                                SvgPicture.asset(AppImages.nobookingicon),
                                heightSpace(1),
                                SizedBox(
                                  width: 130,
                                  child: customText(
                                    text: 'You do not have any booking yet',
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
                          ...bookingHistory.value.map(
                            (e) {
                              var dateString = e.date;
                              var dateTime = DateTime.parse(dateString!);
                              var formattedDate =
                                  DateFormat('dd MMM yyyy').format(dateTime);
                              var formattedTime =
                                  DateFormat('hh:mm a').format(dateTime);
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () => context.push(
                                        AppRoutes.inspectionBooking,
                                        extra: e.id),
                                    child: Card(
                                      color: AppColors.white,
                                      surfaceTintColor: Colors.transparent,
                                      child: ListTile(
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            heightSpace(.5),
                                            customText(
                                                text: '${e.model}, ${e.year}',
                                                fontSize: 12,
                                                textColor: AppColors.black),
                                            heightSpace(.5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                            AppImages.time),
                                                        customText(
                                                          text: formattedTime,
                                                          fontSize: 10,
                                                          textColor: AppColors
                                                              .textGrey,
                                                        )
                                                      ],
                                                    ),
                                                    widthSpace(1),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                            AppImages
                                                                .calendarIcon),
                                                        customText(
                                                            text: formattedDate,
                                                            fontSize: 10,
                                                            textColor: AppColors
                                                                .textGrey)
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                customText(
                                                  text: "Car Insepection",
                                                  fontSize: 3.w,
                                                  textColor: AppColors.red,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            customText(
                                                text: e.brand!,
                                                fontSize: 14,
                                                textColor: AppColors.black,
                                                fontWeight: FontWeight.bold),
                                            Container(
                                              width: 60,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: AppColors.green,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Center(
                                                child: customText(
                                                  text: "New",
                                                  fontSize: 10,
                                                  textColor: AppColors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        leading:
                                            SvgPicture.asset(AppImages.carIcon),
                                      ),
                                    ),
                                  ),
                                  heightSpace(1),
                                ],
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
                              text: "New Quote",
                              fontSize: 15,
                              textColor: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                            if (quoteHistory.value.isEmpty)
                              IgnorePointer(
                                ignoring: true,
                                child: Row(
                                  children: [
                                    customText(
                                      text: "See all",
                                      fontSize: 15,
                                      textColor:
                                          AppColors.primary.withOpacity(0.1),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      size: 20,
                                      color: AppColors.primary.withOpacity(0.1),
                                    )
                                  ],
                                ),
                              )
                            else
                              GestureDetector(
                                onTap: () =>
                                    context.push(AppRoutes.newQuoteAlert),
                                child: Row(
                                  children: [
                                    customText(
                                        text: "See all",
                                        fontSize: 15,
                                        textColor: AppColors.primary),
                                    const Icon(
                                      Icons.arrow_forward,
                                      size: 20,
                                    )
                                  ],
                                ),
                              )
                          ],
                        ),
                        heightSpace(4),
                        if (quoteHistory.value.isEmpty)
                          Center(
                            child: Column(
                              children: [
                                SvgPicture.asset(AppImages.noquoteicon),
                                heightSpace(1),
                                SizedBox(
                                  width: 120,
                                  child: customText(
                                    text: 'No quote request yet',
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
                          ...quoteHistory.value.map(
                            (e) {
                              var dateString = e.createdAt;
                              var dateTime = DateTime.parse(dateString!);
                              var formattedDate =
                                  DateFormat('dd MMM yyyy').format(dateTime);

                              var formattedTime =
                                  DateFormat('hh:mm a').format(dateTime);

                              var names = e.services!.map((service) {
                                return "${service.name}";
                              }).toList();
                              String serviceNames = names.join(', ');

                              return GestureDetector(
                                onTap: () => context
                                    .push(AppRoutes.quoteRequest, extra: e.id),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(10),
                                  width: double.infinity,
                                  // height: 12.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              AppImages.carIcon,
                                              width: 30,
                                            ),
                                            widthSpace(2),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                customText(
                                                    text: e.brand!,
                                                    fontSize: 15,
                                                    textColor: AppColors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                heightSpace(.5),
                                                customText(
                                                    text:
                                                        '${e.model}, ${e.year}',
                                                    fontSize: 13,
                                                    textColor: AppColors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                heightSpace(1),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        AppImages.serviceIcon),
                                                    widthSpace(1),
                                                    SizedBox(
                                                      width: 150,
                                                      child: customText(
                                                          text: serviceNames,
                                                          fontSize: 10,
                                                          textColor:
                                                              AppColors.black),
                                                    )
                                                  ],
                                                ),
                                                heightSpace(1),
                                                Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                            AppImages.time),
                                                        customText(
                                                            text: formattedTime,
                                                            fontSize: 10,
                                                            textColor: AppColors
                                                                .textGrey)
                                                      ],
                                                    ),
                                                    widthSpace(2),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                            AppImages
                                                                .calendarIcon),
                                                        customText(
                                                            text: formattedDate,
                                                            fontSize: 10,
                                                            textColor: AppColors
                                                                .textGrey)
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 60,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: AppColors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Center(
                                                  child: customText(
                                                    text: "New",
                                                    fontSize: 10,
                                                    textColor: AppColors.white,
                                                  ),
                                                ),
                                              ),
                                              heightSpace(7),
                                              customText(
                                                  text: "Quote Request",
                                                  fontSize: 12,
                                                  textColor: AppColors.orange,
                                                  fontWeight: FontWeight.w600),
                                            ]),
                                      ]),
                                ),
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
                        IndexedStack(
                          index: tabIndex.value,
                          children: const [
                            PaymentTab(),
                            WithdrawalTab(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Container bookingStatusDiv(ValueNotifier<int?> completed, Color txtColor,
      monthColor, bgColor, String txt) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
      width: 50.w - 15,
      height: 100,
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

class PaymentTab extends HookWidget {
  const PaymentTab({super.key});
  static final MechanicRepo mechanicRepo = MechanicRepo();

  @override
  Widget build(BuildContext context) {
    final transactionHistory = useState<List<TransactionModel>>([]);
    final isLoading = useState<bool>(true);
    getTransaction() {
      mechanicRepo.getAllTransaction('credit').then(
        (value) {
          transactionHistory.value = value;
          isLoading.value = false;
        },
      );
    }

    useEffect(() {
      getTransaction();
      return null;
    }, [transactionHistory.value.length]);
    return isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              if (transactionHistory.value.isEmpty)
                Center(
                  child: Column(
                    children: [
                      SvgPicture.asset(AppImages.nopaymenticon),
                      heightSpace(1),
                      SizedBox(
                        width: 130,
                        child: customText(
                          text: 'No payments were made to you',
                          fontSize: 15,
                          textColor: AppColors.textGrey.withOpacity(0.3),
                          textAlignment: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                )
              else
                ...transactionHistory.value.map(
                  (e) {
                    var dateString = e.createdAt;
                    var dateTime = DateTime.parse(dateString!);
                    var formattedDate =
                        DateFormat('dd MMM yyyy').format(dateTime);

                    var formattedTime = DateFormat('hh:mm a').format(dateTime);
                    return Column(
                      children: [
                        WalletTile(
                          id: e.id,
                          isWithdrawal: false,
                          isMechanic: true,
                          date: formattedDate,
                          amount: e.amount,
                          status: e.status,
                          time: formattedTime,
                        ),
                        heightSpace(2)
                      ],
                    );
                  },
                )
            ],
          );
  }
}

class WithdrawalTab extends HookWidget {
  const WithdrawalTab({super.key});
  static final MechanicRepo mechanicRepo = MechanicRepo();

  @override
  Widget build(BuildContext context) {
    final transactionHistory = useState<List<TransactionModel>>([]);
    final isLoading = useState<bool>(true);
    getTransaction() {
      mechanicRepo.getAllTransaction('debit').then(
        (value) {
          transactionHistory.value = value;
          isLoading.value = false;
        },
      );
    }

    useEffect(() {
      getTransaction();
      return null;
    }, [transactionHistory.value.length]);
    return isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              if (transactionHistory.value.isEmpty)
                Center(
                  child: Column(
                    children: [
                      SvgPicture.asset(AppImages.nopaymenticon),
                      heightSpace(1),
                      SizedBox(
                        width: 130,
                        child: customText(
                          text: 'No payments were made to you',
                          fontSize: 15,
                          textColor: AppColors.textGrey.withOpacity(0.3),
                          textAlignment: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                )
              else
                ...transactionHistory.value.map(
                  (e) {
                    var dateString = e.createdAt;
                    var dateTime = DateTime.parse(dateString!);
                    var formattedDate =
                        DateFormat('dd MMM yyyy').format(dateTime);

                    var formattedTime = DateFormat('hh:mm a').format(dateTime);
                    return Column(
                      children: [
                        WalletTile(
                          id: e.id,
                          isWithdrawal: true,
                          isMechanic: true,
                          date: formattedDate,
                          amount: e.amount,
                          status: e.status,
                          time: formattedTime,
                        ),
                        heightSpace(2)
                      ],
                    );
                  },
                )
            ],
          );
  }
}
