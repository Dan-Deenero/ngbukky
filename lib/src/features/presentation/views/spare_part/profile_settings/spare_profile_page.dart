import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/domain/repository/auth_repository.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

import '../../../../../core/shared/colors.dart';

Widget card(
  String title,
  String subtitle,
  String image,
) =>
    Card(
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      child: ListTile(
        leading: SvgPicture.asset(
          image,
          width: 25,
          height: 25,
        ),
        trailing: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.arrow_forward_ios,
            size: 20,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText(
                text: title,
                fontSize: 15,
                textColor: AppColors.black,
                fontWeight: FontWeight.bold),
            customText(
                text: subtitle, fontSize: 12, textColor: AppColors.textColor)
          ],
        ),
      ),
    );

class SpareProfileSettings extends HookWidget {
  const SpareProfileSettings({super.key});

  static final AuthRepo _authRepo = AuthRepo();
  static final MechanicRepo _mechanicRepo = MechanicRepo();

  @override
  Widget build(BuildContext context) {
    final firstname = useState<String?>('Damini');
    final lastname = useState<String?>('Otobo');
    final email = useState<String?>('dadaobo@gmail.com');
    final phone = useState<String?>('+234 701 111 0153');

    getUserProfile() {
      _mechanicRepo.getDealerProfile().then((value) {
        firstname.value = value.firstname!;
        lastname.value = value.lastname!;
        email.value = value.email!;
        phone.value = value.phoneNumber!;
      });
    }

    void signOut() async {
      bool result = await _authRepo.signOut();
      if (result) {
        if (context.mounted) {
          context.go(AppRoutes.dealerLogin);
        }
      }
    }

    useEffect(() {
      getUserProfile();
      return null;
    }, []);
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(27.h),
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          height: 25.h,
          decoration: const BoxDecoration(
            color: AppColors.containerGrey,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heightSpace(7),
                  customText(
                      text: "Profile settings",
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      textColor: AppColors.black),
                  heightSpace(1),
                  SizedBox(
                    width: 250,
                    child: customText(
                        text: "View analytics and withdraw from your wallet",
                        fontSize: 14,
                        textColor: AppColors.black),
                  ),
                ],
              ),
              InkWell(
                onTap: () => context.push(AppRoutes.notification),
                child: SvgPicture.asset(AppImages.notification),
              )
            ],
          ),
        ),
      ),
      body: Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                    text: "${firstname.value}, ${lastname.value}",
                    fontSize: 26,
                    textColor: AppColors.orange,
                    fontWeight: FontWeight.w600),
                heightSpace(2),
                Row(
                  children: [
                    SvgPicture.asset(AppImages.emailIcon),
                    widthSpace(2),
                    bodyText("${email.value}")
                  ],
                ),
                heightSpace(1),
                Row(
                  children: [
                    SvgPicture.asset(AppImages.phone),
                    widthSpace(2),
                    bodyText("${phone.value}")
                  ],
                ),
                heightSpace(3),
                Container(
                  width: double.infinity,
                  height: 2.h,
                  decoration: const BoxDecoration(
                      border: Border(
                    top: BorderSide(color: AppColors.borderGrey),
                  )),
                ),
                heightSpace(2),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.sparePersonalInfo),
                  child: card(
                    "Personal profile",
                    "Edit your personal information",
                    AppImages.nameIcon,
                  ),
                ),
                heightSpace(2),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.spareBusinessProfile),
                  child: card(
                    "Business profile",
                    "Edit your business information",
                    AppImages.box,
                  ),
                ),
                heightSpace(2),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.spareContactPage),
                  child: card(
                    "Contact Ngbuka",
                    "Contact Ngbuka customer care",
                    AppImages.box,
                  ),
                ),
                heightSpace(2),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.spareAddWallet),
                  child: card(
                    "Wallet",
                    "Manage your saved account number",
                    AppImages.contact,
                  ),
                ),
                heightSpace(10),
                InkWell(
                  onTap: signOut,
                  child: Row(
                    children: [
                      customText(
                          text: 'Log out',
                          fontSize: 17,
                          textColor: AppColors.textGrey),
                      widthSpace(2),
                      SvgPicture.asset(
                        AppImages.logoutIcon,
                        width: 25,
                      )
                    ],
                  ),
                ),
                heightSpace(4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
