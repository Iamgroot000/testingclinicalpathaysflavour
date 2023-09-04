import 'dart:convert';

import 'package:testing_clinicalpathways/presentation/views/presentationLayerConnectors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

AgeGroupItem ageGroupsFromJson(String str) =>
    AgeGroupItem.fromJson(json.decode(str));

String ageGroupsToJson(AgeGroupItem data) => json.encode(data.toJson());

List<AgeGroupItem> ageGroupItemListFromJson(str) =>
    List<AgeGroupItem>.from((str).map((x) => AgeGroupItem.fromJson(x.data())));

List<AgeGroupItem> ageGroupItemListFromMap(List<dynamic> ageGroupList) {
  return ageGroupList
      .map<AgeGroupItem>((map) => AgeGroupItem.fromJson(map))
      .toList();
}

String ageGroupItemListToJson(List<AgeGroupItem> ageGroupItemList) {
  final List<Map<String, dynamic>> jsonData =
  ageGroupItemList.map((item) => item.toJson()).toList();
  final Map<String, dynamic> jsonMap = {"ageGroupList": jsonData};
  return json.encode(jsonMap);
}

class AgeGroupItem {
  DocumentReference<Object?>? reference;
  String? groupName;
  double? start;
  double? end;
  int? priority;
  String? startRange;
  String? endRange;
  bool? isMandatory;

  AgeGroupItem({
    required this.groupName,
    required this.start,
    required this.end,
    required this.priority,
    this.startRange ="",
    this.endRange ="",
    this.isMandatory =false,
  });


  factory AgeGroupItem.fromJson(Map<String, dynamic> json) {
    AgeGroupItem item =AgeGroupItem(
      groupName: json["groupName"],
      start: double.parse(json["start"].toString()),
      end: double.parse(json["end"].toString()),
      priority: json["priority"],
      startRange: json["startRange"].toString().compareTo('null') ==0 ? '' : json["startRange"].toString(),
      endRange: json["endRange"].toString().compareTo('null') ==0 ? '' : json["endRange"].toString(),
      isMandatory:json["isMandatory"]!=null ? json["isMandatory"].toString().compareTo('true') ==0 : false,
    );
    return item;
  }




  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() => {
    "groupName": groupName,
    "start": start,
    "end": end,
    "priority": priority,
    'startRange':startRange?.compareTo("null")==0 ? '' : startRange,
    'endRange':endRange?.compareTo("null")==0 ? '' : endRange,
    'isMandatory': isMandatory,
  };

  AgeGroupItem.fromMap(map, {this.reference}) {
    groupName = map['groupName'];
    start = map['start'].toDouble();
    end = map['end'].toDouble();
    priority = map['priority'];
  }

  Map<String, dynamic> toMap() {
    return {
      'groupName': groupName,
      'start': start,
      'end': end,
      'priority': priority,
    };
  }

  AgeGroupItem.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
