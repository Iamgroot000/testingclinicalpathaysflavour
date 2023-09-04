import 'dart:convert';

import 'package:testing_clinicalpathways/presentation/views/presentationLayerConnectors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ClinicalPathwayFlavourCategories.dart';
import 'genderGroupsStandard.dart';


FlavourItem ageGroupsFromJson(String str) =>
    FlavourItem.fromJson(json.decode(str));

String ageGroupsToJson(FlavourItem data) => json.encode(data.toJson());

List<FlavourItem> FlavourItemListFromJson(str) =>
    List<FlavourItem>.from((str).map((x) => FlavourItem.fromJson(x.data())));

List<FlavourItem> FlavourItemListFromMap(List<dynamic> ageGroupList) {
  return ageGroupList
      .map<FlavourItem>((map) => FlavourItem.fromJson(map))
      .toList();}


class FlavourItem {
  String? appFlavour;
  bool? isMandatory;
  List<String>? genders;
  List<AgeGroupItem>? ageGroups;

  FlavourItem( {this.appFlavour, this.isMandatory, this.genders,
    this.ageGroups});

  factory FlavourItem.fromJson(Map<String, dynamic> json) {
    debugPrint("test: flavourItem.fromJson : ${json}");
    FlavourItem flavourItem = FlavourItem(
      appFlavour: json['appFlavour'] as String?,
      isMandatory: json['isMandatory'] as bool?,
      genders: (json['genders'] as List<dynamic>?)?.cast<String>(),
      ageGroups: (json['ageGroups'] as List<dynamic>?)
          ?.map((e) => AgeGroupItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    debugPrint("test: flavourItem.fromJson end : ${flavourItem.toJson()}");
    return flavourItem;
  }

  Map<String, dynamic> toJson() {
    return {
      'appFlavour': appFlavour,
      'isMandatory': isMandatory,
      'genders': genders,
      'ageGroups': ageGroups?.map((item) => item.toJson()).toList(),
    };
  }
//
}
