import 'dart:async';

import 'package:testing_clinicalpathways/domain/cookies/userCookies.dart';
import 'package:testing_clinicalpathways/presentation/routes/AppRoutes.dart';
import 'package:testing_clinicalpathways/presentation/views/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {

  @override
  void onInit() async {
    await checkAuth();
  }

  //OBJECT OF USER COOKIES MODEL
  late UserCookiesModel userCookiesModel;

  ///CHECK AUTHENTICATION STATUS
  checkAuth() async {
    ///GETS DATA FROM COOKIES
    //userCookiesModel = await UserCookies().getUserInfo();
    userCookiesModel = await UserCookies().getCookie();


    Future.delayed(
      const Duration(seconds: 2),
      () {
        print("TESTING IN SPLASH CONTROLLER ${userCookiesModel.email}");


        ///IF THE DATA  IS EMPTY NAVIGATES TO LOGIN PAGE
        if (userCookiesModel.email == "" || userCookiesModel.email == null) {
          ///NAVIGATES TO LOGIN PAGE
          Get.offAllNamed(AppRoutes.login);
        }

        ///IF THE USER IS ALREADY LOGGED IN NAVIGATES HOME PAGE
        else {
          ///FETCHES USER PROFILE FROM THE INTERNET
          //await itUserController.getCurrentUserInfo();
          ///NAVIGATES TO HOME PAGE
          Get.offAllNamed(AppRoutes.home);
        }
      },
    );
  }


}
