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

class CreateAccount extends HookWidget {
  const CreateAccount({super.key});

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

class EmailRegistration extends StatelessWidget {
  final bool isPhone;

  const EmailRegistration({super.key, required this.isPhone});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTextFormField(
              label: "First name",
              hintText: "John",
            ),
            heightSpace(2),
            const CustomTextFormField(
              label: "Last name",
              hintText: "Doe",
            ),
            heightSpace(2),
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
            const CustomTextFormField(
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
                buttonText: "Get me going",
                onTap: () => context.push(AppRoutes.verifyAccount)),
            heightSpace(3),
            haveanaccount(),
            heightSpace(5),
          ],
        ),
      ),
    );
  }
}
