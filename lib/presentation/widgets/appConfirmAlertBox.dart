import 'package:testing_clinicalpathways/presentation/exporter/appConstExport.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/AppColors.dart';
import '../utils/AppConst.dart';
import '../utils/ScreenSize.dart';
import 'appButtons.dart';

showConfirmAlertDialog({
  required BuildContext context,
  required String name,
  required String buttonText,
  required String confirmButtonText,
  required void Function()? onTapAction,})
    {
      showDialog(context: context, builder: (_){
        return ConfirmationDialog(
          context : context,
          name : name,
          buttonText: buttonText,
          confirmButtonText: confirmButtonText,
          onTapAction: () {  },);
  });
}

/// HOME SCREEN END DRAWER CONFIRMATION OF CREATE FIREBASE
class ConfirmationDialog extends StatelessWidget {
  final String name;
  final String buttonText;
  final String confirmButtonText;
  final void Function() onTapAction;

  const ConfirmationDialog({
    super.key,
    required BuildContext context,
    required this.name,
    required this.buttonText,
    required this.confirmButtonText,
    required this.onTapAction, // Assign passed function to variable
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(name),
      actions: [
        AppButton(
          buttonText: buttonText,
          onTap: () => Get.back(),
          width: ScreenSize.width(context) * 0.06,
          buttonColor: AppColor.grey,
        ),
        AppButton(
          buttonText: confirmButtonText,
          onTap: onTapAction,
          width: ScreenSize.width(context) * 0.06,
        ),
      ],
    );
  }
}




///YES OR NO DIALOG - GENERAL
yesNoDialog(
    {required BuildContext context,
      required String text,
      String? actionButton,
      String? cancelButton,
      required Future<void> Function()? onTapAction,
      void Function()? onTapCancel}) {
  bool _loading = false;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
            content: Builder(
              builder: (context) {
                return SizedBox(
                  height: ScreenSize.height(context) * 0.15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          text,
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: AppColor.black,
                              letterSpacing: 1
                          ),
                        ),
                      ),
                      SizedBox(height: ScreenSize.height(context) * 0.03),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: onTapCancel ??
                                      () {
                                    Get.back();
                                  },
                              child: Container(
                                height: ScreenSize.height(context) * 0.055,
                                width: ScreenSize.width(context) * 0.15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  color: AppColor.grey,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    cancelButton ?? 'Cancel',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  _loading = true;
                                });
                                if (onTapAction != null) {
                                  await onTapAction();
                                }
                                setState(() {
                                  _loading = false;
                                });
                              },
                              child: Container(
                                height: ScreenSize.height(context) * 0.055,
                                width: ScreenSize.width(context) * 0.15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  color: AppColor.primaryColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: _loading
                                      ? const CircularProgressIndicator(color: Colors.white)
                                      : Text(
                                    actionButton ?? AppConst.confirm,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenSize.height(context) * 0.02),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    },
  );
}

