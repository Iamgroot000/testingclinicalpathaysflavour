import 'dart:convert';

import 'package:testing_clinicalpathways/domain/entities/flowChartEntities/getFlowChartEntitiesConnector.dart';

class ElementShapeEntity {
  FlowElement? flowElement;
  String? flowElementImage;
  String? flowElementName;
  String? flowElementDescription;
  // bool? textEditor;
  // bool? isNumeric;
  // bool? isOptions;
  // bool? isMultiOptions;
  // bool? isDateField;
  // bool? isDateTimeField;
  List<String> typeMode;
  String selectedmode;
  List<String> extraOptions;


  ElementShapeEntity({
    required this.flowElement,
    required this.flowElementImage,
    required this.flowElementName,
    required this.flowElementDescription,
    // required this.textEditor,
    // required this.isNumeric,
    // required this.isOptions,
    // required this.isMultiOptions,
    // required this.isDateField,
    // required this.isDateTimeField,
    required this.typeMode,
    required this.selectedmode,
    required this.extraOptions,


  });

  Map<String, dynamic> toJson() {
    return {
      "flowElement": this.flowElement,
      "flowElementImage": this.flowElementImage,
      "flowElementName": this.flowElementName,
      "flowElementDescription": this.flowElementDescription,
      "typeMode": jsonEncode(this.typeMode),
      "selectedmode": this.selectedmode,
      "extraOptions": jsonEncode(this.extraOptions),
    };
  }
}