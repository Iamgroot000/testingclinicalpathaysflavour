library clinicalpathways.globals;

import 'package:testing_clinicalpathways/domain/entities/flowChartEntities/elementShapeEntity.dart';
import 'package:testing_clinicalpathways/presentation/controllers/flowElementsController.dart';
import 'package:testing_clinicalpathways/presentation/utils/AppConst.dart';
import 'package:testing_clinicalpathways/presentation/utils/AppImages.dart';
import 'package:flutter/material.dart';

// List<String> groups = ['Select From Below','Personal', 'Social', 'Clinical History', 'Screening', 'Anemia Assessment', 'Referral'];
// List<String> inputMode = ['none','text','numeric','date','dateTime','duration','options', 'multiOptions'];
// List<String> mandatory = ["true", "false"];


List<String> groups = ['Select From Below','Personal', 'Social', 'Clinical History', 'Screening', 'Anemia Assessment', 'Referral'];
List<String> inputMode = ['none','text','numeric','date','dateTime','duration','options', 'multiOptions'];
List<String> mandatory = ["true", "false"];

List<Map<String, dynamic>> dataList = [];







List<String> symbols = [
  "Rectangle",
  'Circle',
  'Start Oval',
  'End Oval',
  'Diamond',
  'Display',
  'Document',
  'Multiple Document',
  'Parallelogram',
  "Hexagon",
  "Pentagon",
  "Storage"
];

List<String> symbolsImages = [
  (AppImages.rectangle),
  (AppImages.connector),
  (AppImages.startEnd),
  (AppImages.startEnd),
  (AppImages.decision),
  (AppImages.display),
  (AppImages.document),
  (AppImages.multipleDocument),
  (AppImages.parallelogram),
  (AppImages.hexagon),
  (AppImages.hexagon),
  (AppImages.storage),
];



List<ElementShapeEntity> elementShapesList = [

  ///RECTANGLE ELEMENT
  ElementShapeEntity(
    flowElement: FlowElement(
        position: const Offset(50, 25),
        size: const Size(300, 50),
        text: AppConst.rectangleElement,
        kind: ElementKind.rectangle,
        handlers: [
          Handler.bottomCenter,
          Handler.topCenter,
        ]),
    flowElementImage: AppImages.rectangle,
    flowElementName: AppConst.rectangleElement,
    flowElementDescription: '',
    typeMode:["textEditor","isNumeric","isDateField","isDateTimeField", "duration"],
    selectedmode:"",
    extraOptions:[],

  ),


  ///CIRCLE ELEMENT --------> CONNECTOR ELEMENT
  ElementShapeEntity(
      flowElement: FlowElement(
        position: const Offset(25, 25),
        size: const Size.fromRadius(40),
        // Set the size for the circle
        text: AppConst.connectorElement,
        kind: ElementKind.circle,
        handlers: [
          Handler.topCenter,
          Handler.bottomCenter,
        ],
      ),
      flowElementImage: AppImages.connector,
      flowElementName: AppConst.connectorElement,
      flowElementDescription: '',
      typeMode: [],
      selectedmode: '',
      extraOptions: []
  ),


  ///START ELEMENT
  ElementShapeEntity(
      flowElement: FlowElement(
          position: const Offset(100, 25),
          size: const Size(200, 50),
          text: AppConst.startElement,
          kind: ElementKind.ovalStart,
          handlers: [
            Handler.bottomCenter,
          ]),
      flowElementImage: AppImages.startEnd,
      flowElementName: AppConst.startElement,
      flowElementDescription: '',
      typeMode: [], selectedmode: '', extraOptions: []
  ),


  ///END ELEMENT
  ElementShapeEntity(
      flowElement: FlowElement(
          position: const Offset(100, 25),
          size: const Size(200, 50),
          text: AppConst.endElement,
          kind: ElementKind.ovalEnd,
          handlers: [
            Handler.topCenter,
          ]),
      flowElementImage: AppImages.startEnd,
      flowElementName: AppConst.endElement,
      flowElementDescription: '',
      typeMode: [], selectedmode: '', extraOptions: []
  ),


  ///DECISION ELEMENT
  ElementShapeEntity(
      flowElement: FlowElement(
          position: const Offset(40, 40),
          size: const Size(200, 60),
          text: AppConst.decisionElement,
          kind: ElementKind.diamond,
          handlers: [
            Handler.bottomCenter,
            Handler.topCenter,
            Handler.leftCenter,
            Handler.rightCenter,
          ]),
      flowElementImage: AppImages.decision,
      flowElementName: AppConst.decisionElement,
      flowElementDescription: '',
      typeMode: ["isOptions","isMultiOptions"], selectedmode: '', extraOptions: []
  ),


  ///DISPLAY ELEMENT
  ElementShapeEntity(
      flowElement: FlowElement(
          position: const Offset(50, 25),
          size: const Size(100, 50),
          text: AppConst.displayElement,
          kind: ElementKind.displaySymbol,
          handlers: [
            Handler.bottomCenter,
            Handler.topCenter,
            // Handler.leftCenter,
            // Handler.rightCenter,
          ]),
      flowElementImage: AppImages.display,
      flowElementName: AppConst.displayElement,
      flowElementDescription: '',
      typeMode: [], selectedmode: '', extraOptions: []
  ),


  ///DOCUMENT ELEMENT
  ElementShapeEntity(
      flowElement: FlowElement(
          position: const Offset(50, 25),
          size: const Size(170, 150),
          text: AppConst.documentElement,
          kind: ElementKind.document,
          handlers: [
            Handler.bottomCenterDoc,
            Handler.topCenter,
            // Handler.leftCenter,
            // Handler.rightCenter,
          ]),
      flowElementImage: AppImages.document,
      flowElementName: AppConst.documentElement,
      flowElementDescription: '',
      typeMode: [], selectedmode: '', extraOptions: []
  ),

  ///MULTIPLE DOCUMENTS ELEMENT
  ElementShapeEntity(
      flowElement: FlowElement(
          position: const Offset(50, 25),
          size: const Size(180, 150),
          text: AppConst.multipleDocumentElement,
          kind: ElementKind.multipleDisplaySymbol,
          handlers: [
            Handler.bottomCenterMultiDoc,
            Handler.topCenterMultiDoc,
            // Handler.leftCenter,
            // Handler.rightCenter,
          ]),
      flowElementImage: AppImages.multipleDocument,
      flowElementName: AppConst.multipleDocumentElement,
      flowElementDescription: '',
      typeMode: ['isDateField'], selectedmode: '', extraOptions: []
  ),


  ///PARALLELOGRAM ELEMENT
  ElementShapeEntity(
      flowElement: FlowElement(
          position: const Offset(50, 25),
          size: const Size(300, 50),
          text: AppConst.parallelogramElement,
          kind: ElementKind.parallelogram,
          handlers: [
            Handler.bottomCenter,
            Handler.topCenter,
            Handler.rightCenterParallelogram,
          ]),
      flowElementImage: AppImages.parallelogram,
      flowElementName: AppConst.parallelogramElement,
      flowElementDescription: '',
      typeMode: ["isOptions", "isMultiOptions"], selectedmode: '', extraOptions: []
  ),


  ///HEXAGON ELEMENT
  ElementShapeEntity(
      flowElement: FlowElement(
        position: const Offset(50, 50),
        size: const Size(100, 100),
        text: AppConst.hexagonElement,
        kind: ElementKind.hexagon,
        handlers: [
          Handler.bottomCenter,
          Handler.topCenter,
          Handler.topRightHexa,
          Handler.bottomLeftHexa,
          Handler.bottomRightHexa,
          Handler.topLeftHexa
        ],
      ),
      flowElementImage: AppImages.hexagon,
      flowElementName: AppConst.hexagonElement,
      flowElementDescription: '',
      typeMode: ["isOptions","isMultiOptions"], selectedmode: '', extraOptions: []
  ),


  ///PENTAGON ELEMENT
  ElementShapeEntity(
      flowElement: FlowElement(
          position: const Offset(10, 10),
          size: const Size(100, 100),
          text: AppConst.pentagonElement,
          kind: ElementKind.pentagon,
          handlers: [
            Handler.topCenter,
            Handler.topRightPenta,
            Handler.topLeftPenta,
            Handler.bottomRightPenta,
            Handler.bottomLeftPenta,
          ]),
      flowElementImage: AppImages.hexagon,
      flowElementName: AppConst.pentagonElement,
      flowElementDescription: '',
    typeMode:["isOptions","isMultiOptions"],
    selectedmode:"",
    extraOptions:[],
  ),


  ///STORAGE ELEMENT
  ElementShapeEntity(
      flowElement: FlowElement(
          position: const Offset(50, 25),
          size: const Size(100, 150),
          text: AppConst.storageElement,
          kind: ElementKind.storage,
          handlers: [
            Handler.bottomCenter,
            Handler.leftCenter,
            Handler.rightCenter,
          ]),
      flowElementImage: AppImages.storage,
      flowElementName: AppConst.storageElement,
      flowElementDescription: '',
      typeMode: [], selectedmode: '', extraOptions: []
  ),

  ///IMMUNIZATION REPRESENTATION ELEMENT
  ElementShapeEntity(
      flowElement: FlowElement(
          position: const Offset(50, 25),
          size: const Size(200, 40),
          text: AppConst.immunizationRepresentation,
          kind: ElementKind.immunizationRepresent,
          handlers: [
            // Handler.topCenter,
            // Handler.bottomCenter,
          ]),
      flowElementImage: AppImages.immunizationRectangle,
      flowElementName: AppConst.immunizationRepresentation,
    flowElementDescription: '',
    typeMode:["isDateField",],
    selectedmode:"",
    extraOptions:[],
  ),

];
