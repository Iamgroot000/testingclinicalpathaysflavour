


import 'package:testing_clinicalpathways/presentation/utils/AppColors.dart';
import 'package:flutter/material.dart';


class AppThemes {
  ///NAMED CONSTRUCTOR
  AppThemes._();

  //
  static const TextStyle titleTextFontTheme = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: AppColor.white
  );

  //
  static const TextStyle titleTextFontThemeDark = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: AppColor.black,
      letterSpacing: 2
  );
  static const double titleTextFontThemeDarkMinimumSize = 14.0;
  static const double titleTextFontThemeDarkMaximumSize = 32.0;


  //
  static const TextStyle titleTextAppBarFontTheme = TextStyle(
      letterSpacing: 2,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColor.white
  );

  //
  static const TextStyle textErrorMessageFontTheme = TextStyle(
      letterSpacing: 1,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColor.red
  );

  static const TextStyle textSuccessMessageFontTheme = TextStyle(
      letterSpacing: 1,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColor.green
  );

  static const TextStyle getAgeGroupHeadingFontTheme = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: AppColor.black,
      letterSpacing: 2
  );
}


