import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/otp_model.dart';
import 'package:ngbuka/src/domain/repository/auth_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_phone_field.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/features/presentation/widgets/body_backcircle.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/utils/helpers/validators.dart';

class CreateAccount extends HookWidget {
  static final _formKey = GlobalKey<FormState>();

  static final firstName = TextEditingController();
  static final lastName = TextEditingController();
  static final email = TextEditingController();
  static final password = TextEditingController();
  static final phoneNumber = TextEditingController();
  static AuthRepo authRepo = AuthRepo();
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final isActive = useState<bool>(false);

    void createAccount() async {
      // context.push(AppRoutes.verifyAccount, extra: email.text);
      var data = {
        "firstname": firstName.text,
        "lastname": lastName.text,
        "phoneNumber": phoneNumber.text.substring(0),
        "email": email.text,
        "password": password.text,
        "role": "mechanic"
      };
      bool result = await authRepo.register(data);
      if (result) {
        if (context.mounted) {
          context.push(AppRoutes.verifyAccount,
              extra: OTPModel(email: email.text, otpType: "createAccount"));
        }
      }
    }

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: () => isActive.value = _formKey.currentState!.validate(),
      child: BodyWithBackCircle(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            heightSpace(2),
            customText(
                text: "Create account",
                fontSize: 30,
                textColor: AppColors.black,
                fontWeight: FontWeight.bold),
            heightSpace(1),
            customText(
                text: "Get started as a mechanic",
                fontSize: 15,
                textColor: AppColors.textColor),
            heightSpace(4),
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      validator: stringValidation,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: SvgPicture.asset(
                          AppImages.nameIcon,
                        ),
                      ),
                      label: "First name",
                      hintText: "John",
                      textEditingController: firstName,
                    ),
                    heightSpace(2),
                    CustomTextFormField(
                      validator: stringValidation,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: SvgPicture.asset(
                          AppImages.nameIcon,
                        ),
                      ),
                      label: "Last name",
                      textEditingController: lastName,
                      hintText: "Doe",
                    ),
                    heightSpace(2),
                    CustomTextFormField(
                      textEditingController: email,
                      validator: emailValidation,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: SvgPicture.asset(
                          AppImages.emailIcon,
                        ),
                      ),
                      label: "Email",
                      hintText: "johndoe@gmail.com",
                    ),
                    heightSpace(2),
                    customText(
                        text: "Business phone no (optional)",
                        fontSize: 14,
                        textColor: AppColors.primary),
                    heightSpace(2),
                    CustomPhoneField(
                      onChanged: (val) {
                        phoneNumber.text = val.completeNumber;
                      },
                    ),
                    heightSpace(2),
                    CustomTextFormField(
                      textEditingController: password,
                      validator: passwordValidation,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: SvgPicture.asset(
                          AppImages.passwordIcon,
                        ),
                      ),
                      isPassword: true,
                      label: "Password",
                      hintText: "Enter password",
                    ),
                    heightSpace(2),
                    CustomTextFormField(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: SvgPicture.asset(
                          AppImages.passwordIcon,
                        ),
                      ),
                      isPassword: true,
                      label: "Confirm password",
                      hintText: "Re-enter password",
                    ),
                    heightSpace(4),
                    const Text("Creating an account means you're okay with our",
                        style: TextStyle(color: AppColors.orange)),
                    Row(children: [
                      const Text("Terms of service",
                          style: TextStyle(color: AppColors.orange)),
                      widthSpace(2),
                      const Text(
                        "Privacy Policy",
                        style: TextStyle(color: AppColors.orange),
                      ),
                      widthSpace(1),
                      const Text(
                        "and our default",
                        style: TextStyle(color: AppColors.orange),
                      ),
                    ]),
                    const Text(
                      "Notification Settings",
                      style: TextStyle(color: AppColors.orange),
                    ),
                    heightSpace(4),
                    AppButton(
                      isActive: isActive.value,
                      buttonText: "Get me going",
                      onTap: createAccount,
                    ),
                    heightSpace(3),
                    haveanaccount(),
                    heightSpace(5),
                  ],
                ),
              ),
            ))
          ]),
        ),
      ),
    );
  }
}
