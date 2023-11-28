import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/quote_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class NewQuoteAlert extends StatefulWidget {
  const NewQuoteAlert({super.key});

  @override
  State<NewQuoteAlert> createState() => _NewQuoteAlertState();
}

class _NewQuoteAlertState extends State<NewQuoteAlert> {
  final MechanicRepo _mechanicRepo = MechanicRepo();
  List<QuotesModel> _quoteHistory = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _mechanicRepo.getAllQuotes('pending').then((value) => setState(() {
          _quoteHistory = value;
          isLoading = false;
        }));
    // log(_bookingHistory.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(20.h),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 10.h,
                width: 10.w,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black),
                    color: AppColors.white.withOpacity(.5),
                    shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.only(left: 7.0),
                  child: Center(
                      child: GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.black,
                    ),
                  )),
                ),
              ),
              customText(
                  text: "New Quote alerts",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.black),
              heightSpace(1),
              bodyText("View,accept or reject booking")
            ]),
          ),
        ),
        backgroundColor: AppColors.scaffoldColor,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: AppColors.containerGrey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Wrap(
                        children: [
                          if (_quoteHistory.isEmpty)
                            Center(
                                heightFactor: 3.5,
                                child: Column(
                                  children: [
                                    SvgPicture.asset(AppImages.bookingWarning),
                                    customText(
                                        text:
                                            'There are no new Quote booking requests',
                                        fontSize: 15,
                                        textColor: AppColors.black,
                                        textAlignment: TextAlign.center)
                                  ],
                                ))
                          else
                            ..._quoteHistory.map((e) {
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
                                                          AppImages.time,
                                                        ),
                                                        customText(
                                                          text: formattedTime,
                                                          fontSize: 10,
                                                          textColor: AppColors
                                                              .textGrey,
                                                        )
                                                      ],
                                                    ),
                                                    widthSpace(2),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          AppImages
                                                              .calendarIcon,
                                                        ),
                                                        customText(
                                                          text: formattedDate,
                                                          fontSize: 10,
                                                          textColor: AppColors
                                                              .textGrey,
                                                        ),
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
                            }),
                          heightSpace(3)
                        ],
                      ),
                    )
                  ],
                ),
              ));
  }
}
