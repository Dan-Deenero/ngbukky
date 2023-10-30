import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

Widget transactionBox(String heading, String time) => Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          customText(
              text: heading, fontSize: 10, textColor: AppColors.textColor),
          heightSpace(1),
          customText(text: "₦0", fontSize: 24, textColor: AppColors.black),
          heightSpace(1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            // width: 35.w,
            height: 2.h,
            decoration: BoxDecoration(
                color: AppColors.containerGrey,
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  BootstrapIcons.arrow_down,
                  color: AppColors.green,
                  size: 10,
                ),
                widthSpace(1),
                customText(
                    text: time, fontSize: 10, textColor: AppColors.black),
              ],
            ),
          ),
        ],
      ),
    );

class Wallet extends HookWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    accept() {
      showDialog(
        context: context,
        builder: (context) => Center(
          child: Container(
            // padding: EdgeInsets.all(10.0),
            width: 700, // Set the desired width
            height: 200,
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0), // Adjust the radius as needed
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText(
                            text: 'Withdraw funds',
                            fontSize: 20,
                            textColor: AppColors.textGrey,
                            fontWeight: FontWeight.w500,
                            textAlignment: TextAlign.start),
                        InkWell(
                            onTap: () => context.pop(),
                            child: SvgPicture.asset(AppImages.cancelModal))
                      ],
                    ),
                  ),
                  heightSpace(1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        customText(
                          text: 'Set up your local bank account ',
                          fontSize: 12,
                          textColor: AppColors.black,
                          textAlignment: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  heightSpace(3),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () => context.pop(),
                            child: customText(
                                text: 'Cancel',
                                fontSize: 16,
                                textColor: AppColors.textGrey)),
                        widthSpace(3),
                        Container(
                          width: 1,
                          height: 40,
                          color: AppColors.containerGrey,
                        ),
                        widthSpace(3),
                        TextButton(
                            onPressed: () =>
                                context.push(AppRoutes.localAccountSetup),
                            child: customText(
                                text: 'Continue',
                                fontSize: 16,
                                textColor: AppColors.darkOrange))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    final tabIndex = useState<int>(0);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        appBar: AppBar(
          toolbarHeight: 120,
          backgroundColor: AppColors.backgroundGrey,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                  text: "Wallet",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.black),
              // heightSpace(1),
              bodyText("View analytics and withdraw from your wallet")
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: SvgPicture.asset(AppImages.notification),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                height: 20.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          AppImages.walletbase,
                        ))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customText(
                        text: "Total Balance",
                        fontSize: 15,
                        textColor: AppColors.white),
                    customText(
                        text: "₦0",
                        fontSize: 32,
                        textColor: AppColors.white,
                        fontWeight: FontWeight.bold),
                    heightSpace(1),
                    GestureDetector(
                      onTap: () => accept(),
                      child: SvgPicture.asset(AppImages.welcomeImage),
                    ),
                    // heightSpace(2),
                  ],
                ),
              ),
              heightSpace(2),
              SizedBox(
                height: 14.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    transactionBox("Total Earnings", "This year"),
                    verticalDivide(),
                    transactionBox("Earned", "This month"),
                    verticalDivide(),
                    transactionBox("Withdrawn", "This month")
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(
                      text: "History",
                      fontSize: 15,
                      textColor: AppColors.black,
                      fontWeight: FontWeight.bold),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.push(AppRoutes.walletHistory),
                        child: customText(
                            text: "See all",
                            fontSize: 15,
                            textColor: AppColors.textGrey),
                      ),
                      widthSpace(1),
                      SvgPicture.asset(AppImages.rightArrow)
                    ],
                  )
                ],
              ),
              heightSpace(3),
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
                      width: 200,
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
              heightSpace(5),
              const Expanded(
                child: TabBarView(
                  children: [PaymentTab(), WithdrawalTab()],
                ),
              ),
              heightSpace(5)
            ],
          ),
        ),
      ),
    );
  }

  Padding verticalDivide() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 80, top: 20),
      child: VerticalDivider(
        thickness: 1,
      ),
    );
  }
}

class PaymentTab extends StatelessWidget {
  const PaymentTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Center(
    //                   child: Column(
    //                     children: [
                          // SvgPicture.asset(AppImages.nopaymenticon), 
    //                       heightSpace(1),
    //                       SizedBox(
    //                         width: 130,
    //                         child: customText(
    //                           text: 'No payments were made to you',
    //                           fontSize: 15,
    //                           textColor: AppColors.textGrey.withOpacity(0.3),
    //                           textAlignment: TextAlign.center,
    //                         ),
    //                       )
    //                     ],
    //                   ),
    //                 )
    return SizedBox(
      height: 20,
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            // height: 10.h,
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
                        text: "Cancelled", fontSize: 12, textColor: AppColors.red),
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
                  text: "Kelechi Amadi",
                  fontSize: 16,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.bold),
              leading: Container(
                width: 10.w,
                height: 10.h,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.containerGrey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WithdrawalTab extends StatelessWidget {
  const WithdrawalTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Center(
    //                   child: Column(
    //                     children: [
    //                       SvgPicture.asset(AppImages.nowithdrawalicon),
    //                       heightSpace(1),
    //                       SizedBox(
    //                         width: 130,
    //                         child: customText(
    //                           text: 'You have not made any withdrawal',
    //                           fontSize: 15,
    //                           textColor: AppColors.textGrey.withOpacity(0.3),
    //                           textAlignment: TextAlign.center,
    //                         ),
    //                       )
    //                     ],
    //                   ),
    //                 )
    return SizedBox(
      // height: 40,
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            // height: 40.h,
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
                        text: "Cancelled", fontSize: 12, textColor: AppColors.red),
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
                  text: "Kelechi Amadi",
                  fontSize: 16,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.bold),
              leading: Container(
                width: 10.w,
                height: 10.h,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.containerGrey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
