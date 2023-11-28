import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/repository/auth_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/utils/helpers/validators.dart';

class NewPassword extends HookWidget {
  static final password = TextEditingController();
  static final confirmPassword = TextEditingController();
  static final formKey = GlobalKey<FormState>();
  static final AuthRepo _authRepo = AuthRepo();
  const NewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final isActive = useState<bool>(false);

    void createNewPassword() async {
      var data = {
        "password": password.text,
        "confirmPassword": confirmPassword.text
      };
      bool result = await _authRepo.createNewPassword(data);
      if (result) {
        if (context.mounted) {
          context.push(AppRoutes.login);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
          leading: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: customText(
              text: "New Password",
              fontSize: 25,
              fontWeight: FontWeight.bold,
              textColor: AppColors.primary)),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          onChanged: () => isActive.value = formKey.currentState!.validate(),
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightSpace(4),
              Center(
                child: customText(
                    text: "Create new password here",
                    fontSize: 15,
                    textAlignment: TextAlign.center,
                    textColor: AppColors.textColor),
              ),
              heightSpace(3),
              CustomTextFormField(
                textEditingController: password,
                validator: passwordValidation,
                isPassword: true,
                label: "New password",
                hintText: "Enter password",
              ),
              heightSpace(2),
              CustomTextFormField(
                textEditingController: confirmPassword,
                validator: (val) {
                  if (val != password.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
                isPassword: true,
                label: "Confirm new password",
                hintText: "Enter password",
              ),
              heightSpace(2),
              AppButton(
                isActive: isActive.value,
                onTap: () => createNewPassword(),
                buttonText: "New password",
                hasIcon: false,
              ),
              heightSpace(2),
            ],
          ),
        ),
      )),
    );
  }
}
