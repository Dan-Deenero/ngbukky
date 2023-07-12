import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/shared/colors.dart';
import 'app_spacer.dart';
import 'custom_text.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final bool isAddress;
  final String? label;
  final String? hintText;
  final Widget? prefixIcon;
  final bool isPassword;
  final bool hasMaxline;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final String? error;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  const CustomTextFormField(
      {super.key,
      this.isAddress = false,
      this.label,
      this.hasMaxline = false,
      this.inputFormatters,
      this.onChanged,
      this.hintText,
      this.error,
      this.prefixIcon,
      this.keyboardType = TextInputType.text,
      this.textEditingController,
      this.isPassword = false,
      this.validator});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isPasswordShow = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customText(
            text: '${widget.label}',
            fontSize: 14,
            textColor: AppColors.primary),
        heightSpace(1),
        TextFormField(
          maxLines: widget.hasMaxline ? 8 : 1,
          cursorColor: AppColors.primary,
          cursorWidth: 0.9,
          onChanged: widget.onChanged,
          keyboardType: widget.keyboardType,
          controller: widget.textEditingController,
          obscureText: isPasswordShow ? false : widget.isPassword,
          validator: widget.validator,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
              disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textformGrey),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              errorText: widget.error,
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textformGrey),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              contentPadding: const EdgeInsets.only(left: 10),
              errorStyle: const TextStyle(fontSize: 14),
              // suffixIcon:  showPasswordIcon(widget.isPassword),

              suffixIcon: (() {
                if (widget.isPassword) {
                  return showPasswordIcon(widget.isPassword);
                }
                if (widget.isAddress) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.textformGrey),
                          shape: BoxShape.circle),
                      child: const Icon(Icons.location_on_outlined),
                    ),
                  );
                }
              }()),
              hintText: widget.hintText,
              hintStyle: const TextStyle(fontSize: 14),
              prefixIcon: widget.prefixIcon,
              fillColor: AppColors.white,
              filled: true,
              enabledBorder: AppColors.normalBorder,
              errorBorder: AppColors.errorBorder,
              focusedBorder: AppColors.normalBorder,
              focusedErrorBorder: AppColors.normalBorder),
        ),
      ],
    );
  }

  showPasswordIcon(bool isPassword) {
    if (isPassword) {
      if (isPasswordShow) {
        return IconButton(
          icon: const Icon(
            Icons.visibility,
            color: AppColors.primary,
          ),
          onPressed: () => setState(() {
            isPasswordShow = !isPasswordShow;
          }),
        );
      }
      return IconButton(
        icon: const Icon(
          Icons.visibility_off,
          size: 18,
          color: AppColors.primary,
        ),
        onPressed: () => setState(() {
          isPasswordShow = !isPasswordShow;
        }),
      );
    }
  }
}
