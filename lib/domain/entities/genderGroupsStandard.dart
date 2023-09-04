import 'dart:convert';

GenderGroupStandardItem genderGroupStandardItemFromJson(String str) =>
    GenderGroupStandardItem.fromJson(json.decode(str));

String clinicalPathwayCategoriesItemToJson(GenderGroupStandardItem data) =>
    json.encode(data.toJson());


List<GenderGroupStandardItem> genderGroupItemListFromJson(str) =>
    List<GenderGroupStandardItem>.from((str).map((x) => GenderGroupStandardItem.fromJson(x.data())));


class GenderGroupStandardItem {
  List<String> genderGroupList;

  GenderGroupStandardItem({
    required this.genderGroupList,
  });

  factory GenderGroupStandardItem.fromJson(Map<String, dynamic> json) => GenderGroupStandardItem(
    genderGroupList: List<String>.from(json["genderGroupList"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "genderGroupList": List<dynamic>.from(genderGroupList.map((x) => x)),
  };
}