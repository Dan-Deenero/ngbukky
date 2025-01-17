import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_keys.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/config/locator/app_locator.dart';
import 'package:ngbuka/src/config/services/storage_service.dart';
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
import 'package:ngbuka/src/features/presentation/widgets/app_toast.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/utils/helpers/validators.dart';

import '../../../../../domain/data/otp_model.dart';

class LoginView extends HookWidget {
  const LoginView({super.key});

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
                        onTap: () => context.push(AppRoutes.createAccount),
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
                  text: "Log in",
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
                  children: [EmailLogin(), PhoneNumberLogin()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmailLogin extends HookWidget {
  static final email = TextEditingController();
  static final password = TextEditingController();
  static final AuthRepo _authRepo = AuthRepo();
  static final emailFormKey = GlobalKey<FormState>();

  const EmailLogin({
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
        if (result.user?.isEmailVerified == false) {
          context.go(AppRoutes.verifyAccount,
              extra: OTPModel(email: email.text, otpType: "createAccount"));
        } else if (result.user?.role != 'mechanic') {
          context.go(AppRoutes.login);
          ToastResp.toastMsgError(resp: 'Unauthorized User');
        } else {
          if (result.user != null) {
            locator<LocalStorageService>()
                .saveDataToDisk(AppKeys.mechPassword, password.text);
            locator<LocalStorageService>()
                .saveDataToDisk(AppKeys.userType, 'mechanic');
            NotificationsManager.getFcmToken().then(
              (value) async {
                final token =
                    await SecureStorage.readSecureData('device-token');
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
            if (result.user?.mechanicType == null) {
              context.go(AppRoutes.personalInfo);
            } else if (result.user?.businessName == null) {
              context.go(AppRoutes.businessInfo);
            } else {
              context.go(AppRoutes.bottomNav);
            }
          }
        }
      }
    }

    return Form(
      key: emailFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: () {
        isActive.value = emailFormKey.currentState!.validate();
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
                        onTap: () =>
                            context.push(AppRoutes.spareForgotPassword),
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

class PhoneNumberLogin extends HookWidget {
  static final phone = TextEditingController();
  static final password = TextEditingController();
  static final AuthRepo _authRepo = AuthRepo();
  static final phoneFormKey = GlobalKey<FormState>();

  const PhoneNumberLogin({
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
        if (result.user?.isEmailVerified == false) {
          context.go(AppRoutes.spareVerifyAccount,
              extra: OTPModel(email: phone.text, otpType: "createAccount"));
        } else if (result.user?.role != 'dealer') {
          context.go(AppRoutes.login);
          ToastResp.toastMsgError(resp: 'Unauthorized User');
        } else {
          if (result.user != null) {
            locator<LocalStorageService>()
                .saveDataToDisk(AppKeys.mechPassword, password.text);
            locator<LocalStorageService>()
                .saveDataToDisk(AppKeys.userType, 'mechanic');
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
            if (result.user?.mechanicType == null) {
              context.go(AppRoutes.personalInfo);
            } else if (result.user?.businessName == null) {
              context.go(AppRoutes.businessInfo);
            } else {
              context.go(AppRoutes.bottomNav);
            }
          }
        }
      }
      log(locator<LocalStorageService>().getDataFromDisk(AppKeys.userType));
    }

    return Form(
      key: phoneFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: () {
        isActive.value = phoneFormKey.currentState!.validate();
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
                        if (val.number.startsWith('0') &&
                            val.number.length == 11) {
                          phone.text =
                              val.countryCode + val.number.substring(1);
                        } else {
                          phone.text = val.completeNumber;
                        }
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
                      onTap: login,
                    ),
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
