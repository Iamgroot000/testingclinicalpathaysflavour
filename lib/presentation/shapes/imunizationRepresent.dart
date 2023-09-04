import 'package:flutter/material.dart';

import 'package:testing_clinicalpathways/domain/entities/flowChartEntities/getFlowChartEntitiesConnector.dart';
import 'package:get/get.dart';
import '../widgets/elementText.dart';

/// A kind of element
class ImmunizationRectangleWidget extends GetWidget {
  final FlowElement element;

  const ImmunizationRectangleWidget({
    Key? key,
    required this.element,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: element.size.width,
      height: element.size.height,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: element.backgroundColor,
              boxShadow: [
                if (element.elevation > 0.01)
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(element.elevation, element.elevation),
                    blurRadius: element.elevation * 0.7,
                  ),
              ],
              border: Border.all(
                color: element.borderColor,
                width: element.borderThickness,
              ),
            ),
          ),
          ElementTextWidget(element: element),
        ],
      ),
    );
  }
}