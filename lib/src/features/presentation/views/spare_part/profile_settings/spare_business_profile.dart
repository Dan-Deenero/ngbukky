import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/features/providers/work_hours.dart';
import 'package:ngbuka/src/utils/helpers/validators.dart';

class SpareBusinessProfile extends HookWidget {
  static final _formKey = GlobalKey<FormState>();

  const SpareBusinessProfile({super.key});
  static final MechanicRepo _mechanicRepo = MechanicRepo();
  static final description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isLoading = useState<bool>(false);
    // final userModel = useState<UserModel?>(null);
    final isValidated = useState<bool>(false);

    getDealerProfile() {
      _mechanicRepo.getDealerProfile().then(
        (value) {
          cac.text = value.cacNumber!;
          description.text = value.about!;
        },
      );
    }

    updateInfo() async {
      var data = {
        "cacNumber": cac.text,
        "about": description.text,
      };
      bool result = await _mechanicRepo.updateDealerProfile(data, 2);
      if (result) {
        if (context.mounted) {
          context.push(AppRoutes.spareProfileSettings);
        }
      }
    }

    useEffect(() {
      getDealerProfile();
      return null;
    }, []);
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              onChanged: () =>
                  isValidated.value = _formKey.currentState!.validate(),
              key: _formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      height: 25.h,
                      decoration: const BoxDecoration(
                          color: AppColors.orange,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 10.h,
                            width: 10.w,
                            decoration: BoxDecoration(
                                color: AppColors.white.withOpacity(.5),
                                shape: BoxShape.circle),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 7.0),
                              child: Center(
                                  child: Icon(
                                Icons.arrow_back_ios,
                                color: AppColors.white,
                              )),
                            ),
                          ),
                          heightSpace(1),
                          customText(
                              text: "Enterprise entity",
                              fontSize: 20,
                              textColor: AppColors.white),
                          heightSpace(1),
                          customText(
                              text:
                                  "Help us complete these info and get started",
                              fontSize: 15,
                              textColor: AppColors.white),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            heightSpace(2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                customText(
                                    text: "Business information",
                                    fontSize: 18,
                                    textColor: AppColors.primary),
                              ],
                            ),
                            heightSpace(2),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextFormField(
                                  textEditingController: cac,
                                  label: "CAC",
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: SvgPicture.asset(
                                      AppImages.nameIcon,
                                    ),
                                  ),
                                  hintText:
                                      "Type in business registration number",
                                ),
                                heightSpace(2),
                                CustomTextFormField(
                                  validator: stringValidation,
                                  label: "Tell us little about yourself",
                                  hasMaxline: true,
                                  textEditingController: description,
                                ),
                                heightSpace(3),
                                AppButton(
                                  isActive: isValidated.value,
                                  onTap: updateInfo,
                                  buttonText: "Send",
                                  isOrange: true,
                                  hasIcon: false,
                                ),
                                heightSpace(2),
                                Row(
                                  children: [
                                    SvgPicture.asset(AppImages.info),
                                    widthSpace(2),
                                    Flexible(
                                      child: bodyText(
                                          "You can always edit every information entered and saved later if you want"),
                                    )
                                  ],
                                ),
                                heightSpace(3),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
