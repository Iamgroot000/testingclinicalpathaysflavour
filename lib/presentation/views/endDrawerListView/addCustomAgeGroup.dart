
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:testing_clinicalpathways/presentation/views/presentationLayerConnectors.dart';

import '../presentationLayerConnectors.dart';

///FOR ADDING CUSTOM AGE GROUPS
class AgeGroupItemInputDialog extends GetWidget<HomeController> {
  const AgeGroupItemInputDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: ScreenSize.width(context) * 0.6,
        ),
        AlertDialog(
          title: Container(
              height: ScreenSize.height(context) * 0.05,
              width: ScreenSize.width(context) * 0.2,
              decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: const Center(child: Text(AppConst.addAgeGroupItem))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: AppConst.groupName,
                ),
                onChanged: (value) {
                  controller.groupName.value = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: AppConst.startAge,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true), // Allow decimal input
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d{0,3}(\.\d{0,3})?)$')),
                ],// Custom input filter
                onChanged: (value) {
                  controller.start.value = double.tryParse(value) ??
                      0.0; // Use a default value if parsing fails
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: AppConst.endAge,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true), // Allow decimal input
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d{0,3}(\.\d{0,3})?)$')),
                ], // Custom input filter
                onChanged: (value) {
                  controller.end.value = double.tryParse(value) ??
                      0.0; // Use a default value if parsing fails
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog without saving
              },
              child: const Text(AppConst.cancel),
            ),
            TextButton(
              onPressed: () {
                // controller.customAgeGroupListForElement();
                controller.addAgeGroupWithStartAndEndAgeOnPressButtonAdd(context);
              },
              child: const Text(AppConst.add),
            ),
          ],
        ),
      ],
    );
  }
}