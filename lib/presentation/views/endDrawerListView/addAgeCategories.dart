import 'package:testing_clinicalpathways/presentation/views/presentationLayerConnectors.dart';

/// END DRAWER TO ADD/EDIT CLINICAL PATHWAYS CATEGORIES ITEM ---------> (PERSONAL, VITALS, CLINICAL)
class EndDrawerForClinicalPathwayCategories extends GetWidget<HomeController> {
  const EndDrawerForClinicalPathwayCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Drawer(
          width: ScreenSize.width(context) * 0.3,
          backgroundColor: AppColor.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 8.0),
                child: SizedBox(
                  width: ScreenSize.width(context) * 0.35,
                  height: ScreenSize.height(context) * 0.075,
                  child: const AutoSizeText(
                    AppConst.addCategories,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                ),
                child: ExpansionTile(
                  collapsedTextColor: AppColor.black,
                  textColor: AppColor.black,
                  onExpansionChanged: (bool expanded) {
                    if (expanded) {
                      controller.toggleExpanded();
                    }
                  },
                  title: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppConst.addCategory,
                        style: AppThemes.titleTextFontThemeDark,
                      ),
                    ],
                  ),
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        SizedBox(
                          height: ScreenSize.height(context) * 0.05,
                          width: ScreenSize.width(context) * 0.6,
                          child: TextField(
                            controller: controller.addCategoriesController,
                            decoration: InputDecoration(
                              labelText: AppConst.enterCategoryName,
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        AppButton(
                          buttonText: AppConst.submit,
                          onTap: () {
                            controller.addAgeCategories();
                          },
                          buttonColor: AppColor.primaryColor,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Divider(),
              Obx(
                () => SizedBox(
                  height: controller.isExpanded.value
                      ? ScreenSize.height(context) * 0.65
                      : ScreenSize.height(context) * 0.65,
                  width: ScreenSize.width(context) * 0.3,
                  child: GetBuilder(
                    init: controller,
                    builder: (logic) {
                      return FutureBuilder(
                        future: controller.loadClinicalPathwayCategories(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: controller
                                  .clinicalPathwayCategoriesList
                                  .categoryList
                                  .length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: Card(
                                    elevation: 4,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                    ),
                                    child: SizedBox(
                                      height: ScreenSize.height(context) * 0.09,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: ListTile(
                                          title: Text(
                                            controller
                                                    .clinicalPathwayCategoriesList
                                                    .categoryList[index] ??
                                                "",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
