import 'package:testing_clinicalpathways/data/repositories/authRepository.dart';
import 'package:testing_clinicalpathways/data/repositories/homeRepository.dart';
import 'package:testing_clinicalpathways/domain/repositories/authRepositoryInterface.dart';
import 'package:testing_clinicalpathways/domain/repositories/homeRepositoryInterface.dart';
import 'package:testing_clinicalpathways/domain/usecases/authUseCase.dart';
import 'package:testing_clinicalpathways/domain/usecases/homeUseCase.dart';
import 'package:testing_clinicalpathways/presentation/controllers/authController.dart';
import 'package:testing_clinicalpathways/presentation/controllers/homeController.dart';
import 'package:testing_clinicalpathways/presentation/controllers/splashController.dart';
import 'package:get/get.dart';



class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}


class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(Get.find()));
    Get.lazyPut<AuthenticationRepositoryInterface>(() => AuthenticationRepository(),);
    Get.lazyPut(() => AuthUseCase(Get.find()),);
  }
}


class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(Get.find()));
    Get.lazyPut<HomeRepositoryInterface>(() => HomeRepository());
    Get.lazyPut(() => HomeUseCase(Get.find()),);
  }
}


//


