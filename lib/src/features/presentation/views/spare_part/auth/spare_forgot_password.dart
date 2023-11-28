import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/otp_model.dart';
import 'package:ngbuka/src/domain/repository/auth_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/utils/helpers/validators.dart';

class SpareForgotPassword extends HookWidget {
  static final email = TextEditingController();
  static final formKey = GlobalKey<FormState>();
  static final AuthRepo _authRepo = AuthRepo();
  const SpareForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final isActive = useState<bool>(false);

    void forgotPassword() async {
      var body = {"email": email.text};
      bool result = await _authRepo.forgotEmail(body);
      if (result) {
        if (context.mounted) {
          context.push(AppRoutes.spareVerifyAccount,
              extra: OTPModel(email: email.text, otpType: "forgotPassword"));
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
              onTap: () => context.pop(),
              child:
                  const Icon(Icons.arrow_back_ios, color: AppColors.primary)),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: customText(
              text: "Spear Forgot Password",
              fontSize: 25,
              fontWeight: FontWeight.bold,
              textColor: AppColors.primary)),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          onChanged: () => isActive.value = formKey.currentState!.validate(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightSpace(4),
              Center(
                child: customText(
                    text:
                        "We can help yout recover your password in \n simple steps",
                    fontSize: 15,
                    textAlignment: TextAlign.center,
                    textColor: AppColors.textColor),
              ),
              heightSpace(3),
              customText(
                  text: "Enter your registered email address",
                  fontSize: 15,
                  textAlignment: TextAlign.center,
                  textColor: AppColors.orange),
              heightSpace(4),
              CustomTextFormField(
                textEditingController: email,
                label: "Email",
                hintText: "johndoe@gmail.com",
                validator: emailValidation,
              ),
              heightSpace(4),
              AppButton(
                isActive: isActive.value,
                onTap: forgotPassword,
                buttonText: "Send code",
                hasIcon: false,
              ),
              heightSpace(2),
              Center(
                child: customText(
                    text: "Resend Code",
                    fontSize: 15,
                    textColor: AppColors.textGrey),
              )
            ],
          ),
        ),
      )),
    );
  }
}
