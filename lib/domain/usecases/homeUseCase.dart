
import 'package:testing_clinicalpathways/domain/entities/clinicalPathwayCategoriesEntity.dart';
import 'package:testing_clinicalpathways/domain/entities/genderGroupsStandard.dart';
import 'package:testing_clinicalpathways/domain/entities/ageGroupVariables.dart';
import 'package:testing_clinicalpathways/domain/entities/homeEntity.dart';
import 'package:testing_clinicalpathways/domain/repositories/homeRepositoryInterface.dart';

class HomeUseCase {
  final HomeRepositoryInterface homeRepositoryInterface;

  HomeUseCase(this.homeRepositoryInterface);

  Future<List<DashboardEntity>> load() async {
    return await homeRepositoryInterface.loadHomeEntities();
  }

  Future<int> executeCheckAvailability({String? flowchartName}) async {
    return await homeRepositoryInterface.checkFlowchartNameAvailability(flowchartName!);
  }

  Future<bool> executeAddDashboard(DashboardEntity homeEntity) async {
    return await homeRepositoryInterface.addDashboard(homeEntity);
  }

  Future<List<AgeGroupItem>> loadGeneralVariablesAgeGroups() async {
    return await homeRepositoryInterface.generalVariablesFetchAgeGroups();
  }

  Future<ClinicalPathwayCategoriesItem> loadGeneralVariablesClinicalPathwayCategories() async {
    return await homeRepositoryInterface.generalVariablesClinicalPathwayCategories();
  }


  Future<ClinicalPathwayFlavourCategoriesItem> loadGeneralVariablesClinicalPathwayFlavourCategories() async {
    return await homeRepositoryInterface.generalVariablesClinicalPathwayFlavourCategories();
  }



  Future<GenderGroupStandardItem> loadGeneralVariablesGenderGroupsStandard() async {
    return await homeRepositoryInterface.generalVariablesGenderGroupStandard();
  }


  Future<bool> updateCategoriesInFirebase(ClinicalPathwayCategoriesItem clinicalPathwayCategoriesItem) async {
    return await homeRepositoryInterface.updateCategoriesInFirebase(clinicalPathwayCategoriesItem);
  }



}


