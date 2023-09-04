import 'package:testing_clinicalpathways/presentation/views/presentationLayerConnectors.dart';
import 'package:testing_clinicalpathways/presentation/widgets/chipChoiceMultiple.dart';
import 'package:testing_clinicalpathways/presentation/widgets/chipChoiceSingle.dart';
import 'package:testing_clinicalpathways/presentation/widgets/shimmer.dart';


/// END DRAWER TO ADD/DELETE HOME ENTITY (DASHBOARD) ITEM
class EndDrawer extends GetWidget<HomeController> {
  const EndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Obx(() => Drawer(
          width: controller.isListItemsOfDashboards.value
              ? ScreenSize.width(context) * 0.56
              : ScreenSize.width(context) * 0.35,
          backgroundColor: AppColor.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder(
                  init: controller,
                  builder: (_) {
                    return Container(
                      width: ScreenSize.width(context) * 0.34,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0, left: 8.0),
                                child: SizedBox(
                                  width: ScreenSize.width(context) * 0.25,
                                  height: ScreenSize.height(context) * 0.08,
                                  child: const AutoSizeText(
                                    AppConst.addDashboard,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.menu),
                                onPressed: () {
                                  controller.updateIsListItemsOfDashboards();
                                },
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: ScreenSize.width(context) * 0.34,
                              decoration: BoxDecoration(
                                  border: Border.all( color: AppColor.grey.withOpacity(0.3)),
                                  borderRadius:
                                  BorderRadius.circular(20.0)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //FLOW CHART NAME TEXT FIELD
                                  CustomTextField(
                                    controller: controller.flowchartNameController ?? TextEditingController(),
                                    title: AppConst.flowchartName ?? '',
                                    labelText: AppConst.flowchartName ?? '',
                                    hint: AppConst.flowchartName ?? '',
                                    hintTextSize: 12.0,
                                    customHeight: ScreenSize.height(context) * 0.2,
                                    onChanged: (val) =>
                                        controller.isFlowchartNameAvailable(
                                            flowchartName: val),
                                  ),

                                  ///QUESTION CATEGORIES
                                  Padding(
                                      padding:
                                      const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Question Category',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight:
                                              FontWeight.bold,
                                            ),
                                          ),
                                          SingleChipChoice(
                                            selectedValue: controller
                                                .selectedCategory.value,
                                            choiceList: controller
                                                .clinicalPathwayCategoriesList
                                                .categoryList,
                                            onChanged: (val) {
                                              controller.updateQuestionCategory(val);
                                            },
                                            valueFn: (i, v) => v,
                                            labelFn: (i, v) => v,
                                            tooltipFn: (i, v) => v,
                                          ),
                                        ],
                                      )),



                                  ///flavour categories
                                  Padding(
                                      padding:
                                      const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Flavour Category',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight:
                                              FontWeight.bold,
                                            ),
                                          ),
                                          SingleChipChoice(
                                            selectedValue: controller
                                                .selectedFlavour.value,
                                            choiceList: controller
                                                .clinicalPathwayFlavourCategoriesList
                                                .flavourList,
                                            onChanged: (val) {
                                              controller.updateFlavourList(val);
                                            },
                                            valueFn: (i, v) => v,
                                            labelFn: (i, v) => v,
                                            tooltipFn: (i, v) => v,
                                          ),
                                        ],
                                      )),



                                  /// GENDER
                                  Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Gender',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          MultipleChipChoice(
                                            selectedValues: controller
                                                .selectedGenders.value,
                                            choiceList: controller
                                                .genderGroupStandardList
                                                .value
                                                .genderGroupList,
                                            onChanged: (val) {
                                              controller.updateGenderList(val);
                                            },
                                            valueFn: (i, v) => v,
                                            labelFn: (i, v) => v,
                                            tooltipFn: (i, v) => v,
                                          ),
                                        ],
                                      )),

                                  ///AGE OPTIONS
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                'Age Group',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                ),
                                              ),
                                              IconButton(
                                                tooltip: 'Select All',
                                                icon: const Icon(Icons
                                                    .library_add_check_outlined),
                                                onPressed: () {
                                                  controller.selectAllAgeGroups();
                                                },
                                              ),
                                              IconButton(
                                                tooltip: 'Deselect All',
                                                icon: const Icon(Icons
                                                    .indeterminate_check_box_outlined),
                                                onPressed: () {
                                                  controller.deselectAllAgeGroups();
                                                },
                                              ),
                                            ],
                                          ),
                                          ChipsChoice<String>.multiple(
                                            value: controller
                                                .selectedAges.value,
                                            onChanged: (val) {
                                              controller
                                                  .selectedAges.value = val;
                                              controller.updateListOfAgeGroupItems();
                                            },
                                            choiceItems: C2Choice.listFrom<
                                                String, AgeGroupItem>(
                                              source: controller
                                                  .ageGroupItemList,
                                              value: (i, v) => v.groupName!,
                                              label: (i, v) => v.groupName!,
                                              tooltip: (i, v) =>
                                              "Start :${v.start}, End :${v.end}",
                                            ),
                                            choiceCheckmark: true,
                                            choiceStyle: C2ChipStyle.filled(
                                              overlayColor:
                                              AppColor.primaryColor,
                                              foregroundStyle:
                                              const TextStyle(
                                                  fontWeight:
                                                  FontWeight.w700),
                                              height: ScreenSize.height(
                                                  context) *
                                                  0.04,
                                              color: AppColor.greyShimmer,
                                              selectedStyle:
                                              const C2ChipStyle(
                                                elevation: 2,
                                                backgroundColor:
                                                AppColor.primaryColor,
                                                borderRadius:
                                                BorderRadius.all(
                                                  Radius.circular(25),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )),

                                  ///ERROR MESSAGE SPACE

                                  Obx(() => AutoSizeText(
                                      controller.errorMessage.value ?? '',
                                      textAlign: TextAlign.end,
                                      style: controller.flowchartNameAvailable.value ?? false
                                          ? AppThemes.textSuccessMessageFontTheme
                                          : AppThemes.textErrorMessageFontTheme)),

                                  const SizedBox(height: 10.0),

                                  //ADD OR CANCEL - FLOWCHART'S DASHBOARD
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width:
                                        ScreenSize.width(context) * 0.1,
                                        child: AppButton(
                                          height:
                                          ScreenSize.height(context) *
                                              0.05,
                                          buttonText: AppConst.cancel,
                                          buttonColor:
                                          AppColor.tertiaryColor,
                                          onTap: () {
                                            controller
                                                .flowchartNameController
                                                .clear();
                                            controller.errorMessage.value =
                                            "";
                                            controller
                                                .addHomeEntityButtonLoading
                                                .value = false;
                                            Get.back();
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                        ScreenSize.width(context) * 0.1,
                                        child: AppButton(
                                          height:
                                          ScreenSize.height(context) *
                                              0.05,
                                          buttonText: AppConst.create,
                                          onTap: () async {
                                            await controller.addDashboard();
                                          },
                                        ),
                                      )
                                    ],
                                  ),

                                  const SizedBox(height: 16.0),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              Visibility(
                visible: controller.isListItemsOfDashboards.value,
                child: Container(
                    width: ScreenSize.width(context) * 0.2,
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(color: AppColor.greyShimmer),
                      )
                    ),
                    padding: const EdgeInsets.only(left: 8.0),
                    child: controller.isListItemsOfDashboards.value
                        ? const _ListItemsOfDashboards()
                        : const SizedBox.shrink()),
              ),
            ],
          ),
        ));
      },
    );
  }
}

/// LIST ITEMS FOR THE DASHBOARD FLOW CHARTS ( HOME ENTITY )
class _ListItemsOfDashboards extends GetWidget<HomeController> {
  const _ListItemsOfDashboards();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DashboardEntity>>(
        future: controller.loadFlowcharts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: controller.homeEntityList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      controller.selectedIndex.value = index;
                    },
                    child: Card(
                      elevation: 4,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: AutoSizeText(
                            controller.homeEntityList[index].flowchartName ?? "",
                            style: AppThemes.titleTextFontThemeDark,
                            minFontSize:
                            AppThemes.titleTextFontThemeDarkMinimumSize,
                            maxFontSize:
                            AppThemes.titleTextFontThemeDarkMaximumSize,
                          ),
                          trailing: const Icon(
                            Icons.delete,
                          ),
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return const ShimmerForLoading();
          }
        });
  }
}