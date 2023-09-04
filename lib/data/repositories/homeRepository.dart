import 'package:testing_clinicalpathways/domain/entities/ageGroupVariables.dart';
import 'package:testing_clinicalpathways/domain/entities/clinicalPathwayCategoriesEntity.dart';
import 'package:testing_clinicalpathways/domain/entities/genderGroupsStandard.dart';
import 'package:testing_clinicalpathways/domain/entities/homeEntity.dart';
import 'package:testing_clinicalpathways/domain/repositories/homeRepositoryInterface.dart';
import 'package:testing_clinicalpathways/presentation/utils/AppConst.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeRepository implements HomeRepositoryInterface {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<DashboardEntity>> loadHomeEntities() async {
    try {
      var res = await _firestore
          .collection(AppConst.adkCollection)
          .orderBy("priority")
          .get();
      // debugPrint("dashboard entity list  ${res.docs[0]["elements"]}");
      return homeEntityListFromJson(res.docs);
    } catch (error) {
      throw Exception('Failed to load flowcharts: $error');
    }
  }

  @override
  Future<int> checkFlowchartNameAvailability(String flowchartName) async {
    try {
      var res = await _firestore
          .collection(AppConst.adkCollection)
          .where("flowchartName", isEqualTo: flowchartName)
          .get();
      return res.docs.length;
    } catch (error) {
      throw Exception('Failed to fetch flowchart with name: $error');
    }
  }

  @override
  Future<bool> addDashboard(DashboardEntity homeEntity) async {
    try {
      await _firestore
          .collection(AppConst.adkCollection)
          .doc(homeEntity.flowchartId)
          .set(homeEntity.toJson());
      return true;
    } catch (error) {
      throw Exception('Failed to add flowcharts: $error');
    }
  }

  @override
  Future<List<AgeGroupItem>> generalVariablesFetchAgeGroups() async {
    try {
      var res = await _firestore
          .collection(AppConst.generalVariablesCollectionName)
          .doc(AppConst.ageGroupsDocumentName)
          .get();

      //debugPrint("THIS IS RESPONSE 1 ${AgeGroupItem.fromMap(res.data()!['ageGroupList'][0]).groupName}");

      return ageGroupItemListFromMap(res.data()!['ageGroupList']);
    } catch (error) {
      throw Exception('Failed to fetch flowchart with name: $error');
    }
  }

  @override
  Future<ClinicalPathwayCategoriesItem> generalVariablesClinicalPathwayCategories() async {
    try {
      var res = await _firestore
          .collection(AppConst.generalVariablesCollectionName)
          .doc(AppConst.clinicalPathwayCategories)
          .get();
      // debugPrint("THIS IS RESPONSE 1 ${AgeGroupItem.fromMap(res.data()!['ageGroupList'][0]).groupName}");4
//      debugPrint("THis is response of json : ${ClinicalPathwayCategoriesItem.fromJson(res.data()!).categoryList}");

      return ClinicalPathwayCategoriesItem.fromJson(res.data()!);
    } catch (error) {
      throw Exception('Failed to fetch flowchart with name: $error');
    }
  }


  @override
  Future<ClinicalPathwayFlavourCategoriesItem> generalVariablesClinicalPathwayFlavourCategories() async {
    try {
      var res = await _firestore
          .collection(AppConst.generalVariablesCollectionName)
          .doc(AppConst.flavours)
          .get();

      return ClinicalPathwayFlavourCategoriesItem.fromJson(res.data()!);
    } catch (error) {
      throw Exception('Failed to fetch flowchart with name: $error');
    }
  }

  @override
  Future<GenderGroupStandardItem> generalVariablesGenderGroupStandard() async {
    try {
      var res = await _firestore
          .collection(AppConst.generalVariablesCollectionName)
          .doc(AppConst.genderGroupStandard)
          .get();
      // debugPrint("THIS IS RESPONSE 1 ${AgeGroupItem.fromMap(res.data()!['ageGroupList'][0]).groupName}");4
      // debugPrint("THis is response of json : ${GenderGroupStandardItem.fromJson(res.data()!).genderGroupList}");
      return GenderGroupStandardItem.fromJson(res.data()!);
    } catch (error) {
      throw Exception('Failed to fetch flowchart with name: $error');
    }
  }

  Future<bool> updateCategoriesInFirebase(
      ClinicalPathwayCategoriesItem clinicalPathwayCategoriesList) async {
    try {
      // Get a reference to the Firebase collection
      CollectionReference generalVariablesReference =
          _firestore.collection(AppConst.generalVariablesCollectionName);

      // Get the document snapshot
      DocumentSnapshot snapshot = await generalVariablesReference
          .doc(AppConst.clinicalPathwayCategories)
          .get();

      if (snapshot.exists) {
        // Get the current data from the snapshot
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

        // Update the category list
        List<String> updatedCategoryList =
            clinicalPathwayCategoriesList.categoryList;
        data['categoryList'] = updatedCategoryList;

        // Update the document in Firebase
        await generalVariablesReference
            .doc(AppConst.clinicalPathwayCategories)
            .update(data);

        debugPrint('Categories updated in Firebase!');
        return true;
      } else {
        debugPrint('Document does not exist.');
        return false;
      }
    } catch (error) {
      debugPrint('Error updating categories in Firebase: $error');
      return false;
    }
  }



  // @override
  // Future<void> updateClinicalPathwayCategories(ClinicalPathwayCategoriesItem item) async {
  //   try {
  //     await _firestore
  //         .collection(AppConst.generalVariablesCollectionName)
  //         .doc(AppConst.clinicalPathwayCategories)
  //         .set(item.toJson(), SetOptions(merge: true));
  //   } catch (error) {
  //     throw Exception('Failed to update clinical pathway categories: $error');
  //   }
  // }
}
