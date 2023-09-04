

import 'package:auto_size_text/auto_size_text.dart';
import 'package:testing_clinicalpathways/presentation/utils/AppColors.dart';
import 'package:testing_clinicalpathways/presentation/utils/ScreenSize.dart';
import 'package:flutter/material.dart';


class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.buttonText,
    required this.onTap,
    this.buttonColor,
    this.textColor,
    this.fontSize,
    this.height,
    this.width,
  }) : super(key: key);

  final String buttonText;
  final Function() onTap;
  final Color? buttonColor, textColor;
  final double? height, width, fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        width: width ?? ScreenSize.width(context) * 0.9,
        height: height ?? 50,

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60.0),
            color: buttonColor ?? AppColor.primaryColor
        ),

        child: Center(
          child: AutoSizeText(
            buttonText,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: fontSize ?? 15,
            ),
          ),
        ),
      ),
    );
  }
}




class AppButtonLoading extends StatelessWidget {
  const AppButtonLoading({
    Key? key,
    this.buttonColor,
    this.textColor,
    this.fontSize,
    this.height,
    this.width,

  }) : super(key: key);
  final Color? buttonColor, textColor;
  final double? height, width, fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? ScreenSize.width(context) * 0.9,
      height: height ?? 50,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60.0),
          color: buttonColor ?? AppColor.primaryColor
      ),

      child: const Center(
        child: CircularProgressIndicator(color: AppColor.white,strokeWidth: 2.0,)
      ),
    );
  }
}