import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/managers/notification_manger.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/core/storage/secure_storage.dart';
import 'package:ngbuka/src/domain/data/login_model.dart';
import 'package:ngbuka/src/domain/repository/auth_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_phone_field.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/utils/helpers/validators.dart';

class DealerLoginView extends HookWidget {
  const DealerLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final tabIndex = useState<int>(0);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(17.h),
          child: Container(
            width: double.infinity,
            height: 16.h,
            decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => context.push(AppRoutes.boarding2),
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 88, 88, 88),
                            shape: BoxShape.circle),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () => context.push(AppRoutes.dealerCreateAccount),
                        child: SvgPicture.asset(AppImages.createAccount),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              heightSpace(2),
              customText(
                  text: "Dealer Log in",
                  fontSize: 30,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.bold),
              heightSpace(1),
              customText(
                  text: "Since you already have an account, get goinnnggg",
                  fontSize: 15,
                  textColor: AppColors.textColor),
              heightSpace(4),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
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
                        text: "Email",
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
                        text: "Phone number",
                      ),
                    ),
                  ],
                ),
              ),
              heightSpace(4),
              const Expanded(
                child: TabBarView(
                  children: [SpareEmailLogin(), SparePhoneNumberLogin()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SpareEmailLogin extends HookWidget {
  static final email = TextEditingController();
  static final password = TextEditingController();
  static final AuthRepo _authRepo = AuthRepo();
  static final formKey = GlobalKey<FormState>();

  const SpareEmailLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isChecked = useState<bool>(true);
    final isActive = useState<bool>(false);
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return AppColors.checkBoxColor;
      }
      return AppColors.checkBoxColor;
    }

    void login() async {
      var data = {
        "email": email.text,
        "password": password.text,
        "isEmailLogin": true
      };
      LoginModel result = await _authRepo.loginEmail(data);
      log(result.toString());
      if (context.mounted) {
        if (result.user != null) {
          NotificationsManager.getFcmToken().then(
            (value) async {
              final token = await SecureStorage.readSecureData('device-token');
              if (token != null || token != '') {
                if (token != value) {
                  final data = {
                    'deviceToken': value,
                  };
                  _authRepo.updateDeviceToken(data);
                }
              }
            },
          );
          NotificationsManager.init();
          if (result.user?.businessName == null) {
            context.go(AppRoutes.spareSetup);
          } else {
            context.go(AppRoutes.spareBottomNav);
          }
        }
      }
    }

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: () {
        isActive.value = formKey.currentState!.validate();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      textEditingController: email,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(
                          AppImages.emailIcon,
                        ),
                      ),
                      validator: emailValidation,
                      label: "Email",
                      hintText: "johndoe@gmail.com",
                    ),
                    heightSpace(2),
                    CustomTextFormField(
                      isPassword: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: SvgPicture.asset(
                          AppImages.passwordIcon,
                        ),
                      ),
                      textEditingController: password,
                      label: "Password",
                      validator: passwordValidation,
                      hintText: "Enter password",
                    ),
                    heightSpace(2),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isChecked.value,
                          onChanged: (bool? value) {
                            isChecked.value = value!;
                          },
                        ),
                        widthSpace(2),
                        customText(
                            text: "Keep me logged in",
                            fontSize: 14,
                            textColor: AppColors.primary)
                      ],
                    ),
                    heightSpace(4),
                    AppButton(
                      isActive: isActive.value,
                      buttonText: "Log me in",
                      onTap: login,
                    ),
                    heightSpace(3),
                    Center(
                      child: GestureDetector(
                        onTap: () => context.push(AppRoutes.spareForgotPassword),
                        child: customText(
                            text: "Forgot Password",
                            fontSize: 15,
                            textColor: AppColors.textGrey),
                      ),
                    ),
                    heightSpace(5),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SparePhoneNumberLogin extends HookWidget {
  static final phone = TextEditingController();
  static final password = TextEditingController();
  static final AuthRepo _authRepo = AuthRepo();
  static final formKey = GlobalKey<FormState>();

  const SparePhoneNumberLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isChecked = useState<bool>(true);
    final isActive = useState<bool>(false);
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return AppColors.checkBoxColor;
      }
      return AppColors.checkBoxColor;
    }

    void login() async {
      var data = {
        "phoneNumber": phone.text.substring(0),
        "password": password.text,
        "isEmailLogin": false
      };
      LoginModel result = await _authRepo.loginEmail(data);
      if (context.mounted) {
        if (result.user != null) {
          NotificationsManager.getFcmToken().then((value) async {
            final token = await SecureStorage.readSecureData('device-token');
            if (token != null || token != '') {
              if (token != value) {
                final data = {
                  'deviceToken': value,
                };
                _authRepo.updateDeviceToken(data);
              }
            }
          });
          NotificationsManager.init();
          if (result.user?.businessName == null) {
            context.go(AppRoutes.spareStoreInfo);
          } else {
            context.go(AppRoutes.spareBottomNav);
          }
        }
      }
    }

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: () {
        isActive.value = formKey.currentState!.validate();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customText(
                      text: 'Phone Number',
                      fontSize: 14,
                      textColor: AppColors.primary,
                    ),
                    heightSpace(1),
                    CustomPhoneField(
                      onChanged: (val) {
                        phone.text = val.completeNumber;
                      },
                    ),
                    heightSpace(2),
                    CustomTextFormField(
                      isPassword: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: SvgPicture.asset(
                          AppImages.passwordIcon,
                        ),
                      ),
                      textEditingController: password,
                      label: "Password",
                      validator: passwordValidation,
                      hintText: "Enter password",
                    ),
                    heightSpace(2),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isChecked.value,
                          onChanged: (bool? value) {
                            isChecked.value = value!;
                          },
                        ),
                        widthSpace(2),
                        customText(
                            text: "Keep me logged in",
                            fontSize: 14,
                            textColor: AppColors.primary)
                      ],
                    ),
                    heightSpace(4),
                    AppButton(
                        isActive: isActive.value,
                        buttonText: "Log me in",
                        onTap: login),
                    heightSpace(3),
                    Center(
                      child: GestureDetector(
                        onTap: () => context.push(AppRoutes.forgotPassword),
                        child: customText(
                            text: "Forgot Password",
                            fontSize: 15,
                            textColor: AppColors.textGrey),
                      ),
                    ),
                    heightSpace(5),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
