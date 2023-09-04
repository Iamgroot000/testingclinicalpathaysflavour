
import 'package:testing_clinicalpathways/presentation/bindings/AppBindings.dart';
import 'package:testing_clinicalpathways/presentation/routes/AppRoutes.dart';
import 'package:testing_clinicalpathways/presentation/views/homeScreen.dart';
import 'package:testing_clinicalpathways/presentation/views/loginScreen.dart';
import 'package:testing_clinicalpathways/presentation/views/splashScreen.dart';
import 'package:get/get.dart';

class AppPages {
  //NAMED CONSTRUCTOR
  AppPages._();


  //PAGES IN THE APPLICATION FOR NAVIGATION
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
        binding: SplashBinding()
    ),

    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
        binding: AuthBinding()
    ),

    GetPage(
        name: AppRoutes.home,
        page: () => HomeScreen(),
      binding: HomeBinding()
    ),



    // GetPage(
    //   name: DankRoutes.quiz,
    //   page: () => const QuizScreen(),
    //   binding: QuizBinding(),
    // ),


    // GetPage(
    //   name: DankRoutes.result,
    //   page: () => const ResultScreen(),
    //   binding: ResultBinding(),
    // ),
  ];


}