

import 'package:testing_clinicalpathways/presentation/views/presentationLayerConnectors.dart';



/// END DRAWER TO ADD AGE GROUP AND UPDATE THE START AGE AND END AGE OF THE PARTICULAR AGE GROUP ----------> (NEONATAL, TODDLER)
class EditStartAndEndAgeFormCategories extends GetWidget<HomeController> {
  const EditStartAndEndAgeFormCategories();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: controller.scaffoldKey1,
      body: Builder(
        builder: (BuildContext context) {
          return Drawer(
            width: ScreenSize.width(context) * 0.3,
            backgroundColor: AppColor.white,
            child: GetBuilder(
              init: controller,
              builder: (_) {
                return FutureBuilder<List<AgeGroupItem>>(
                  future: controller.loadAgeGroups(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: controller.ageGroupItemList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              controller.updateSelectedIndex(index: index);
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ExpansionTileCard(
                                    elevation: 4,
                                    expandedTextColor: AppColor.black,
                                    title: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: ScreenSize.height(context) *
                                              0.004,
                                        ),
                                        Center(
                                          child: AutoSizeText(
                                            controller.ageGroupItemList[index]
                                                .groupName
                                                ?.toUpperCase() ??
                                                "",
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 2,
                                            ),
                                            minFontSize: AppThemes
                                                .titleTextFontThemeDarkMinimumSize,
                                            maxFontSize: AppThemes
                                                .titleTextFontThemeDarkMaximumSize,
                                          ),
                                        ),
                                        SizedBox(
                                          height: ScreenSize.height(context) *
                                              0.004,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              "START AGE - ${controller.ageGroupItemList[index].start?.toString()}",
                                              style:
                                              const TextStyle(fontSize: 15),
                                              minFontSize: AppThemes
                                                  .titleTextFontThemeDarkMinimumSize,
                                              maxFontSize: AppThemes
                                                  .titleTextFontThemeDarkMaximumSize,
                                            ),
                                            SizedBox(
                                              height:
                                              ScreenSize.height(context) *
                                                  0.009,
                                            ),
                                            AutoSizeText(
                                              "END AGE - ${controller.ageGroupItemList[index].end?.toString()}",
                                              style:
                                              const TextStyle(fontSize: 15),
                                              minFontSize: AppThemes
                                                  .titleTextFontThemeDarkMinimumSize,
                                              maxFontSize: AppThemes
                                                  .titleTextFontThemeDarkMaximumSize,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    children: [
                                      SizedBox(
                                        height:
                                        ScreenSize.height(context) * 0.15,
                                        width: ScreenSize.width(context) * 1,
                                        child: ListTile(
                                          title: Column(
                                            children: [
                                              const Divider(),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          "Start Age",
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                          ScreenSize.height(
                                                              context) *
                                                              0.05,
                                                          width:
                                                          ScreenSize.width(
                                                              context) *
                                                              0.09,
                                                          child: TextField(
                                                            decoration:
                                                            const InputDecoration(
                                                                fillColor:
                                                                Colors
                                                                    .grey),
                                                            controller: controller
                                                                .startAgeController,
                                                            onChanged: (value) {
                                                              // update the start age value in the age group object
                                                              controller
                                                                  .ageGroupItemList[
                                                              index]
                                                                  .start =
                                                                  double
                                                                      .tryParse(
                                                                      value);
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          "End Age",
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                          ScreenSize.height(
                                                              context) *
                                                              0.05,
                                                          width:
                                                          ScreenSize.width(
                                                              context) *
                                                              0.09,
                                                          child: TextField(
                                                            decoration:
                                                            const InputDecoration(
                                                                fillColor:
                                                                Colors
                                                                    .grey),
                                                            controller: controller
                                                                .endAgeController,
                                                            onChanged: (value) {
                                                              // update the end age value in the age group object
                                                              controller
                                                                  .ageGroupItemList[
                                                              index]
                                                                  .end =
                                                                  double
                                                                      .tryParse(
                                                                      value);
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Divider(),
                                              Container(
                                                height:
                                                ScreenSize.height(context) *
                                                    0.04,
                                                width:
                                                ScreenSize.width(context) *
                                                    1,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                      AppColor.greyShimmer),
                                                  borderRadius:
                                                  BorderRadius.circular(15),
                                                  color: AppColor.primaryColor,
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    controller
                                                        .updateAgeGroup(index);
                                                  },
                                                  child: const Text(
                                                    "UPDATE",
                                                    style: TextStyle(
                                                      color: AppColor.white,
                                                      fontWeight:
                                                      FontWeight.w900,
                                                      letterSpacing: 2,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                    onExpansionChanged: (isExpanded) {
                                      if (isExpanded) {
                                        controller.startAgeController.text =
                                            controller.ageGroupItemList[index]
                                                .start
                                                ?.toString() ??
                                                '';
                                        controller.endAgeController.text =
                                            controller
                                                .ageGroupItemList[index].end
                                                ?.toString() ??
                                                '';
                                      }
                                    },
                                  ),
                                ),
                              ],
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
          );
        },
      ),
    );
  }
}