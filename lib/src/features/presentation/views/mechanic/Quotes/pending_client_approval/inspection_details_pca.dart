import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
// import 'package:ngbuka/src/domain/data/inspection_booking_model.dart';
import 'package:ngbuka/src/domain/data/quote_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class PCAInspectionDetails extends StatefulWidget {
  final String id;
  const PCAInspectionDetails({
    super.key,
    required this.id,
  });

  @override
  State<PCAInspectionDetails> createState() => _PCAInspectionDetailsState();
}

class _PCAInspectionDetailsState extends State<PCAInspectionDetails> {
  final MechanicRepo _mechanicRepo = MechanicRepo();

  bool isLoading = true;

  QuotesModel? quoteModel;

  int? totalPrice;
  List<Services>? quote = [];
  List<Services>? otherQuote = [];
  List<Services>? serviceTogether = [];

  int price = 0;
  double serviceFee = 0;


  @override
  void initState() {
    
    super.initState();
    _mechanicRepo.getoneQuote(widget.id).then((value) => setState(
          () {
            quoteModel = value;
            isLoading = false;
            quote = quoteModel!.services!;
            otherQuote = quoteModel!.otherServices!;
            serviceTogether = quote! + otherQuote!;
            for (Quotes quote in quoteModel!.quotes!) {
              if (quote.price != null) {
                price += quote.price!;
              }
            }
            serviceFee = price * 0.01;
          },
        ));
  }

  // void resendOTP() async {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: AppColors.backgroundGrey,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText(
              text: "Inspection details",
              fontSize: 24,
              fontWeight: FontWeight.bold,
              textColor: AppColors.black,
            ),
            // heightSpace(1),
            bodyText("View all necessary information \nabout this booking ")
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            height: 12.h,
            width: 10.w,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.black),
                color: AppColors.white.withOpacity(.5),
                shape: BoxShape.circle),
            child: Padding(
              padding: const EdgeInsets.only(),
              child: Center(
                  child: GestureDetector(
                onTap: () => context.pop(),
                child: const Icon(
                  Icons.close,
                  color: AppColors.black,
                ),
              )),
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heightSpace(2),
                    Row(
                      children: [
                        widthSpace(5.5),
                        SvgPicture.asset(AppImages.hourGlass),
                        widthSpace(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText(
                                text: 'Review & Dispute',
                                fontSize: 14,
                                textColor: AppColors.red,
                                fontWeight: FontWeight.w600),
                            customText(
                                text: 'Booking status',
                                fontSize: 12,
                                textColor: AppColors.textGrey)
                          ],
                        )
                      ],
                    ),
                    heightSpace(2),
                    customText(
                        text: "Personal",
                        fontSize: 14,
                        textColor: AppColors.orange,
                        fontWeight: FontWeight.bold),
                    heightSpace(1),
                    ListTile(
                      leading: SvgPicture.asset(AppImages.profile),
                      title: customText(
                          text: quoteModel!.user!.username!,
                          fontSize: 14,
                          textColor: AppColors.black,
                          fontWeight: FontWeight.bold),
                      subtitle: customText(
                          text: "Client name",
                          fontSize: 12,
                          textColor: AppColors.textGrey),
                    ),
                    heightSpace(1),
                    ListTile(
                      leading: SvgPicture.asset(AppImages.locationIcon),
                      title: customText(
                          text: quoteModel!.user!.address!,
                          fontSize: 14,
                          textColor: AppColors.black,
                          fontWeight: FontWeight.bold),
                      subtitle: customText(
                          text: "Location",
                          fontSize: 12,
                          textColor: AppColors.textGrey),
                    ),
                    heightSpace(1),
                    ListTile(
                      leading: SvgPicture.asset(AppImages.calendarIcon),
                      title: customText(
                          text: quoteModel!.brand!,
                          fontSize: 14,
                          textColor: AppColors.black,
                          fontWeight: FontWeight.bold),
                      subtitle: customText(
                          text: 'Car brand',
                          fontSize: 12,
                          textColor: AppColors.textGrey),
                    ),
                    ListTile(
                      leading: SvgPicture.asset(AppImages.calendarIcon),
                      title: customText(
                          text: "${quoteModel!.model!}, ${quoteModel!.year!}",
                          fontSize: 14,
                          textColor: AppColors.black,
                          fontWeight: FontWeight.bold),
                      subtitle: customText(
                          text: 'Car model',
                          fontSize: 12,
                          textColor: AppColors.textGrey),
                    ),
                    heightSpace(1),
                    ListTile(
                      leading: SvgPicture.asset(AppImages.carIcon),
                      title: customText(
                          text: '${quoteModel!.year!}',
                          fontSize: 14,
                          textColor: AppColors.black,
                          fontWeight: FontWeight.bold),
                      subtitle: customText(
                          text: "Year of manufacture",
                          fontSize: 12,
                          textColor: AppColors.textGrey),
                    ),
                    const Divider(),
                    customText(
                        text: "Service rendered",
                        fontSize: 14,
                        textColor: AppColors.orange,
                        fontWeight: FontWeight.bold),
                    heightSpace(3),
                    Column(
                      children: [
                        ...serviceTogether!.map(
                          (qte) {
                            return Row(
                              children: [
                                SvgPicture.asset(AppImages.serviceIcon),
                                widthSpace(2),
                                customText(
                                    text: qte.name!,
                                    fontSize: 13,
                                    textColor: AppColors.black,
                                    fontWeight: FontWeight.w600),
                                heightSpace(4),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    heightSpace(1),
                    const Divider(),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customText(
                                text: 'Sub-total (₦)',
                                fontSize: 13,
                                textColor: AppColors.black),
                            customText(
                                text: '$price',
                                fontSize: 13,
                                textColor: AppColors.black)
                          ],
                        ),
                        heightSpace(2),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     customText(
                        //         text: 'Ngbuka Charge (1%)',
                        //         fontSize: 13,
                        //         textColor: AppColors.black),
                        //     customText(
                        //         text: '$serviceFee',
                        //         fontSize: 13,
                        //         textColor: AppColors.black)
                        //   ],
                        // ),
                        heightSpace(2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customText(
                                text: 'Total',
                                fontSize: 13,
                                textColor: AppColors.black,
                                fontWeight: FontWeight.w600),
                            customText(
                                text: '$price',
                                fontSize: 13,
                                textColor: AppColors.black,
                                fontWeight: FontWeight.w600)
                          ],
                        )
                      ],
                    ),
                    heightSpace(2),
                  ],
                ),
              ),
            ),
    );
  }
}
