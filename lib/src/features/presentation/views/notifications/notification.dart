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
              height: 100,
              padding: const EdgeInsets.only(top: 15),
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
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.white),
              child: ListTile(
                leading: SvgPicture.asset(
                  AppImages.notification,
                  width: 30,
                  height: 30,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customText(
                        text: "New Inspection booking",
                        fontSize: 12,
                        textColor: AppColors.black,
                        fontWeight: FontWeight.bold),
                    Row(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppImages.time,
                              width: 10,
                              height: 10,
                            ),
                            customText(
                                text: "12:20pm",
                                fontSize: 8,
                                textColor: AppColors.textGrey)
                          ],
                        ),
                        widthSpace(1),
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppImages.calendarIcon,
                              width: 10,
                              height: 10,
                            ),
                            customText(
                                text: "12 Jun 2023",
                                fontSize: 8,
                                textColor: AppColors.textGrey)
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: customText(
                      text:
                          "You have a new inspection booking from {Client_username}",
                      fontSize: 12,
                      textColor: AppColors.textGrey),
                ),
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
