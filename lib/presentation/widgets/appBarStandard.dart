import 'package:testing_clinicalpathways/presentation/utils/AppColors.dart';
import 'package:testing_clinicalpathways/presentation/utils/AppConst.dart';
import 'package:testing_clinicalpathways/presentation/utils/AppImages.dart';
import 'package:testing_clinicalpathways/presentation/utils/AppThemes.dart';
import 'package:testing_clinicalpathways/presentation/utils/ScreenSize.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CPAppBar extends GetWidget implements PreferredSizeWidget {
  const CPAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.primaryColor,
      centerTitle: true,
      title: Text(
        AppConst.appTitle.toString().toUpperCase(),
        style: AppThemes.titleTextFontTheme.copyWith(color: AppColor.white),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
