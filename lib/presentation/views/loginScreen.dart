import 'package:testing_clinicalpathways/presentation/views/presentationLayerConnectors.dart';
import 'package:testing_clinicalpathways/presentation/exporter/appConstExport.dart';
import 'package:testing_clinicalpathways/presentation/exporter/widgetExport.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              //key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: ScreenSize.height(context) * 0.175,
                        width: ScreenSize.height(context) * 0.25,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppImages.medongo),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      ///EMAIL
                      SizedBox(
                        width: ScreenSize.width(context) * 0.25,
                        child: CustomTextField(
                          title: 'Email',
                          hint: 'Email',
                          customHeight: ScreenSize.height(context) * 0.05,
                          icon: const Icon(
                            Icons.email,
                            color: AppColor.primaryColor,
                          ),
                          controller: controller.loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          node: controller.loginEmailNode,
                          onSubmit: (val) => controller.loginPasswordNode.requestFocus(),
                        ),
                      ),

                      ///PASSWORD
                      Obx(
                            () =>
                            SizedBox(
                              width: ScreenSize.width(context) * 0.25,
                              child: CustomTextField(
                                title: 'Password',
                                hint: 'Password',
                                customHeight: ScreenSize.height(context) * 0.05,
                                controller: controller.loginPasswordController,
                                icon: const Icon(
                                  Icons.key,
                                  color: AppColor.primaryColor,
                                ),
                                node: controller.loginPasswordNode,
                                onSubmit: (val) => controller.loginPasswordNode.unfocus(),
                                obscure: controller.loginPasswordObscure.value,
                                iconData: controller.loginPasswordObscure.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                iconTap: () =>
                                controller.loginPasswordObscure.value =
                                !controller.loginPasswordObscure.value,
                              ),
                            ),
                      ),
                    ],
                  ),
                )),

            const SizedBox(
              height: 5,
            ),

            Obx(() =>
               AutoSizeText(
                 controller.errorMessage.value,
                 style: AppThemes.textErrorMessageFontTheme,
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            SizedBox(
              width: ScreenSize.width(context) * 0.25,
              child: AppButton(
                  buttonText: AppConst.login,
                  onTap: () async {
                    await controller.login();
                  }
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
