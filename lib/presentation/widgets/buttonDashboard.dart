import 'package:testing_clinicalpathways/presentation/views/presentationLayerConnectors.dart';

import '../controllers/homeController.dart';


class DashboardButton extends GetWidget<HomeController> {

  DashboardButton({
    Key? key,
    required this.onTap,
    required this.title,
    required this.width,
}) : super(key: key);
    final Function() onTap;
    String title;
    var width;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: controller.isExpanded.value ? AppColor.green.withOpacity(0.9) : AppColor.green.withOpacity(0.9),
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: width,
        child: Center(
          child: AutoSizeText( title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
          ),
      ),
      )
    );
  }
}
