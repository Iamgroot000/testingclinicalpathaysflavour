import 'package:testing_clinicalpathways/presentation/controllers/splashController.dart';
import 'package:testing_clinicalpathways/presentation/utils/AppColors.dart';
import 'package:testing_clinicalpathways/presentation/utils/AppConst.dart';
import 'package:testing_clinicalpathways/presentation/utils/AppImages.dart';
import 'package:testing_clinicalpathways/presentation/utils/AppThemes.dart';
import 'package:testing_clinicalpathways/presentation/utils/ScreenSize.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _AssetImageViewContainer(assetImage: AppImages.medongo),
                _AssetImageViewContainer(assetImage: AppImages.axi),
                _AssetImageViewContainer(assetImage: AppImages.itachyon),
                _AssetImageViewContainer(assetImage: AppImages.jansankalp),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: ScreenSize.height(context) * 0.06,
              width: double.infinity,
              decoration:
                  BoxDecoration(color: AppColor.primaryColor.withOpacity(0.9)),
              child: const Center(
                child: Text(
                  AppConst.appTitle,
                  style: AppThemes.titleTextAppBarFontTheme,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AssetImageViewContainer extends GetWidget<SplashController> {
  const _AssetImageViewContainer({Key? key, required this.assetImage})
      : super(key: key);

  final String assetImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize.height(context) * 0.13,
      width: ScreenSize.width(context) * 0.1,
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(image: AssetImage(assetImage), fit: BoxFit.fill)),
    );
  }
}
