import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:ngbuka/src/core/shared/colors.dart';

class BodyWithBackCircle extends StatelessWidget {
  final Widget child;
  const BodyWithBackCircle({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: double.infinity,
        height: 16.h,
        decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
      ),
      Expanded(child: child)
    ]));
  }
}
