import 'package:testing_clinicalpathways/presentation/views/presentationLayerConnectors.dart';


///DIALOG BOX FOR ADDING OPTIONS TO (OPTIONS/MULTI-OPTIONS)
class AddOptionsDialogState extends GetWidget<HomeController> {
  const AddOptionsDialogState({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Container(
        decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(
                color: AppColor.greyShimmer,
                width: 1.0,
              ),
            )),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Top Title and Add Icon
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const AutoSizeText(
                      AppConst.enterOptions,
                      style: AppThemes.titleTextFontThemeDark,
                    ),
                    SizedBox(
                      width: ScreenSize.width(context) * 0.07,
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle),
                      color: AppColor.primaryColor,
                      tooltip: AppConst.addOption,
                      onPressed: () {
                        controller.addTextControllers();
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              child: Divider(),
            ),
            Expanded(
              flex: 7,
              child: ListView.builder(
                itemCount: controller.optionTextController.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.primaryColor,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller.optionTextController[index],
                              decoration: InputDecoration(
                                hintText: "${AppConst.enterOptions} ${index + 1}",
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(12.0),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove_circle),
                            color: AppColor.red,
                            tooltip: AppConst.removeOption,
                            onPressed: () {
                              controller.removeTextControllers(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              child: Divider(),
            ),
            // OK Button
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                child: SizedBox(
                  height: ScreenSize.height(context) * 0.04, // specify your desired height
                  width: double.infinity, // to expand the width
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30), // specify your desired radius
                        ),
                      ),
                      child: const Text(AppConst.ok),
                      onPressed: () {
                        controller.addOptionsInElement();
                      }
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}