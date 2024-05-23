import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/quote_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class RQInspectionDetails extends StatefulWidget {
  final String id;
  const RQInspectionDetails({
    super.key,
    required this.id,
  });

  @override
  State<RQInspectionDetails> createState() => _RQInspectionDetailsState();
}

class _RQInspectionDetailsState extends State<RQInspectionDetails> {
  final MechanicRepo _mechanicRepo = MechanicRepo();

  bool isLoading = true;

  QuotesModel? quoteModel;
  List<Services>? quote = [];
  List<Quotes>? quotes = [];

  var dateString;
  var formattedDate;
  var formattedTime;
  var dateTime;

  int price = 0;
  double serviceFee = 0;
  Services? requestedSystemService;
  OtherServices? requestedPersonalisedService;

  @override
  void initState() {
    super.initState();
    _mechanicRepo.getoneQuote(widget.id).then((value) => setState(
          () {
            quoteModel = value;
            quote = quoteModel!.services!;
            isLoading = false;
            dateString = quoteModel!.createdAt!;
            dateTime = DateTime.parse(dateString);
            formattedDate = DateFormat('E, d MMM y').format(dateTime);

            formattedTime = DateFormat('hh:mm a').format(dateTime);
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

            bodyText(
              "View all necessary information about \nthis booking ",
            ),
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
                                text: 'Booking rejected',
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
                    ...quote!.map(
                      (quote) {
                        String serviceName = '';
                        serviceName = quote.name!;

                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(AppImages.serviceIcon),
                                    widthSpace(2),
                                    customText(
                                        text: serviceName,
                                        fontSize: 13,
                                        textColor: AppColors.black,
                                        fontWeight: FontWeight.w600),
                                  ],
                                ),
                              ],
                            ),
                            heightSpace(4),
                          ],
                        );
                      },
                    ),
                    heightSpace(1),
                    const Divider(),
                    customText(
                        text: "Schedule",
                        fontSize: 14,
                        textColor: AppColors.orange,
                        fontWeight: FontWeight.bold),
                    heightSpace(1),
                    ListTile(
                      leading: SvgPicture.asset(AppImages.calendarIcon),
                      title: customText(
                          text: formattedDate,
                          fontSize: 14,
                          textColor: AppColors.black,
                          fontWeight: FontWeight.bold),
                      subtitle: customText(
                          text: "Scheduled date",
                          fontSize: 12,
                          textColor: AppColors.textGrey),
                    ),
                    heightSpace(1),
                    ListTile(
                      leading: SvgPicture.asset(AppImages.time),
                      title: customText(
                          text: formattedTime,
                          fontSize: 14,
                          textColor: AppColors.black,
                          fontWeight: FontWeight.bold),
                      subtitle: customText(
                          text: "Scheduled time",
                          fontSize: 12,
                          textColor: AppColors.textGrey),
                    ),
                    heightSpace(2),
                  ],
                ),
              ),
            ),
    );
  }
}
