import 'package:testing_clinicalpathways/presentation/views/presentationLayerConnectors.dart';



class AgeGroupEdit extends GetWidget<HomeController> {
  const AgeGroupEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.ageGroupList.value.isNotEmpty ?
    Container(
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
           Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText("Age Groups".toUpperCase(), style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    color: AppColor.primaryColor
                  ),
                    minFontSize: AppThemes
                        .titleTextFontThemeDarkMinimumSize,
                    maxFontSize: AppThemes
                        .titleTextFontThemeDarkMaximumSize,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child:ListView.builder(
              itemCount: controller.ageGroupList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ExpansionTileCard(
                        elevation: 8,
                        baseColor: AppColor.greyShimmer.withOpacity(0.4),
                        expandedTextColor: AppColor.black,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: ScreenSize.height(context) *
                                  0.004,
                            ),
                            /// Header
                            Card(
                              elevation : 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: SizedBox(
                                height: ScreenSize.height(context) * 0.04,
                                width: ScreenSize.width(context) * 0.4,
                                child: Center(
                                  child: AutoSizeText(
                                    controller.ageGroupList[index].groupName?.toUpperCase() ?? "",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 2,
                                    ),
                                    minFontSize: AppThemes
                                        .titleTextFontThemeDarkMinimumSize,
                                    maxFontSize: AppThemes
                                        .titleTextFontThemeDarkMaximumSize,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: ScreenSize.height(context) *
                                  0.004,
                            ),
                            /// Body
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: ScreenSize.width(context) * 0.008),
                                        const AutoSizeText(
                                          "START AGE : ",
                                          style:
                                          TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                                          minFontSize: AppThemes.titleTextFontThemeDarkMinimumSize,
                                          maxFontSize: AppThemes.titleTextFontThemeDarkMaximumSize,
                                        ),
                                        SizedBox(width: ScreenSize.width(context) * 0.01),
                                        AutoSizeText(
                                          "${controller.ageGroupList[index].start?.toString()}",
                                          style:
                                          const TextStyle(fontSize: 15),
                                          minFontSize: AppThemes.titleTextFontThemeDarkMinimumSize,
                                          maxFontSize: AppThemes.titleTextFontThemeDarkMaximumSize,
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: ScreenSize.width(context) * 0.04),
                                    Row(
                                      children: [
                                        const AutoSizeText(
                                          "END AGE : ",
                                          style:
                                          TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                                          minFontSize: AppThemes.titleTextFontThemeDarkMinimumSize,
                                          maxFontSize: AppThemes.titleTextFontThemeDarkMaximumSize,
                                        ),
                                        SizedBox(width: ScreenSize.width(context) * 0.01),
                                        AutoSizeText(
                                          " ${controller.ageGroupList[index].end?.toString()}",
                                          style:
                                          const TextStyle(fontSize: 15),
                                          minFontSize: AppThemes.titleTextFontThemeDarkMinimumSize,
                                          maxFontSize: AppThemes.titleTextFontThemeDarkMaximumSize,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 0.01,),
                                Padding(
                                  padding: const EdgeInsets.only(top : 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(width: ScreenSize.width(context) * 0.0008),
                                          const AutoSizeText(
                                            "START RANGE : ",
                                            style:
                                            TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                                            minFontSize: AppThemes.titleTextFontThemeDarkMinimumSize,
                                            maxFontSize: AppThemes.titleTextFontThemeDarkMaximumSize,
                                          ),
                                          SizedBox(width: ScreenSize.width(context) * 0.001),
                                          AutoSizeText(
                                            "${controller.ageGroupList[index].startRange?.toString()}",
                                            style:
                                            const TextStyle(fontSize: 15),
                                            minFontSize: AppThemes.titleTextFontThemeDarkMinimumSize,
                                            maxFontSize: AppThemes.titleTextFontThemeDarkMaximumSize,
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: ScreenSize.width(context) * 0.04),
                                      Row(
                                        children: [
                                          const AutoSizeText(
                                            "END RANGE : ",
                                            style:
                                            TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                                            minFontSize: AppThemes.titleTextFontThemeDarkMinimumSize,
                                            maxFontSize: AppThemes.titleTextFontThemeDarkMaximumSize,
                                          ),
                                          AutoSizeText(
                                            "${controller.ageGroupList[index].endRange?.toString()}",
                                            style:
                                            const TextStyle(fontSize: 15),
                                            minFontSize: AppThemes.titleTextFontThemeDarkMinimumSize,
                                            maxFontSize: AppThemes.titleTextFontThemeDarkMaximumSize,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left : 25.0, top: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const AutoSizeText(
                                            "is Mandatory :",
                                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                                            minFontSize: AppThemes.titleTextFontThemeDarkMinimumSize,
                                            maxFontSize: AppThemes.titleTextFontThemeDarkMaximumSize,
                                          ),
                                          AutoSizeText(
                                            "${controller.ageGroupList[index].isMandatory?.toString()}",
                                            style:  TextStyle(fontSize: 15,
                                              color: controller.ageGroupList[index].isMandatory! ? AppColor.blue : AppColor.red,
                                            ),
                                            minFontSize: AppThemes.titleTextFontThemeDarkMinimumSize,
                                            maxFontSize: AppThemes.titleTextFontThemeDarkMaximumSize,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        children: [
                          SizedBox(
                            height:
                            ScreenSize.height(context) * 0.22,
                            width: ScreenSize.width(context) * 1,
                            child: ListTile(
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex:1,
                                            child: TextField(
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(RegExp(r'^(\d{0,5}(\.\d{0,3})?)$')),
                                              ],
                                              controller: controller.startRangeController,
                                              decoration :const InputDecoration(
                                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(2)),),
                                                hintText: "Enter Start Range",
                                                labelText: "Start Range",
                                                contentPadding: EdgeInsets.all(8.0),
                                                  fillColor: Colors.grey
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            flex:1,
                                            child: TextField(
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(RegExp(r'^(\d{0,5}(\.\d{0,3})?)$')),
                                              ],
                                                  decoration :const InputDecoration(
                                                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(2)),),
                                                      hintText: "Enter End Range",
                                                      labelText: "End Range",
                                                      contentPadding: EdgeInsets.all(8.0),
                                                  fillColor: Colors.grey),
                                              controller: controller.endRangeController,
                                              onChanged: (value) {
                                                // update the end age value in the age group object
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          const AutoSizeText(
                                            "is Mandatory",
                                            style:
                                            TextStyle(fontSize: 15),
                                            minFontSize: AppThemes
                                                .titleTextFontThemeDarkMinimumSize,
                                            maxFontSize: AppThemes
                                                .titleTextFontThemeDarkMaximumSize,
                                          ),
                                          Checkbox(
                                            value:
                                            controller.ageGroupList[index]
                                                .isMandatory,
                                            onChanged: (bool? value) {
                                              controller.ageGroupList[index]
                                                  .isMandatory = value ?? false;
                                              controller.updateListOfAgeGroupItems();
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  const Divider(),
                                  Container(
                                    height: ScreenSize.height(context) * 0.05,
                                    width: ScreenSize.width(context) * 1,
                                    margin: const EdgeInsets.only(bottom: 8),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor.greyShimmer),
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColor.primaryColor,
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        controller.updateRangeForAgeGroup(index);
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
                            controller.startRangeController.text = (controller.ageGroupList[index].startRange?.toString().compareTo("null") == 0 ? '' : controller.ageGroupList[index].startRange?.toString())! ;
                            controller.endRangeController.text = (controller.ageGroupList[index].endRange?.toString().compareTo("null") == 0 ? '' : controller.ageGroupList[index].endRange?.toString())!;
                          }
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
              child: SizedBox(
                height: 60, // specify your desired height
                width: double.infinity, // to expand the width
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // specify your desired radius
                      ),
                    ),
                    child: const Text("OK"),
                    onPressed: () {
                      controller.updateIsExtented(
                          isExtented: false,
                          isOptionsDialog: true);
                    }),
              ),
            ),
          )
        ],
      ),
    ) : Center(child: Container(child: const Text("No Age Group"),)),
    );
  }
}