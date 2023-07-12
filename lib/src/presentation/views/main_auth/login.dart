import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/presentation/widgets/app_phone_field.dart';
import 'package:ngbuka/src/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/presentation/widgets/body_backcircle.dart';
import 'package:ngbuka/src/presentation/widgets/custom_text.dart';

class EmailRegistration extends HookWidget {
  final bool isPhone;

  const EmailRegistration({super.key, required this.isPhone});

  @override
  Widget build(BuildContext context) {
    final isChecked = useState<bool>(false);
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

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isPhone
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                          text: "Phone",
                          fontSize: 14,
                          textColor: AppColors.primary),
                      heightSpace(2),
                      const CustomPhoneField(),
                    ],
                  )
                : const CustomTextFormField(
                    label: "Email",
                    hintText: "johndoe@gmail.com",
                  ),
            heightSpace(2),
            const CustomTextFormField(
              isPassword: true,
              label: "Password",
              hintText: "Enter password",
            ),
            heightSpace(2),
            Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
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
                buttonText: "Log me in",
                onTap: () => context.push(AppRoutes.verifyAccount)),
            heightSpace(3),
            Center(
              child: GestureDetector(
                onTap: () => isPhone
                    ? context.push(AppRoutes.forgotPasswordPhone)
                    : context.push(AppRoutes.forgotPassword),
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
    );
  }
}

class LoginView extends HookWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final tabIndex = useState<int>(0);
    return DefaultTabController(
      length: 2,
      child: BodyWithBackCircle(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            heightSpace(2),
            const Expanded(
              child: TabBarView(children: [
                EmailRegistration(
                  isPhone: false,
                ),
                EmailRegistration(
                  isPhone: true,
                ),
              ]),
            )
          ]),
        ),
      ),
    );
  }
}
