import 'dart:collection';
import 'dart:convert';

import 'package:testing_clinicalpathways/domain/entities/ageGroupVariables.dart';

import 'package:testing_clinicalpathways/domain/entities/flowChartEntities/connectionParameters.dart';
import 'package:testing_clinicalpathways/domain/entities/flowChartEntities/getFlowChartEntitiesConnector.dart';
import 'package:testing_clinicalpathways/presentation/views/presentationLayerConnectors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/clinicalPathwayFlavourCategories.dart';

enum ElementKind {
  rectangle,
  circle,
  ovalStart,
  ovalEnd,
  diamond,
  displaySymbol,
  document,
  multipleDisplaySymbol,
  parallelogram,
  hexagon,
  pentagon,
  storage,
  immunizationRepresent
}

enum Handler {
  ///BASIC HANDLERS
  topCenter,
  bottomCenter,
  rightCenter,
  leftCenter,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,

  ///HEXAGON
  topRightHexa,
  topLeftHexa,
  bottomRightHexa,
  bottomLeftHexa,

  ///PENTAGON
  topRightPenta,
  topLeftPenta,
  bottomRightPenta,
  bottomLeftPenta,
  bottomCenterDoc,

  /// MULTIPLE DOCUMENT
  bottomCenterMultiDoc,
  topCenterMultiDoc, rightCenterParallelogram,
}

/// Class to store [ElementWidget]s and notify its changes
class FlowElement extends GetxController {
  /// Unique id set when adding a [FlowElement] with [Dashboard.addElement()]
  String id;

  /// The position of the [FlowElement]
  Offset position;

  /// The size of the [FlowElement]
  Size size;

  /// Element text
  String text;

  /// Text color
  Color textColor;

  /// Text size
  double textSize;

  /// Makes text bold if true
  bool textIsBold;

  /// Element shape
  ElementKind kind;

  /// Connection handlers
  List<Handler> handlers;

  /// The size of element handlers
  double handlerSize;

  /// Background color of the element
  Color backgroundColor;

  /// Border color of the element
  Color borderColor;

  /// Border thickness of the element
  double borderThickness;

  /// Shadow elevation
  double elevation;

  /// List of connections of this element
  List<ConnectionParams> next;

  /// Element text
  bool isResizing;

  /// The selected group for this element
  String selectedGroup;

  /// The selected group index for this element
  int groupIndex;

  /// The selected group for this element
  String navigationId;

  /// The selected group index for this element
  int flowIndex;

  /// THE SELECTED AGE GROUP FOR THIS ELEMENT
  List<AgeGroupItem> ageGroupQuestion;

  /// THE SELECTED GENDER GROUP FOR THIS ELEMENT
  List<String> genderGroup;

  /// THE SELECTED AGE GROUP INDEX FOR THIS ELEMENT
  int ageGroupIndex;

  /// The selected Mode for this element
  String selectedMode;

  /// The selected length for this element's answer
  List<Map<String,dynamic>> range;

  /// FLAVOUR OF PRE CONSULT APPLICATION
  List<FlavourItem> flavours;


  /// STRING FOR MANDATORY QUESTIONS IN FLOWCHART
  String isMandatory;

  /// The selected length for this element's answer
  String options;


  /// The selected TODO
  String startId;

  /// The selected TODO
  String endId;

  /// FLOW ID FOR WHICH FLOW ID THE QUESTION IS RELATED
  String flowId;

  /// BOOL VALUE FOR IS EMERGENCY
  bool isEmergency;

  /// BOOL VALUE FOR IS FOLLOWUP
  bool isFollowUp;

  /// BOOL VALUE FOR IS PREGNANCY
  bool isPregnancy;

  FlowElement({
    this.position = Offset.infinite,
    this.size = Size.infinite,
    this.text = '',
    this.selectedGroup = '',
    this.groupIndex = 0,
    this.selectedMode = '',

    /// THIS IS THE FLOW CHART ID FOR THE FLOW CHART QUESTION
    this.navigationId = "",
    this.flowIndex = 0,

    /// THIS IS THE AGE GROUP FOR THE FLOW CHART QUESTION
    this.ageGroupQuestion = const [],
    this.genderGroup = const [],
    this.ageGroupIndex = 0,
    this.isMandatory = "",
    this.options = "",
    this.range = const [{'min': 0.0, 'max':0.0,'length':0,'pattern':''}],
    this.flavours = const [],
    this.textColor = Colors.black,
    this.textSize = 14,
    this.textIsBold = false,
    this.kind = ElementKind.rectangle,
    this.handlers = const [
      Handler.topCenter,
      Handler.bottomCenter,
      Handler.rightCenter,
      Handler.leftCenter,
      Handler.topLeft,
      Handler.topRight,
      Handler.bottomLeft,
      Handler.bottomRight,
    ],
    this.handlerSize = 15.0,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.blue,
    this.borderThickness = 3,
    this.elevation = 4,
    next,
    this.id = '',
    this.flowId='',

    this.startId = '',
    this.endId = '',
    this.isEmergency = false,
    this.isFollowUp = false,
    this.isPregnancy = false,

  })  : next = next ?? [],
        isResizing = false;

  @override
  String toString() {
    return 'kind: $kind  text: $text';
  }

  /// When setting to true, a handler will disply at the element bottom right
  /// to let the user to resize it. When finish it will disappear.
  setIsResizing(bool resizing) {
    isResizing = resizing;
    update();
  }

  /// Used internally to set an unique Uuid to this element
  setId(String id) {
    this.id = id;
  }

  /// Set text
  setText(String text) {
    this.text = text;
    update();
  }

  /// SET GROUP NAME
  setGroupName(String groupName) {
    this.selectedGroup = groupName;
    update();
  }

  setGroupIndex(int index) {
    this.groupIndex = index;
    update();
  }

  /// SET FLOW CHART ID
  setFlowChartID(String flowChartId) {
    navigationId = flowChartId;
    update();
  }

  setFlowChartIDIndex(int index) {
    flowIndex = index;
    update();
  }

  /// SET AGE GROUP FOR EACH QUESTION
  setAgeGroup(List<AgeGroupItem> ageGroupQ) {
    ageGroupQuestion = ageGroupQ;
    update();
  }

  ///
  setFlavour(List<FlavourItem> flavourCollection) {
    flavours = flavourCollection;
    update();
  }

  /// SET GENDER GROUP FOR EACH QUESTION
  setGenderGroup(List<String> genderGroupElement) {
    genderGroup = genderGroupElement;
    update();
  }

  setAgeGroupIndex(int index) {
    ageGroupIndex = index;
    update();
  }

  setOptions(String options) {
    this.options = options;
    update();
  }

  setModeName(String modeName) {
    this.selectedMode = modeName;
    update();
  }

  selectLength(List<Map<String,dynamic>> range) {
    this.range = range;
    update();
  }

  /// Set text color
  setTextColor(Color color) {
    textColor = color;
    update();
  }

  /// Set text size
  setTextSize(double size) {
    textSize = size;
    update();
  }

  /// Set text bold
  setTextIsBold(bool isBold) {
    textIsBold = isBold;
    update();
  }

  /// STRING MANDATORY

  setMandatoryField(String isMandatory) {
    this.isMandatory = isMandatory;
    //notifyListeners();
    update();
  }

  /// Set background color
  setBackgroundColor(Color color) {
    backgroundColor = color;
    //notifyListeners();
    update();
  }

  /// Set border color
  setBorderColor(Color color) {
    borderColor = color;
    //notifyListeners();
    update();
  }

  /// Set border thickness
  setBorderThickness(double thickness) {
    borderThickness = thickness;
    //notifyListeners();
    update();
  }

  /// Set elevation
  setElevation(double elevation) {
    this.elevation = elevation;
    //notifyListeners();
    update();
  }

  /// Change element position in the dashboard
  changePosition(Offset newPosition) {
    position = newPosition;
    //notifyListeners();
    update();
  }

  /// START ID TO BE SET IN THE ELEMENT LEVEL
  setStartId(String start){
    startId = start;
  }

  /// END ID TO BE SET IN THE ELEMENT LEVEL
  setEndId(String end){
    endId = end;
  }

  /// Change element size
  changeSize(Size newSize) {
    if (newSize.width < 40) newSize = Size(40, newSize.height);
    if (newSize.height < 40) newSize = Size(newSize.width, 40);
    size = newSize;
    //notifyListeners();
    update();
  }

  setFlowId(String flowId) {
    this.flowId = flowId;
    update();
  }

  setIsEmergency(bool emergency){
    this.isEmergency = emergency;
  }

  setIsFollowUp(bool followUp){
    this.isFollowUp = followUp;
  }

  setIsPregnancy(bool pregnancy){
    this.isPregnancy = pregnancy;
  }

  @override
  bool operator ==(covariant FlowElement other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode {
    return position.hashCode ^
    size.hashCode ^
    text.hashCode ^
    selectedGroup.hashCode ^
    groupIndex.hashCode ^
    options.hashCode ^
    selectedMode.hashCode ^
    range.hashCode ^
    textColor.hashCode ^
    textSize.hashCode ^
    textIsBold.hashCode ^
    id.hashCode ^
    kind.hashCode ^
    handlers.hashCode ^
    handlerSize.hashCode ^
    backgroundColor.hashCode ^
    borderColor.hashCode ^
    borderThickness.hashCode ^
    elevation.hashCode ^
    next.hashCode ^
    isMandatory.hashCode ^
    navigationId.hashCode ^
    genderGroup.hashCode ^
    startId.hashCode^
    endId.hashCode^
    flowId.hashCode^
    isEmergency.hashCode^
    isFollowUp.hashCode^
    isPregnancy.hashCode^
    flavours.hashCode^
    ageGroupQuestion.hashCode;

  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'positionDx': position.dx,
      'positionDy': position.dy,
      'size.width': size.width,
      'size.height': size.height,
      'text': text,
      ///CUSTOM FIELDS - START
      'selectedGroup': selectedGroup,
      'options': options,
      'groupIndex': groupIndex,
      'selectedMode': selectedMode,
      'range' :range.map((item) => {
        'min': item['min'],
        'max': item['max'],
        'length': item['length'],
        'pattern': item['pattern'],
      }).toList(),
      'isMandatory': isMandatory,
      'navigationId': navigationId,
      'ageGroup': ageGroupQuestion.toList(),
      'genderGroup': genderGroup.toList(),
      'flavours': flavours.toList(),

      ///CUSTOM FIELDS - END
      'textColor': textColor.value,
      'textSize': textSize,
      'textIsBold': textIsBold,
      'id': id,
      'kind': kind.index,
      'handlers': handlers.map((x) => x.index).toList(),
      'handlerSize': handlerSize,
      'backgroundColor': backgroundColor.value,
      'borderColor': borderColor.value,
      'borderThickness': borderThickness,
      'elevation': elevation,
      'next': next.map((x) => x.toMap()).toList(),
      'startId' : startId,
      'endId' : endId,
      'flowId': flowId,
      "isEmergency" : isEmergency,
      "isFollowUp" : isFollowUp,
      "isPregnancy" : isPregnancy,
    };
  }

  factory FlowElement.fromMap(Map<String, dynamic> map) {
    FlowElement e = FlowElement(
      position: Offset(
        map['positionDx'] as double,
        map['positionDy'] as double,
      ),
      size: Size(map['size.width'] as double, map['size.height'] as double),
      text: map['text'] as String,
      ///Added extra fields in the plugin
      selectedGroup: map['selectedGroup'] as String,
      genderGroup:(map['genderGroup'] as List).map((e) => e as String).toList(),
      groupIndex: map['groupIndex'] as int,
      selectedMode: map['selectedMode'] as String,
      range: (map['range'] as List<dynamic>).map((item) => {
        'min': item['min'],
        'max': item['max'],
        'length': item['length'],
        'pattern': item['pattern'],
      }).toList(),
      options: map['options'] as String,
      isMandatory: map['isMandatory'] as String,
      navigationId: map['navigationId'] as String,
      ageGroupQuestion: map['ageGroup'] != null
          ? ageGroupItemListFromMap(map['ageGroup'])
          : [],
      flavours: map['flavoursList'] != null ? FlavourItemListFromMap(map['flavours']) : [],
      // flavours: List<FlavourItem>.from(
      //   (map['flavours'] as List<dynamic>).map<dynamic>(
      //         (x) => FlavourItem.fromMap(x as Map<String, dynamic>),
      //   ),
      // ),
      textColor: Color(map['textColor'] as int),
      textSize: map['textSize'] as double,
      textIsBold: map['textIsBold'] as bool,
      kind: ElementKind.values[map['kind'] as int],
      handlers: List<Handler>.from(
        (map['handlers'] as List<dynamic>).map<Handler>(
              (x) => Handler.values[x],
        ),
      ),
      handlerSize: map['handlerSize'] as double,
      backgroundColor: Color(map['backgroundColor'] as int),
      borderColor: Color(map['borderColor'] as int),
      borderThickness: map['borderThickness'] as double,
      elevation: map['elevation'] as double,
      next: List<ConnectionParams>.from(
        (map['next'] as List<dynamic>).map<dynamic>(
              (x) => ConnectionParams.fromMap(x as Map<String, dynamic>),
        ),
      ),
      startId: map['startId'] as String,
      endId: map['endId'] as String,
      flowId: map['flowId'] as String,
      isEmergency : map["isEmergency"] as bool,
      isFollowUp : map["isFollowUp"] as bool,
      isPregnancy : map["isPregnancy"] as bool,
    );
    e.setId(map['id'] as String);
    return e;
  }

  String toJson() => json.encode(toMap());

  factory FlowElement.fromJson(String source) =>
      FlowElement.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toJsontest() {
    return {
      "id": this.id,
      "position": this.position,
      "size": this.size,
      "text": this.text,
      "textColor": this.textColor,
      "textSize": this.textSize,
      "textIsBold": this.textIsBold,
      "kind": this.kind,
      "handlers": jsonEncode(this.handlers),
      "handlerSize": this.handlerSize,
      "backgroundColor": this.backgroundColor,
      "borderColor": this.borderColor,
      "borderThickness": this.borderThickness,
      "elevation": this.elevation,
      "next": jsonEncode(this.next),
      "isResizing": this.isResizing,
      "selectedGroup": this.selectedGroup,
      "groupIndex": this.groupIndex,
      "navigationId": this.navigationId,
      "flowIndex": this.flowIndex,
      "ageGroup": jsonEncode(this.ageGroupQuestion),
      "flavours": jsonEncode(this.flavours),
      "genderGroup": jsonEncode(this.genderGroup),
      "ageGroupIndex": this.ageGroupIndex,
      "selectedMode": this.selectedMode,
      "range": jsonEncode(range),
      "isMandatory": isMandatory,
      "options": this.options,
      'startId': this.startId,
      'endId': this.endId,
      'flowId': this.flowId,
      'isEmergency' : this.isEmergency,
      'isFollowUp' : this.isFollowUp,
      'isPregnancy' : this.isPregnancy,
    };
  }
}
