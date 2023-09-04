import 'package:testing_clinicalpathways/domain/entities/clinicalPathwayCategoriesEntity.dart';
import 'package:testing_clinicalpathways/domain/entities/genderGroupsStandard.dart';
import 'package:testing_clinicalpathways/domain/entities/ageGroupVariables.dart';
import 'package:testing_clinicalpathways/domain/entities/homeEntity.dart';


abstract class HomeRepositoryInterface {

  Future<List<DashboardEntity>> loadHomeEntities();

  Future<int> checkFlowchartNameAvailability(String flowchartName);

  Future<List<AgeGroupItem>> generalVariablesFetchAgeGroups();

  Future<ClinicalPathwayCategoriesItem> generalVariablesClinicalPathwayCategories();

  Future<ClinicalPathwayFlavourCategoriesItem> generalVariablesClinicalPathwayFlavourCategories();

  Future<GenderGroupStandardItem> generalVariablesGenderGroupStandard();

  Future<bool> addDashboard(DashboardEntity homeEntity);

  Future<bool> updateCategoriesInFirebase(ClinicalPathwayCategoriesItem clinicalPathwayCategoriesItem);

}
