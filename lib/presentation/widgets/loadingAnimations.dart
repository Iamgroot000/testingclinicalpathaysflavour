
import 'package:testing_clinicalpathways/presentation/utils/AppColors.dart';
import 'package:testing_clinicalpathways/presentation/utils/ScreenSize.dart';
import 'package:get/get.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:flutter/material.dart';

class SquareRotatingAnimation extends GetWidget{
  const SquareRotatingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingRotating.square(
      size: ScreenSize.height(context) * 0.1,
      backgroundColor: AppColor.primaryColor,
      borderColor: AppColor.primaryColor,
      duration: const Duration(milliseconds: 1000),
    );
  }
}