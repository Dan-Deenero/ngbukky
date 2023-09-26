// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/domain/repository/auth_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

import '../../../../core/shared/colors.dart';

Widget card(String title, String subtitle, String image, String route,
        BuildContext context) =>
    GestureDetector(
      onTap: () {
        context.push(route);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        margin: const EdgeInsets.symmetric(vertical: 8),
        width: double.infinity,
        height: 10.h,
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 194, 184, 184),

            blurRadius: 1,

            offset: Offset(1, 1), // Shadow position
          ),
        ], borderRadius: BorderRadius.circular(20), color: AppColors.white),
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
          title:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Flexible(
              child: customText(
                  text: title,
                  fontSize: 15,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.bold),
            ),
            customText(
                text: subtitle, fontSize: 12, textColor: AppColors.textColor)
          ]),
        ),
      ),
    );

class ProfileSettings extends HookWidget {
  static final AuthRepo _authRepo = AuthRepo();

  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final firstname = useState<String?>('Damini');
    final lastname = useState<String?>('Otobo');
    final email = useState<String?>('dadaobo@gmail.com');
    final phone = useState<String?>('+234 701 111 0153');

    getUserProfile() {
      _authRepo.getMechanicProfile().then((value) {
        firstname.value = value.firstname!;
        lastname.value = value.lastname!;
        email.value = value.email!;
        phone.value = value.phoneNumber!;
      });
    }

    // void signOut() async {
    //   bool result = await _authRepo.signOut();
    //   if(context.mounted){
    //     if(result.isNull){
    //       context.go(AppRoutes.login);
    //     }
    //  }
    // }

    useEffect(() {
      getUserProfile();
      return null;
    }, []);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            height: 20.h,
            decoration: const BoxDecoration(
                color: AppColors.containerGrey,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              heightSpace(5),
              customText(
                  text: "Profile settings",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.black),
              heightSpace(1),
              customText(
                  text: "View analytics and withdraw from your wallet",
                  fontSize: 15,
                  textColor: AppColors.black),
            ]),
          ),
          heightSpace(2),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                          text: "${firstname.value}, ${lastname.value}",
                          fontSize: 26,
                          textColor: AppColors.orange),
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
                      card(
                          "Personal profile",
                          "Edit your personal information",
                          AppImages.nameIcon,
                          AppRoutes.personalInfoSettings,
                          context),
                      card(
                          "Business profile",
                          "Edit your business information",
                          AppImages.box,
                          AppRoutes.businessInfoSettings,
                          context),
                      card("Contact Ngbuka", "Edit your business information",
                          AppImages.box, AppRoutes.contactPage, context),
                      card("Wallet", "Edit your business information",
                          AppImages.contact, AppRoutes.addWallet, context),
                      heightSpace(10),
                      GestureDetector(
                        onTap: () {

                        },
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
                    ]),
              ),
            ),
          )
        ]),
    );
  }
}
