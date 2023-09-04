import 'package:testing_clinicalpathways/presentation/views/presentationLayerConnectors.dart';


/// SIDE MENU BAR WHICH SHOWS THE LIST OF FLOW CHARTS IN THE LEFT SIDE OF THE DASHBOARD
class SideMenuBar extends GetWidget<HomeController> {
  const SideMenuBar();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (logic) {
        return ListView.builder(
          itemCount: controller.homeEntityList.length,
          itemBuilder: (context, index) {
            bool isSelected = controller.selectedIndex == index;

            return Column(
              children: [
                Card(
                  elevation: isSelected ? 0 : 6, // Set elevation to 0 for selected item
                  color: isSelected ? AppColor.primaryColor : null, // Set green background for selected item
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      controller.updateSelectedIndex(index: index);
                    },
                    child: ListTile(
                      title: AutoSizeText(
                        controller.homeEntityList[index].flowchartName ?? "",
                      ),
                      trailing: const Icon(
                        Icons.arrow_right_alt,
                      ),
                    ),
                  ),
                ),
                // Divider(color: AppColor.grey.withOpacity(0.4))
              ],
            );
          },
        );
      },
    );
  }
}