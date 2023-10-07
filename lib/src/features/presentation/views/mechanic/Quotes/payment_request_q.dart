import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/quote_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class QPaymentRequest extends StatefulWidget {
  const QPaymentRequest({super.key});

  @override
  State<QPaymentRequest> createState() => _QPaymentRequestState();
}

class _QPaymentRequestState extends State<QPaymentRequest> {
  final MechanicRepo _mechanicRepo = MechanicRepo();
  List<QuotesModel> _quoteHistory = [];
  List<QuotesModel> _quoteHistory2 = [];

  bool isLoading = true;
  List<Quotes>? quotes = [];

  QuotesModel? quoteModel;
  int price = 0;
  double serviceFee = 0;

  @override
  void initState() {
    super.initState();
    _mechanicRepo.getAllQuotes('bargaining').then(
          (value) => setState(() {
            _quoteHistory = value;
            isLoading = false;
          }),
        );
    _mechanicRepo.getAllQuotes('awaiting payment').then(
          (value) => setState(() {
            _quoteHistory2 = value;
            isLoading = false;
          }),
        );
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
            GestureDetector(
              onTap: () => context.go(AppRoutes.bookings),
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
                text: "Payment request",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: AppColors.black),
            heightSpace(1),
            bodyText("View all quotes awaiting payment request")
          ]),
        ),
      ),
      backgroundColor: AppColors.backgroundGrey,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
              children: [
                if (_quoteHistory.isEmpty && _quoteHistory2.isEmpty)
                  Center(
                      heightFactor: 3.5,
                      child: Column(
                        children: [
                          SvgPicture.asset(AppImages.bookingWarning),
                          customText(
                              text:
                                  'You do not have any booking awaiting client approval',
                              fontSize: 15,
                              textColor: AppColors.black,
                              textAlignment: TextAlign.center)
                        ],
                      ))
                else
                  ..._quoteHistory.map(
                    (e) {
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
                      return GestureDetector(
                        onTap: () => context
                            .push(AppRoutes.pendingQuotePaymentRequestDetails, extra: e.id),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            width: double.infinity,
                            height: 10.h,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    customText(
                                        text: "Due: N5,050",
                                        fontSize: 15,
                                        textColor: AppColors.orange),
                                    Container(
                                      width: 37.w,
                                      height: 3.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.containerGrey),
                                      child: Center(
                                        child: customText(
                                            text: "Pending payment request",
                                            fontSize: 10,
                                            textColor: AppColors.black),
                                      ),
                                    )
                                  ],
                                ),
                                title: customText(
                                    text: e.user!.username!,
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
                        ),
                      );
                    },
                  ),
                ..._quoteHistory2.map((e) {
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
                  return GestureDetector(
                    onTap: () => context.push(AppRoutes.quotePaymentRequestDetails,
                        extra: e.id),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        width: double.infinity,
                        height: 10.h,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customText(
                                    text: "Due: N5,050",
                                    fontSize: 15,
                                    textColor: AppColors.orange),
                                Container(
                                  width: 37.w,
                                  height: 3.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.containerGrey),
                                  child: Center(
                                    child: customText(
                                        text: "Pending payment request",
                                        fontSize: 10,
                                        textColor: AppColors.black),
                                  ),
                                )
                              ],
                            ),
                            title: customText(
                                text: e.user!.username!,
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
                    ),
                  );
                })
              ],
            )),
    );
  }
}
