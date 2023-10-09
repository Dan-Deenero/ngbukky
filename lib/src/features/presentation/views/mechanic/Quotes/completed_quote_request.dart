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

class CompletedQuoteRequest extends StatefulWidget {
  const CompletedQuoteRequest({super.key});

  @override
  State<CompletedQuoteRequest> createState() => _CompletedQuoteRequestState();
}

class _CompletedQuoteRequestState extends State<CompletedQuoteRequest> {
  final MechanicRepo _mechanicRepo = MechanicRepo();
  List<QuotesModel> _quoteHistory = [];

  bool isLoading = true;
  List<Quotes>? quotes = [];

  QuotesModel? quoteModel;
  int price = 0;
  double serviceFee = 0;

  @override
  void initState() {
    super.initState();
    _mechanicRepo.getAllQuotes('completed').then((value) => setState(() {
          _quoteHistory = value;
          isLoading = false;
        }));
    // log(_bookingHistory.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            GestureDetector(
              onTap: () => context.push(AppRoutes.bookings),
              child: Container(
                height: 10.h,
                width: 10.w,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black),
                    color: AppColors.white.withOpacity(.5),
                    shape: BoxShape.circle),
                child: const Padding(
                  padding: EdgeInsets.only(left: 7.0),
                  child: Center(
                      child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.black,
                  )),
                ),
              ),
            ),
            customText(
                text: "Completed bookings",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: AppColors.black),
            heightSpace(1),
            bodyText("Bookings you have gotten payment for")
          ]),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
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
                                        'You have not gotten paid by any client yet',
                                    fontSize: 15,
                                    textColor: AppColors.black)
                              ],
                            ))
                      else
                        ..._quoteHistory.map((e) {
                          _mechanicRepo.getoneQuote(e.id).then(
                                (value) => setState(
                                  () {
                                    quoteModel = value;
                                    for (Quotes quote in quotes!) {
                                      if (quote.price != null) {
                                        price += quote.price!;
                                      }
                                    }
                                    serviceFee = price * 0.01;
                                  },
                                ),
                              );
                          var dateString = e.createdAt;
                          var dateTime = DateTime.parse(dateString!);
                          var formattedDate =
                              DateFormat('dd MMM yyyy').format(dateTime);

                          var formattedTime =
                              DateFormat('hh:mm a').format(dateTime);
                          return GestureDetector(
                            onTap: () {
                              context.push(AppRoutes.completedQuoteRequestDetails,
                                  extra: e.id);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              width: double.infinity,
                              height: 10.h,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ListTile(
                                  trailing: Column(children: [
                                    customText(
                                      text: '$price',
                                      fontSize: 14,
                                      textColor: AppColors.textGrey,
                                    ),
                                    heightSpace(1),
                                    Container(
                                      width: 28.w,
                                      height: 3.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              AppColors.green.withOpacity(.1)),
                                      child: Center(
                                        child: customText(
                                            text: "Accepted booking",
                                            fontSize: 10,
                                            textColor: AppColors.green),
                                      ),
                                    )
                                  ]),
                                  subtitle: Row(
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(AppImages.time),
                                          customText(
                                              text: formattedTime,
                                              fontSize: 10,
                                              textColor: AppColors.textGrey)
                                        ],
                                      ),
                                      widthSpace(1),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              AppImages.calendarIcon),
                                          customText(
                                              text: formattedDate,
                                              fontSize: 10,
                                              textColor: AppColors.textGrey)
                                        ],
                                      )
                                    ],
                                  ),
                                  title: customText(
                                      text: e.user!.username!,
                                      fontSize: 16,
                                      textColor: AppColors.black,
                                      fontWeight: FontWeight.bold),
                                  leading: Container(
                                    width: 8.w,
                                    height: 8.h,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.containerGrey),
                                  )),
                            ),
                          );
                        })
                    ],
                  ),
                ),
              ],
            )),
    );
  }
}
