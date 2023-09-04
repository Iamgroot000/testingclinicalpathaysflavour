import 'package:testing_clinicalpathways/domain/entities/userEntity.dart';
import 'package:testing_clinicalpathways/domain/cookies/userCookies.dart';
import 'package:testing_clinicalpathways/domain/usecases/authUseCase.dart';
import 'package:testing_clinicalpathways/presentation/routes/AppRoutes.dart';
import 'package:testing_clinicalpathways/presentation/utils/AppConst.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final AuthUseCase authUseCase;

  AuthController(this.authUseCase);

  RxString errorMessage = "".obs;

  //TEXT FOCUS NODES
  FocusNode loginEmailNode = FocusNode(), loginPasswordNode = FocusNode();

  //TEXT EDITING CONTROLLERS
  TextEditingController loginEmailController = TextEditingController(),
      loginPasswordController = TextEditingController();

  RxBool isLoadingAuthPage = false.obs, loginPasswordObscure = true.obs;

  @override
  void onInit() {}



  Future<void> login() async {
    if (loginEmailController.text.isEmpty) {
      errorMessage.value = AppConst.enterEmailMessage;
      return;
    } else if (!loginEmailController.text.isEmail) {
      errorMessage.value = AppConst.enterValidEmailMessage;
      return;
    } else if (loginPasswordController.text.isEmpty) {
      errorMessage.value = AppConst.enterPasswordMessage;
      return;
    } else if (loginPasswordController.text.length < 6) {
      errorMessage.value = AppConst.passwordLengthMessage;
      return;
    }

    try {
      UserEntity user = await authUseCase.execute(loginEmailController.text, loginPasswordController.text);

      debugPrint("user ${user.email}");

      if (user.email != null) {
        //errorMessage.value = AppConst.loginSuccessful;

        //UPDATES USER DATA TO COOKIES TO SAVE THE LOGIN SESSION
        //UserCookies().setUserInfo( email: user.email ?? "",role: user.role ?? "",);
        UserCookies().addCookie(user.email ?? "", user.role ?? "",);

        //CLEARS ALL THE ROUTES TO NAVIGATE TO HOME SCREEN
        Get.offAllNamed(AppRoutes.home);
      } else {
        errorMessage.value = AppConst.invalidCredentials;
      }

      update();
    } catch (e) {
      // Handle login error
    }
  }



  void logout(){
    GetStorage().erase();
    Get.offAllNamed(AppRoutes.splash);
  }
}
