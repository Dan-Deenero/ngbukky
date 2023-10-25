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

class Payments extends StatelessWidget {
  const Payments({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => context.push(AppRoutes.historyDetail),
              child: Container(
                width: double.infinity,
                height: 10.h,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
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
                          text: "Kelechi Amadi",
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
            ),
          ],
        ),
      ),
    );
  }
}

class Withdrawal extends StatelessWidget {
  const Withdrawal({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => context.push(AppRoutes.withdrawalDetail),
              child: Container(
                width: double.infinity,
                height: 10.h,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
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
                          text: "Kelechi Amadi",
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
            ),
          ],
        ),
      ),
    );
  }
}

class WalletHistory extends HookWidget {
  const WalletHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final tabIndex = useState<int>(0);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(20.h),
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(
                      text: "History",
                      fontSize: 25,
                      textColor: AppColors.black,
                      fontWeight: FontWeight.bold),
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.borderGrey)),
                      child: Center(child: SvgPicture.asset(AppImages.badIcon)),
                    ),
                  )
                ],
              ),
              heightSpace(1),
              customText(
                  text: "Review your financial analytics",
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
                        text: "Payments",
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
              heightSpace(2),
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
                  )
                ],
              ),
            ]),
          ),
        ),
        body: const Column(children: [
          Expanded(child: TabBarView(children: [Payments(), Withdrawal()]))
        ]),
      ),
    );
  }
}
