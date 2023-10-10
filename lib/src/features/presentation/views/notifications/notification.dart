import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class NewNotification extends StatelessWidget {
  const NewNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              // height: 120,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                            text: 'New Inspection booking',
                            fontSize: 14,
                            textColor: AppColors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            width:200,
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        'You have a new inspection booking from ',
                                    style: TextStyle(color: AppColors.textGrey),
                                  ),
                                  TextSpan(
                                    text: '{Client_username}',
                                    style: TextStyle(color: AppColors.orange),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(AppImages.time),
                                  customText(
                                      text: '12:20pm',
                                      fontSize: 10,
                                      textColor: AppColors.textGrey)
                                ],
                              ),
                              widthSpace(.5),
                              Row(
                                children: [
                                  SvgPicture.asset(AppImages.calendarIcon),
                                  customText(
                                      text: '15 Jun 2023',
                                      fontSize: 10,
                                      textColor: AppColors.textGrey)
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(25.h),
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          Expanded(
              child:
                  TabBarView(children: [NewNotification(), NewNotification()]))
        ]),
      ),
    );
  }
}
