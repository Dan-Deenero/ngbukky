import 'package:flutter/material.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class AppDropdown extends StatefulWidget {
  final List<String>? dropdownList;
  final Function(Object?)? onChange;
  final String? Function(String?)? validator;
  final String label;
  final Widget? prefixIcon;
  final String? value;
  const AppDropdown(
      {super.key,
      this.validator,
      this.prefixIcon,
      required this.dropdownList,
      required this.label,
      this.value,
      this.onChange});

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customText(
            text: widget.label, fontSize: 14, textColor: AppColors.textColor),
        heightSpace(1),
        SizedBox(
          height: 75,
          child: DropdownButtonFormField(
              value:  widget.dropdownList!.first,
              validator: widget.validator,
              decoration: InputDecoration(
                  prefixIcon: widget.prefixIcon,
                  contentPadding: const EdgeInsets.all(10),
                  fillColor: Colors.white,
                  filled: true,
                  errorStyle: const TextStyle(fontSize: 13),
                  enabledBorder: AppColors.normalBorder,
                  errorBorder: AppColors.errorBorder,
                  focusedBorder: AppColors.normalBorder,
                  focusedErrorBorder: AppColors.normalBorder),
              items: widget.dropdownList!
                  .map((text) => DropdownMenuItem(
                      value: text,
                      child: Text(
                        text.toString(),
                        style: const TextStyle(
                            color: AppColors.textColor, fontSize: 14),
                      )))
                  .toList(),
              onChanged: widget.onChange),
        ),
      ],
    );
  }
}
