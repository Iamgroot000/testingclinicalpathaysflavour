import 'package:testing_clinicalpathways/presentation/routes/AppRoutes.dart';
import 'package:testing_clinicalpathways/presentation/views/endDrawerListView/addAgeCategories.dart';
import 'package:testing_clinicalpathways/presentation/views/endDrawerListView/addElement.dart';
import 'package:testing_clinicalpathways/presentation/views/endDrawerListView/addingDashboard.dart';
import 'package:testing_clinicalpathways/presentation/views/presentationLayerConnectors.dart';
import 'package:testing_clinicalpathways/presentation/widgets/appConfirmAlertBox.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: AppColor.white,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              /// IMAGE CONTAINER IN THE DASHBOARD
              Container(
                width: ScreenSize.width(context) * 0.17,
                height: ScreenSize.height(context) * 0.18,
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColor.greyShimmer.withOpacity(0.2))),
                child: Image.asset(AppImages.medongo),
              ),
              Expanded(
                child: SizedBox(
                    width: ScreenSize.width(context) * 0.17,
                    child: const SideMenuBar()),
              ),
            ],
          ),
          Stack(children: [
            Container(
              height: ScreenSize.height(context),
              width: ScreenSize.width(context) * 0.83,
              decoration: const BoxDecoration(
                color: AppColor.white,
              ),
              child: RepaintBoundary(
                child: FlowChartWidget(
                  dashboard: controller.dashboard,
                  onDashboardTapped: ((context, position) {
                    debugPrint('Dashboard tapped $position');
                    controller.createFlavoursList();
                    controller.resetForElement();
                    controller.loadDataFromDashboard(controller
                        .homeEntityList[controller.selectedIndex.value]);
                    // controller.customAgeGroupListForElement();
                    controller.updatePositionAndEnableDrawer(
                        enable: true, position: position);
                    // Open the end drawer
                    controller.scaffoldKey.currentState?.openEndDrawer();
                    // _displayDashboardMenu(context, position);
                  }),
                  onDashboardLongtTapped: ((context, position) {
                    debugPrint('Dashboard long tapped $position');
                    _displayDashboardMenu(context, position);
                  }),
                  onElementLongPressed: (context, position, element) {
                    debugPrint('Element with "${element.text}" text '
                        'long pressed');
                    _displayElementMenu(context, position, element);
                  },
                  onElementPressed: (context, position, element) {
                    debugPrint('Element with "${element.text}" text pressed');
                    controller.createFlavoursList();
                    controller.resetForElement();
                    controller.loadData(flowElement: element);
                    // controller.customAgeGroupListForElement();
                    controller.scaffoldKey.currentState?.openEndDrawer();
                  },
                  onHandlerPressed: (context, position, handler, element) {
                    debugPrint('handler pressed: position $position '
                        'handler $handler" of element $element');
                    _displayHandlerMenu(position, handler, element, context);
                  },
                  onHandlerLongPressed: (context, position, handler, element) {
                    debugPrint('handler long pressed: position $position '
                        'handler $handler" of element $element');
                  },
                  onElementSelectAndDrag: (context, position, element) {
                    // controller.updateIsDelete(isDelete: true);
                    debugPrint(
                        'handler element drag : position isDelete $position');
                    controller.flowElementId.value = element.id;
                  },
                ),
              ),
            ),
            Obx(() => controller.isAdminAccess.value
                ? Positioned(
                    // top: ScreenSize.height(context) * 0.01, // Specify position from bottom
                    right: ScreenSize.width(context) * 0.005,
                    // Center the container horizontally
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: AppColor.green.withOpacity(0.6),
                      child: Container(
                        height: ScreenSize.height(context) * 0.03,
                        width: ScreenSize.width(context) * 0.36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DashboardButton(
                              onTap: () {
                                return yesNoDialog(context: context,
                                  text: AppConst.areYouSureToUpdateDashboard,
                                  onTapAction: () async {await controller.confirmUpdateButton(context);
                                  },
                                );
                              },
                              title: AppConst.updateCapital,
                              width: ScreenSize.width(context) * 0.06,
                            ),
                            const VerticalDivider(),
                            DashboardButton(
                              onTap: () {
                                controller.dashboard.loadDashboard(controller.homeEntityList[controller.selectedIndex.value].flowchartId);
                              },
                              title: AppConst.load,
                              width: ScreenSize.width(context) * 0.06,
                            ),
                            const VerticalDivider(),
                            DashboardButton(
                              onTap: () {
                                controller.updateIsDashboard(AppConst.dashboard);
                                controller.resetForDashboard();
                                controller.scaffoldKey.currentState?.openEndDrawer();
                              },
                              title: AppConst.addDashboard,
                              width: ScreenSize.width(context) * 0.1,
                            ),
                            const VerticalDivider(),
                            DashboardButton(
                              onTap: () {
                                controller.updateIsDashboard(AppConst.category);
                                controller.resetForDashboard();
                                controller.scaffoldKey.currentState?.openEndDrawer();
                              },
                              title: AppConst.addCategory,
                              width: ScreenSize.width(context) * 0.1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: 0.00001,
                  )),
          ])
        ],
      ),
      endDrawer: Obx(() => controller.endDrawerType.value.isNotEmpty
          ? endDrawer()
          :  EndDrawerForAddElement()
      ),
      // endDrawer: EndDrawer(),
    );
  }

  Widget endDrawer() {
    switch (controller.endDrawerType.value) {
      case AppConst.category:
        return const EndDrawerForClinicalPathwayCategories();
      case AppConst.dashboard:
        return EndDrawer();
      default:
        return  EndDrawerForAddElement();
    }
  }
  /// Display a drop down menu when tapping on a handler
  _displayHandlerMenu(Offset position, Handler handler, FlowElement element, BuildContext context) {
    StarMenuOverlay.displayStarMenu(
      context,
      StarMenu(
        params: StarMenuParameters(
          shape: MenuShape.linear,
          openDurationMs: 60,
          linearShapeParams: const LinearShapeParams(
            angle: 270,
            space: 10,
          ),
          onHoverScale: 1.1,
          useTouchAsCenter: true,
          centerOffset: position -
              Offset(
                controller.dashboard.dashboardSize.width / 1,
                controller.dashboard.dashboardSize.height / 1,
              ),
        ),
        onItemTapped: (index, controller) => controller.closeMenu!(),
        items: [
          FloatingActionButton(
            child: const Icon(Icons.delete),
            onPressed: () =>
                controller.dashboard.removeElementConnection(element, handler),
          )
        ],
        parentContext: context,
      ),
    );
  }
  /// Display a drop down menu when tapping on an element
  _displayElementMenu(BuildContext context, Offset position, FlowElement element) {
    StarMenuOverlay.displayStarMenu(
      context,
      StarMenu(
        params: StarMenuParameters(
          shape: MenuShape.linear,
          openDurationMs: 60,
          linearShapeParams: const LinearShapeParams(
            angle: 270,
            alignment: LinearAlignment.left,
            space: 10,
          ),
          onHoverScale: 1.1,
          centerOffset: position - const Offset(50, 0),
          backgroundParams: const BackgroundParams(
            backgroundColor: Colors.transparent,
          ),
          boundaryBackground: BoundaryBackground(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).cardColor,
              boxShadow: kElevationToShadow[6],
            ),
          ),
        ),
        onItemTapped: (index, controller) {
          if (!(index == 5 || index == 2)) {
            controller.closeMenu!();
          }
        },
        items: [
          InkWell(
            onTap: () {
              controller.dashboard.setElementResizable(element, true);
            },
            child: const Text('Resize'),
          ),
          InkWell(
            onTap: () {
              int i = 1;
              final copiedShape = FlowElement(
                // Copy the properties from the original element
                selectedMode: element.selectedMode,
                isMandatory: element.isMandatory,
                ageGroupQuestion: element.ageGroupQuestion,
                genderGroup: element.genderGroup,
                options: element.options,
                selectedGroup: element.selectedGroup,
                size: element.size,
                backgroundColor: element.backgroundColor,
                elevation: element.elevation,
                borderColor: element.borderColor,
                borderThickness: element.borderThickness,
                handlers: element.handlers,
                kind: element.kind,
                text: '${element.text}a',
                id: const Uuid().v4(),
                position: position - const Offset(20, 15) + Offset((20 * i) as double, 0), // Adjust the values as per your requirements
              );

              controller.copiedShapes.add(copiedShape); // Store the copied shape in the list
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Shape copied!'),
                ),
              );
            },
            child: const Text('Copy'),
          ),
        ],
        parentContext: context,
      ),
    );
  }

  /// Display a linear menu for the dashboard
  /// with menu entries built with [menuEntries]
  _displayDashboardMenu(BuildContext context, Offset position) {
  StarMenuOverlay.displayStarMenu(
      context,
      StarMenu(
        params: StarMenuParameters(
          shape: MenuShape.linear,
          openDurationMs: 60,
          linearShapeParams: const LinearShapeParams(
            angle: 270,
            alignment: LinearAlignment.left,
            space: 10,
          ),
          centerOffset: position -
              Offset(
                controller.dashboard.dashboardSize.width / 2,
                controller.dashboard.dashboardSize.height / 2,
              ),
        ),
        onItemTapped: (index, controller) => controller.closeMenu!(),
        parentContext: context,
        items: [
          ActionChip(
            label: const Text(AppConst.pasteShape),
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(AppConst.pasteElement),
                    content: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        controller.numElements.value = int.tryParse(value) ?? 0;
                        },
                      decoration: const InputDecoration(labelText: AppConst.numberOfElementsToPaste,),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text(AppConst.cancel),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      TextButton(
                        child: const Text(AppConst.paste),
                        onPressed: () {
                          controller.pasteElement();
                          Get.back();// Clear the copiedShapes list after pasting
                        },
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
