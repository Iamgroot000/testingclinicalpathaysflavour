import 'dart:convert';

import 'package:testing_clinicalpathways/domain/entities/ageGroupVariables.dart';
import 'package:testing_clinicalpathways/domain/entities/clinicalPathwayCategoriesEntity.dart';
import 'package:testing_clinicalpathways/domain/entities/clinicalPathwayFlavourCategories.dart';
import 'package:testing_clinicalpathways/domain/entities/flowChartEntities/getFlowChartEntitiesConnector.dart';
import 'package:testing_clinicalpathways/domain/entities/genderGroupsStandard.dart';
import 'package:testing_clinicalpathways/presentation/views/presentationLayerConnectors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

DashboardEntity homeEntityFromJson(String str) =>
    DashboardEntity.fromJson(json.decode(str));

String homeEntityToJson(DashboardEntity data) => json.encode(data.toJson());

List<DashboardEntity> homeEntityListFromJson(str) => List<DashboardEntity>.from(
    (str).map((x) => DashboardEntity.fromJson(x.data())));

String homeEntityListToJson(List<DashboardEntity> users) {
  final List<Map<String, dynamic>> jsonData =
      users.map((user) => user.toJson()).toList();
  return json.encode(jsonData);
}

class DashboardEntity {
  DocumentReference<Object?>? reference;
  late final String flowchartId;
  late final String flowchartName;
  List<FlowElement>? elements;
  String? startElementId;
  String? endElementId;
  int? priority;
  bool? isReferred;
  ClinicalPathwayCategoriesItem? clinicalPathwayCategoriesItem;
  ClinicalPathwayFlavourCategoriesItem? clinicalPathwayFlavourCategoriesItem;
  GenderGroupStandardItem? genderGroupStandardItem;
  List<AgeGroupItem>? ageGroupItemList;
  //Gaurav Edit
  List<FlavourItem>? flavourItemList;


  // required FlavourItem flavourItemList
  DashboardEntity({
    required this.flowchartId,
    required this.flowchartName,
    this.elements,
    this.startElementId,
    this.endElementId,
    this.priority,
    this.isReferred,
    this.clinicalPathwayCategoriesItem,
    this.clinicalPathwayFlavourCategoriesItem,
    this.genderGroupStandardItem,
    this.ageGroupItemList,
    //Gaurav edit
    this.flavourItemList
  });

  factory DashboardEntity.fromJson(Map<String, dynamic> json) {
     DashboardEntity entity= DashboardEntity(
          flowchartId: json['flowchartId'],
          flowchartName: json['flowchartName'] ?? '',
          elements: json['elements'] != null
              ? List<FlowElement>.from((json['elements'] as List<dynamic>)
              .map<FlowElement>(
                  (x) => FlowElement.fromMap(x as Map<String, dynamic>)))
              : [],
          startElementId: json['startElementId'],
          endElementId: json['endElementId'],
          priority: json['priority'],
          isReferred: json['isReferred'],
          clinicalPathwayCategoriesItem:
          json['clinicalPathwayCategoriesItem'] != null
              ? ClinicalPathwayCategoriesItem.fromJson(
              json['clinicalPathwayCategoriesItem'])
              : ClinicalPathwayCategoriesItem(categoryList: []),

         clinicalPathwayFlavourCategoriesItem:
         json['clinicalPathwayFlavourCategoriesItem'] != null
             ? ClinicalPathwayFlavourCategoriesItem.fromJson(
             json['clinicalPathwayFlavourCategoriesItem'])
             : ClinicalPathwayFlavourCategoriesItem(flavourList: []),


          genderGroupStandardItem: json['genderGroupStandardItem'] != null
              ? GenderGroupStandardItem.fromJson(
              json['genderGroupStandardItem'])
              : GenderGroupStandardItem(genderGroupList: []),
          ageGroupItemList: json['ageGroupItemList'] != null
              ? ageGroupItemListFromMap(json['ageGroupItemList'])
              : []);

     // debugPrint("dashboard fromjson ${entity.toJson()}");
     return entity;
}

  Map<String, dynamic> toJson() => {
        'flowchartId': flowchartId,
        'flowchartName': flowchartName,
        'elements': elements,
        'startElementId': startElementId,
        'endElementId': endElementId,
        'priority': priority,
        'isReferred': isReferred,
        // 'clinicalPathwayCategoriesItem': clinicalPathwayCategoriesItem,
        // 'genderGroupStandardItem': genderGroupStandardItem,
        // 'ageGroupItemList': ageGroupItemList
        'clinicalPathwayCategoriesItem': clinicalPathwayCategoriesItem?.toJson(),
        'clinicalPathwayFlavourCategoriesItem': clinicalPathwayFlavourCategoriesItem?.toJson(),
        'genderGroupStandardItem': genderGroupStandardItem?.toJson(),
        'ageGroupItemList': ageGroupItemList?.map((e) => e.toJson()).toList(),
      };

  DashboardEntity.fromMap(map, {this.reference}) {
    flowchartId = map['flowchartId'];
    flowchartName = map['flowchartName'];
    elements = map['elements'] ?? [];
    startElementId = map['startElementId'];
    endElementId = map['endElementId'];
    priority = map['priority'];
    isReferred = map['isReferred'];
  }

  Map<String, dynamic> toMap() {
    return {
      'flowchartId': flowchartId,
      'flowchartName': flowchartName,
      'elements': elements,
      'startElementId': startElementId,
      'endElementId': endElementId,
      'priority': priority,
      'isReferred': isReferred,
    };
  }

  DashboardEntity.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
