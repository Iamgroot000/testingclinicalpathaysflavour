import 'package:testing_clinicalpathways/presentation/bindings/AppBindings.dart';
import 'package:testing_clinicalpathways/presentation/routes/AppPages.dart';
import 'package:testing_clinicalpathways/presentation/routes/AppRoutes.dart';
import 'package:testing_clinicalpathways/presentation/utils/AppConst.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

//START POINT OF THE APPLICATION
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //FIREBASE INITIALISATION
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //RUNS THE MAIN APP
  runApp(const ClinicalPathwayApp());
}




//GET MATERIAL APP
class ClinicalPathwayApp extends StatelessWidget {
  const ClinicalPathwayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConst.appTitle,
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}
