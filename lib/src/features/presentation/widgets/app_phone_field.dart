import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:ngbuka/src/core/shared/colors.dart';

class CustomPhoneField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(PhoneNumber)? onChanged;
  final bool enabled;
  const CustomPhoneField({
    super.key,
    this.controller,
    this.enabled = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: controller,
      cursorColor: AppColors.primary,
      cursorWidth: 0.9,
      disableLengthCheck: false,
      style: const TextStyle(
          fontFamily: 'Euclad', fontSize: 14, fontWeight: FontWeight.w400),
      dropdownTextStyle: const TextStyle(fontFamily: 'Euclad'),
      pickerDialogStyle: PickerDialogStyle(
          countryNameStyle: const TextStyle(
            fontFamily: 'Euclad',
          ),
          countryCodeStyle: const TextStyle(
            fontFamily: 'Euclad',
          )),
      decoration: const InputDecoration(
        fillColor: AppColors.white,
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textformGrey),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.red),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textformGrey),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.red),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        counter: SizedBox.shrink(),
        border: OutlineInputBorder(),
      ),
      initialCountryCode: 'NG',
      onChanged: onChanged,
    );
  }
}
