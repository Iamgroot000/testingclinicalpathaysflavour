import 'dart:convert';

ClinicalPathwayCategoriesItem clinicalPathwayCategoriesItemFromJson(String str) =>
    ClinicalPathwayCategoriesItem.fromJson(json.decode(str));

String clinicalPathwayCategoriesItemToJson(ClinicalPathwayCategoriesItem data) =>
    json.encode(data.toJson());


List<ClinicalPathwayCategoriesItem> ageGroupItemListFromJson(str) =>
    List<ClinicalPathwayCategoriesItem>.from((str).map((x) => ClinicalPathwayCategoriesItem.fromJson(x.data())));


class ClinicalPathwayCategoriesItem {
  List<String> categoryList;

  ClinicalPathwayCategoriesItem({
    required this.categoryList,
  });

  factory ClinicalPathwayCategoriesItem.fromJson(Map<String, dynamic> json) => ClinicalPathwayCategoriesItem(
    categoryList: List<String>.from(json["categoryList"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "categoryList": List<dynamic>.from(categoryList.map((x) => x)),
  };
}





// import 'dart:convert';
//
//
// ClinicalPathwayFlavourCategoriesItem clinicalPathwayFlavourCategoriesItemFromJson(String str) =>
//     ClinicalPathwayFlavourCategoriesItem.fromJson(json.decode(str));
//
// String clinicalPathwayFlavourCategoriesItemToJson(ClinicalPathwayFlavourCategoriesItem data) =>
//     json.encode(data.toJson());
//
//
// List<ClinicalPathwayFlavourCategoriesItem> ageGroupItemListFromJson(str) =>
//     List<ClinicalPathwayFlavourCategoriesItem>.from((str).map((x) => ClinicalPathwayFlavourCategoriesItem.fromJson(x.data())));
//
//
// class ClinicalPathwayFlavourCategoriesItem {
//   List<String> flavourList;
//
//   ClinicalPathwayFlavourCategoriesItem({
//     required this.flavourList,
//   });
//
//   factory ClinicalPathwayFlavourCategoriesItem.fromJson(Map<String, dynamic> json) => ClinicalPathwayFlavourCategoriesItem(
//     flavourList: List<String>.from(json["flavourList"].map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "flavourList": List<dynamic>.from(flavourList.map((x) => x)),
//   };
// }
//
//
//
//
//




ClinicalPathwayFlavourCategoriesItem clinicalPathwayFlavourCategoriesItemFromJson(String str) =>
    ClinicalPathwayFlavourCategoriesItem.fromJson(json.decode(str));

String clinicalPathwayFlavourCategoriesItemToJson(ClinicalPathwayFlavourCategoriesItem data) =>
    json.encode(data.toJson());


// List<ClinicalPathwayFlavourCategoriesItem> ageGroupItemListFlavourFromJson(str) =>
//     List<ClinicalPathwayFlavourCategoriesItem>.from((str).map((x) => ClinicalPathwayFlavourCategoriesItem.fromJson(x.data())));


class ClinicalPathwayFlavourCategoriesItem {
  List<String> flavourList;

  ClinicalPathwayFlavourCategoriesItem({
    required this.flavourList,
  });

  factory ClinicalPathwayFlavourCategoriesItem.fromJson(Map<String, dynamic> json) => ClinicalPathwayFlavourCategoriesItem(
    flavourList: List<String>.from(json["flavourList"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "flavourList": List<dynamic>.from(flavourList.map((x) => x)),
  };
}