import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/core/shared/colors.dart';

class BodyWithBackCircle extends StatelessWidget {
  final Widget child;
  final Widget? rightWidget;
  const BodyWithBackCircle({super.key, required this.child, this.rightWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      GestureDetector(
        onTap: () => context.pop(),
        child: Container(
          width: double.infinity,
          height: 16.h,
          decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 20),
              child: Container(
                width: 45,
                height: 45,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 88, 88, 88),
                    shape: BoxShape.circle),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      Expanded(child: child)
    ]));
  }
}
