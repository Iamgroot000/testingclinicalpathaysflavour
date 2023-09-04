import 'dart:math';
import 'package:testing_clinicalpathways/domain/entities/clinicalPathwayCategoriesEntity.dart';
import 'package:testing_clinicalpathways/domain/entities/clinicalPathwayFlavourCategories.dart';
import 'package:testing_clinicalpathways/domain/entities/flowChartEntities/elementShapeEntity.dart';
import 'package:testing_clinicalpathways/domain/entities/genderGroupsStandard.dart';
import 'package:testing_clinicalpathways/domain/usecases/homeUseCase.dart';
import 'package:testing_clinicalpathways/globals.dart' as globals;
import 'package:testing_clinicalpathways/presentation/controllers/dashboardController.dart';
import 'package:testing_clinicalpathways/presentation/routes/AppRoutes.dart';
import 'package:testing_clinicalpathways/presentation/views/presentationLayerConnectors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {

  /// FIREBASE INSTANCE IN THE HOME SCREEN
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final HomeUseCase homeUseCase;

  HomeController(this.homeUseCase);

  /// LIST OF COPIES OF SHAPES
  List<FlowElement> copiedShapes = [];

  /// ADD CUSTOM AGE GROUP ALERT BOX CONTROLLERS
  RxString groupName = "".obs;
  RxDouble start = 0.0.obs;
  RxDouble end = 0.0.obs;


  /// TODO ADD ELEMENT
  RxString selectedMode = "".obs;
  RxList<String> options = [""].obs;
  RxString selectedCategory = "".obs;
  RxString selectedFlavour = "".obs;
  RxList<String> selectedGenders = [''].obs;
  RxList<String> selectedAges = [''].obs;
  RxBool isMandatory = false.obs;
  RxBool isFollowUp = false.obs;
  RxBool isPregnancy = false.obs;
  RxString questionTxt = "".obs;
  RxList<Map<String, String>> selectedLength = [{"": ""}].obs;
  RxBool showAddElementDrawer = false.obs;
  Rx<Offset> customPosition = const Offset(0, 0).obs;
  RxBool isExtended = false.obs;
  RxString flowElementId = ''.obs;

  /// OBJECT OF USER COOKIES MODEL
  late Rx<UserCookiesModel> userCookiesModel = UserCookiesModel("", "").obs;

  /// KEY VALUE TO OPEN END DRAWER
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  /// DASHBOARD REFERENCE FLOW CHART DASHBOARD
  Dashboard dashboard = Dashboard();

  /// CHECK FOR THE SELECTED ELEMENT SHAPE
  Rx<ElementShapeEntity>? selectedElementShape;

  /// CHECK THE ROLE AT THE TIME OF LOGIN ADMIN, EDITOR, VIEWER
  RxBool isAdminAccess = false.obs;
  RxBool isEditorAccess = false.obs;
  RxBool isViewerAccess = false.obs;

  /// REFERENCE OF THE HOME ENTITY LIST FROM THE ENTITY FOLDER IN DOMAIN PART
  List<DashboardEntity> homeEntityList = [];
  List<AgeGroupItem> ageGroupItemList = [];
  List<FlavourItem> flavourItemList = [];
  List<AgeGroupItem> ageGroupItemListForElement = [];
  ClinicalPathwayCategoriesItem clinicalPathwayCategoriesList = ClinicalPathwayCategoriesItem(
      categoryList: []);
  ClinicalPathwayFlavourCategoriesItem clinicalPathwayFlavourCategoriesList = ClinicalPathwayFlavourCategoriesItem(
      flavourList: []);
  Rx<GenderGroupStandardItem> genderGroupStandardList = GenderGroupStandardItem(
      genderGroupList: []).obs;


  /// CHECK FOR THE SELECTED INDEX VALUE
  RxInt selectedIndex = 0.obs;

  /// SELECTED INDEX FOR ELEMENT LEVEL
  RxInt selectedIndexForElement = 0.obs;

  /// CHECK THE SYMBOL INDEX IN THE ADD ELEMENT DASHBOARD
  RxInt selectedSymbolIndex = 0.obs;

  /// EXPENDED TILE CARD BOOL VALUES FOR SCROLLING
  RxBool isExpanded = false.obs;

  /// BOOL VALUE
  RxBool isDelete = false.obs;

  /// TOGGLE BETWEEN THE END DRAWERS VALUE
  RxString endDrawerType = ''.obs;

  /// BOOL VALUES FOR ELEMENT IS NEW OR FOR UPDATE
  RxBool isNewElement = true.obs;

  /// CHECK FOR THE FLOW CHART AVAILABILITY IS IT NAME OF THE DASHBOARD
  RxBool flowchartNameAvailable = true.obs;

  /// BUTTON LOADING AT THE TIME OF ADDING DASHBOARD
  RxBool addHomeEntityButtonLoading = false.obs;

  /// BOOL FOR THE LIST OF ITEMS IN THE ADD DASHBOARD
  RxBool isListItemsOfDashboards = false.obs;

  /// RANDOM CLASS INSTANCE TO GENERATE A RANDOM NUMBERS
  Random random = Random();

  /// ERROR MESSAGES ON THE ADD DASHBOARD BUTTON
  RxString errorMessage = "".obs;

  /// CONTROLLER OF THE TEXT FIELD FLOW CHART NAME CONTROLLER
  final TextEditingController flowchartNameController = TextEditingController();

  /// CONTROLLER OF THE TEXT FIELD FLOW ID CONTROLLER IT IS AUTO POPULATED
  final TextEditingController flowChartIdController = TextEditingController();

  /// EDIT THE START AND END AGE GROUP IN THE END DRAWER
  final TextEditingController startAgeController = TextEditingController();
  final TextEditingController endAgeController = TextEditingController();

  /// ADD THE NEW CATEGORIES GROUP IN THE END DRAWER
  final TextEditingController addCategoriesController = TextEditingController();

  /// ADD QUESTION TEXT FIELD IN THE ADD ELEMENT END DRAWER
  final TextEditingController elementTextController = TextEditingController();

  ///MAX LIMIT FOR NUMBER AT ELEMENT LEVEL
  final TextEditingController maxLimitForNumber = TextEditingController();

  /// TEXT FIELD CONTROLLER FOR THE OPTION AND MULTI OPTIONS
  RxList<TextEditingController> optionTextController = [TextEditingController()]
      .obs;

  /// NAVIGATION FLOW CHART NAME FOR CONNECTOR ELEMENT
  RxString dashboards = ''.obs;

  /// FILL THE FLOWCHART NAME AND FLOWCHART ID IN EACH ELEMENT OF THE CONNECTOR
  DashboardEntity _dashboardEntity = DashboardEntity(
      flowchartName: "", flowchartId: "");

  /// FILL THE START ID IN THE CONNECTOR SHAPE ELEMENT
  RxString startId = "".obs;

  /// FILL THE END ID IN THE CONNECTOR SHAPE ELEMENT
  RxString endId = "".obs;

  /// INT VALUE FOR THE PASTE ELEMENTS
  RxInt numElements = 0.obs;

  /// CHECK FOR THE INDEX IN THE PASTE FUNCTION
  RxInt startingIndex = 0.obs;

  /// CONTROLLERS FOR THE ADD RANGE IN THE AGE GROUP WIDGET
  final TextEditingController startRangeController = TextEditingController();
  final TextEditingController endRangeController = TextEditingController();

  /// LIST SHOWN IN THE EXPENDED BOX FOR RANGE AND AGE GROUP IT IS MANDATORY FIELD
  RxList<AgeGroupItem> ageGroupList = <AgeGroupItem>[].obs;

  /// BOOL VALUE TODO
  RxBool isOptionsDialog = true.obs;


  @override
  void onInit() async {
    //userCookiesModel.value = await UserCookies().getUserInfo();
    userCookiesModel.value = await UserCookies().getCookie();
    _checkUserAccess();
    loadAgeGroups();
    loadClinicalPathwayCategories();
    loadGenderGroupStandard();
    loadClinicalPathwayFlavourCategories();
    loadFlowcharts();
    update();
  }

  /// CHECK USER ROLE AND ASSIGN THE ACCESS
  _checkUserAccess() {
    debugPrint("THIS IS CHECK ${userCookiesModel.value.role}");
    switch (userCookiesModel.value.role) {
      case "admin":
        isAdminAccess.value = true;
        break;
      case "editor":
        isEditorAccess.value = true;
        break;
      case "viewer":
        isViewerAccess.value = true;
        break;
      default:
        isViewerAccess.value = true;
        break;
    }
    update();
  }

  /// LOADING FLOW CHARTS IN THE START OF THE APPLICATION
  Future<List<DashboardEntity>> loadFlowcharts() async {
    homeEntityList = await homeUseCase.load();
    update();
    return homeEntityList;
  }

  /// LOAD AGE GROUP WHICH IS STORED IN THE FIREBASE
  Future<List<AgeGroupItem>> loadAgeGroups() async {
    ageGroupItemList = await homeUseCase.loadGeneralVariablesAgeGroups();
    update();
    return ageGroupItemList;
  }

  /// LOAD CLINICAL CATEGORIES WHICH IS STORED IN THE FIREBASE
  Future<ClinicalPathwayCategoriesItem> loadClinicalPathwayCategories() async {
    clinicalPathwayCategoriesList =
    await homeUseCase.loadGeneralVariablesClinicalPathwayCategories();
    update();
    return clinicalPathwayCategoriesList;
  }

  /// LOAD GENDER GROUP FROM THE FIREBASE
  Future<GenderGroupStandardItem> loadGenderGroupStandard() async {
    genderGroupStandardList.value =
    await homeUseCase.loadGeneralVariablesGenderGroupsStandard();
    return genderGroupStandardList.value;
  }


  /// LOAD CLINICAL CATEGORIES WHICH IS STORED IN THE FIREBASE
  Future<ClinicalPathwayFlavourCategoriesItem> loadClinicalPathwayFlavourCategories() async {
    clinicalPathwayFlavourCategoriesList =
    await homeUseCase.loadGeneralVariablesClinicalPathwayFlavourCategories();
    update();
    appNames = clinicalPathwayFlavourCategoriesList.flavourList;
    return clinicalPathwayFlavourCategoriesList;
  }


  /// CHECK FOR THE FLOW CHART NAME IS IT AVAILABLE OR NOT
  isFlowchartNameAvailable({String? flowchartName}) async {
    try {
      var res = await homeUseCase.executeCheckAvailability(
          flowchartName: flowchartName!);
      flowchartNameAvailable.value = res == 0;
      errorMessage.value = flowchartName.isEmpty
          ? ""
          : res == 0
          ? AppConst.flowchartNameAvailable
          : AppConst.flowchartNameNotAvailable;
    } catch (error) {
      flowchartNameAvailable.value = false;
      errorMessage.value = AppConst.flowchartNameNotAvailable;
    }
  }

  ///ADD DASHBOARD FUNCTION TO ADD DASHBOARD IN THE FIREBASE
  Future addDashboard() async {
    if (flowchartNameController.text.isEmpty) {
      errorMessage.value = AppConst.enterFlowchartName;
      return;
    }

    if (!flowchartNameAvailable.value) {
      errorMessage.value = AppConst.flowchartNameNotAvailable;
      return;
    }

    addHomeEntityButtonLoading.value = true;

    /// UNIQUE FLOW ID IN THE FIREBASE
    String uniqueDashboardId = random.nextInt(1000000).toString();

    List<AgeGroupItem> ageGroups = [];
    for (AgeGroupItem ageGroup in ageGroupItemList) {
      for (String groupName in selectedAges.value) {
        if (ageGroup.groupName == groupName) {
          ageGroups.add(ageGroup);
        }
      }
    }
    var res = await homeUseCase.executeAddDashboard(DashboardEntity(
      flowchartId: uniqueDashboardId,
      flowchartName: flowchartNameController.text,
      startElementId: "",
      endElementId: "",
      elements: [],
      priority: homeEntityList.length,
      isReferred: false,
      clinicalPathwayCategoriesItem:
      ClinicalPathwayCategoriesItem(categoryList: [selectedCategory.value]),
      genderGroupStandardItem:
      GenderGroupStandardItem(genderGroupList: selectedGenders.value),
      ageGroupItemList: ageGroups ?? [],
    ));

    if (res) {
      loadFlowcharts();
      flowchartNameController.clear();
      errorMessage.value = "";
      addHomeEntityButtonLoading.value = false;

      Get.back();
    }
  }


  /// EXPENDED CONTAINER UPDATE VALUES
  toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  ///LOGOUT FUNCTION IN THE LOGIN SCREEN
  void logout() {
    GetStorage().erase();
    Get.offAllNamed(AppRoutes.splash);
  }


  updateDashboard(String name) async {
    try {
      for (DashboardEntity entity in homeEntityList) {
        if (entity.flowchartName.compareTo(name) == 0) {
          _dashboardEntity = entity;
          questionTxt.value = entity.flowchartName;

          List<FlowElement> flowElements =
          await dashboard.getSelectedDashboard(
              entity.flowchartId);

          for (FlowElement element in flowElements) {
            if (element.kind == ElementKind.ovalStart) {
              startId.value = element.id;
              print("StartId (): $startId");
            } else if (element.kind == ElementKind.ovalEnd) {
              endId.value = element.id;
              print("EndId (): $endId");
            }
          }
        }
      }
    } catch (e) {
      debugPrintStack(
          label: "error while getting data for selected dashboard : $e");
    }
    update();
  }

  /// CONFIRM ALERT DIALOG BOX ON PRESS OF UPDATE BUTTON
  confirmUpdateButton(context) {
    if (dashboard.elements.isNotEmpty) {
      dashboard.updateDashboard(
          homeEntityList[selectedIndex.value].flowchartId);
      ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar(message: AppConst.flowChartUpdateSuccessfully));

      const CircularProgressIndicator(color: AppColor.primaryColor);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar(message: AppConst.addAtLeastOneElement));
    }
    update();
    Get.back();
  }

  /// UPDATES SELECTED INDEX TO SHOW THE LATEST DASHBOARD
  updateSelectedIndex({required int index}) {
    selectedIndex.value = index;
    dashboard.elements.clear();
    for (int i = 0; i < homeEntityList[index].elements!.length; i++) {
      dashboard.addElement(homeEntityList[index].elements!.elementAt(i));
    }
    // dashboard.loadDashboard(homeEntityList[selectedIndex.value].flowchartId);

    // for (int i = 0; i < homeEntityList[18].elements!.length; i++) {
    //   dashboard.addElement(homeEntityList[18].elements!.elementAt(i));
    // }
    update();
    dashboard.refreshUi();
  }

  /// UPDATE THE INDEX VALUES
  updateIndexForElements({required int index}) {
    selectedIndexForElement.value = index;
    update();
  }

  /// UPDATE THE BOOL VALUE FOR THE ICON PRESS ON THE ADD DASHBOARD
  updateIsListItemsOfDashboards() {
    isListItemsOfDashboards.value = !isListItemsOfDashboards.value;
    update();
  }

  /// UPDATE THE VALUE FOR END DRAWER
  updateIsDashboard(String dashboardElement) {
    endDrawerType.value = dashboardElement;
    debugPrint("dashboard :$dashboardElement");
    update();
  }

  /// FUNCTION FOR SHOW SNACK BAR MESSAGES
  showMySnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    update();
  }

  /// DELETE THE ELEMENT BY DRAG AND DROP
  updateIsDelete({required bool isDelete}) {
    this.isDelete.value = isDelete;
    debugPrint("isDelete : ${this.isDelete.value}");
    update();
  }

  /// AUTO ADDING TO THE TEXT FIELD IN THE OPTIONS AND MULTI_OPTIONS
  refreshTextController(List<String> existingOptions) {
    if (existingOptions != null) {
      Set<String> uniqueOptions =
      {}; // Create an empty Set to store unique options
      for (var option in existingOptions) {
        uniqueOptions.add(
            option); // Add each option to the Set (duplicates will be automatically removed)
      }
      optionTextController.clear();
      for (var option in uniqueOptions) {
        optionTextController.add(TextEditingController(text: option));
      }
    }
    update();
  }

  /// ADDING ANOTHER TEXT FIELD ON PRESS ON (+) ICON
  addTextControllers() {
    optionTextController.add(TextEditingController());
    update();
  }

  /// REMOVE TEXT FIELD ON PRESS ON (-) ICON
  removeTextControllers(int index) {
    optionTextController.removeAt(index);
    update();
  }

  /// SHOWING THE OPTION ADDING CONTAINER
  updateIsExtented({required bool isExtented, required bool isOptionsDialog}) {
    isExtended.value = isExtented;
    this.isOptionsDialog.value = isOptionsDialog;
    if (!isOptionsDialog) {
      updateListOfAgeGroupItems();
    }
    update();
  }

  /// UPDATE VALUES IN THE TEXT FIELD AS PER INDEX VALUE
  updateAgeGroup(index) {
    // Get the new values from the text controllers
    String newStartAge = startAgeController.text;
    String newEndAge = endAgeController.text;

    // Get the current age group list

    // Iterate over the age group list and update the specific elements
    //for (int i = 0; i < ageGroupItemList.length; i++) {
    // Update the 'start' key

    ageGroupItemList[index].start = double.tryParse(newStartAge);

    // Update the 'end' key
    ageGroupItemList[index].end = double.tryParse(newEndAge);
    //}

    // Call a function to save the updated age group list
    saveUpdatedAgeGroupList(ageGroupItemList);

    debugPrint(
        "THIS IS AGE GROUP LIST ${ageGroupItemList[0]} ${ageGroupItemList[0]
            .start}  ${ageGroupItemList[0].end} ");
    debugPrint(
        "THIS IS AGE GROUP LIST ${ageGroupItemList[1]
            .groupName} ${ageGroupItemList[1].start} ${ageGroupItemList[1]
            .end} ");
    debugPrint("THIS IS AGE GROUP LIST $ageGroupItemList");
  }

  /// SAVE AND UPDATE AGE GROUP LIST ELEMENT AND CUSTOM AGE GROUPS IN THE ELEMENT LEVEL
  saveUpdatedAgeGroupList(List<AgeGroupItem> updatedAgeGroupList) {
    // Convert the updated age group list to a map
    List<Map<String, dynamic>> updatedAgeGroupMapList =
    updatedAgeGroupList.map((ageGroup) => ageGroup.toMap()).toList();
    // Example Fires tore update code:
    _firestore
        .collection(AppConst.generalVariablesCollectionName)
        .doc(AppConst.ageGroupsDocumentName)
        .update({'ageGroupList': updatedAgeGroupMapList}).then((_) {
      // Update successful
      // Add any necessary code here, such as showing a success message
    }).catchError((error) {
      // Error handling
      // Add any necessary code here, such as showing an error message
      debugPrint('Failed to update age group list: $error');
    });
  }

  /// RESET FOR SELECTION MODE FOR NUMBERIC TO TEXT FIELD (CLEARING THE RANGE VALUES AND SAME FOR THE OPTIONS AND MULIOPTIONS )
  resetForSelectionMode() {
    debugPrint(" try :> ${selectedMode.value}");
    if (!(selectedMode.value.compareTo("isNumeric") == 0)) {
      selectedLength.value =
      [{'min': "", 'max': "", 'length': "", 'pattern': ''}];
    }
    else if (!(selectedMode.value.compareTo("isOptions") == 0 ||
        selectedMode.value.compareTo("isMultiOptions") == 0)) {
      options.value = [''];
    }
    update();
  }
  ///
  ///

  RxInt selectedIndexForFlavour = 0.obs;
  /*updateIndexForFlavour(int selectedIndex){
    saveForFlavour(selectedIndex);

    resetForFlavour();
    update();
  }*/
  RxList<String> selectedGendersForFlavour = [""].obs;
  RxList<String> selectedAgeGroupsForFlavour = [""].obs;
  RxBool isMandatoryForFlavour = false.obs;
  RxBool isFollowUpForFlavour = false.obs;
  RxBool isPregnancyForFlavour = false.obs;

  updateGendersForFlavour(List<String> genders){
    selectedGendersForFlavour.value = genders;
    update();
  }

  updateAgeGroupsForFlavour(List<String> ageGroups){
    selectedAgeGroupsForFlavour.value = ageGroups;
    update();
  }

  updateIsMandatoryForFlavour(bool isMandatory){
    isMandatoryForFlavour.value = isMandatory;
    update();
  }

  updateFollowUpForFlavour(bool isFollowUp){
    isFollowUpForFlavour.value = isFollowUp;
    update();
  }

  updatePregnancyForFlavour(bool isPregnancy){
    isPregnancyForFlavour.value = isPregnancy;
    update();
  }

  resetForFlavour(){
    selectedGendersForFlavour = [""].obs;
    selectedAgeGroupsForFlavour = [""].obs;
    isMandatoryForFlavour = false.obs;
    isFollowUpForFlavour = false.obs;
    isPregnancyForFlavour = false.obs;

    debugPrint("reset for flavour");
    update();
  }

  saveForFlavour(String selectedIndex){

    List<AgeGroupItem> ageGroups = [];
    ageGroups.clear();
    for (AgeGroupItem ageGroup in ageGroupItemList) {
      for (String groupName in selectedAges.value) {
        if (ageGroup.groupName == groupName) {
          ageGroups.add(ageGroup);
        }
      }
    }
    //
    debugPrint(" save flavor item :> ${flavors.length} ");

    for(FlavourItem item in flavors){
      debugPrint(" save flavor item :> ${appNames[selectedIndexForFlavour.value]} :> index :> ${selectedIndexForFlavour.value} :> save flavor item ${item.appFlavour} ");
      if(appNames[selectedIndexForFlavour.value].compareTo(item.appFlavour!) == 0){
        item.genders = selectedGendersForFlavour.value;
        item.ageGroups = ageGroups ?? [] ;
        item.isMandatory = isMandatoryForFlavour.value ?? false;
        debugPrint("test: save flavorItem : ${item.toJson()}");
      }
    }


    debugPrint("test: selected index  : ${selectedIndex}  :>  total length :> ${selectedIndexForFlavour.value} ");
    if(selectedIndexForFlavour.value < appNames.length -1) {
      if (selectedIndex.compareTo('-') == 0) {
        selectedIndexForFlavour.value--;
      } else if (selectedIndex.compareTo('+') == 0) {
        selectedIndexForFlavour.value++;
      }
    }


    resetForFlavour();

    update();
  }


  List<FlavourItem> flavors = [];
  List<String> appNames = [''];
  createFlavoursList() {
    flavors.clear();
    for (String group in appNames) {
      FlavourItem flavorItem = FlavourItem(appFlavour: group);
      flavors.add(flavorItem);
    }
    update();
  }



  ///
  ///



  /// ADD AND UPDATE ELEMENT ON CLICK ON CREATE BUTTON IN THE ADD ELEMENT END DRAWER
  createOrEditElementInDashboard() {
    ElementShapeEntity selectedShapeEntity =
    globals.elementShapesList[selectedIndexForElement.value];

    selectedShapeEntity?.selectedmode =
    selectedMode.value.isNotEmpty ? selectedMode.value : "";
    selectedShapeEntity?.extraOptions = options.value;

    /// RESET FOR SELECTION MODE FOR NUMBERIC TO TEXT FIELD (CLEARING THE RANGE VALUES AND SAME FOR THE OPTIONS AND MULIOPTIONS )
    resetForSelectionMode();


    List<AgeGroupItem> ageGroups = [];
    for (AgeGroupItem ageGroup in ageGroupItemList) {
      for (String groupName in selectedAges.value) {
        if (ageGroup.groupName == groupName) {
          ageGroups.add(ageGroup);
        }
      }
    }



    /// CREATE A NEW ELEMENT
    if (isNewElement.value) {
      dashboard.addElement(FlowElement(
        //adding a new element
        position: customPosition.value,
        size: selectedShapeEntity!.flowElement!.size,
        text: questionTxt.value ?? "",
        range: selectedLength.value,
        kind: selectedShapeEntity!.flowElement!.kind,
        handlers: selectedShapeEntity!.flowElement!.handlers,
        selectedMode: selectedMode.value ?? '',
        options: options.value.join("#") ?? '',
        selectedGroup: selectedCategory.value ?? '',
        isMandatory: isMandatory.value.toString() ?? '',
        ageGroupQuestion: ageGroups ?? [],
        flavours: flavors ?? [],
        id: '',
        genderGroup: selectedGenders.value ?? [],
        navigationId: _dashboardEntity.flowchartId,
        startId: startId.value,
        endId: endId.value,
        flowId: homeEntityList[selectedIndex.value].flowchartId,
        isFollowUp: isFollowUp.value,
        isPregnancy: isPregnancy.value,
      ));
    }

    /// UPDATE THE ELEMENT WITH THE ALL THE THINGS
    else {
      // Update an existing element
      int elementIndex = dashboard.findElementIndexById(flowElementId.value);
      if (elementIndex >= 0) {
        FlowElement existingElement = dashboard.elements[elementIndex];
        existingElement.size = selectedShapeEntity.flowElement!.size;
        existingElement.text = questionTxt.value ?? "";
        existingElement.range = selectedLength.value;
        existingElement.kind = selectedShapeEntity!.flowElement!.kind;
        existingElement.handlers = selectedShapeEntity.flowElement!.handlers;
        existingElement.selectedMode = selectedMode.value ?? '';
        existingElement.options = options.value.join("#") ?? '';
        existingElement.selectedGroup = selectedCategory.value ?? '';
        existingElement.isMandatory = isMandatory.value.toString() ?? '';
        existingElement.ageGroupQuestion = ageGroups ?? [];
        existingElement.flavours = flavors ?? [];
        existingElement.genderGroup = selectedGenders.value ?? [];
        existingElement.startId = startId.value;
        existingElement.endId = endId.value;
        existingElement.flowId =
            homeEntityList[selectedIndex.value].flowchartId;
        existingElement.navigationId = _dashboardEntity.flowchartId;
        existingElement.isFollowUp = isFollowUp.value;
        existingElement.isPregnancy = isPregnancy.value;
        dashboard.elements[elementIndex] = existingElement;
        dashboard.refreshUi();
      }
    }
    debugPrint("test: save element :> flavour  added :${flavors.toList()}");
    debugPrint("test: save element :> flavour  added length :${flavors.length}");
    debugPrint("test: save element :> flavour  added :${flavors[0].toJson()}");
    debugPrint("test: save element :> flavour  added :${flavors[1].toJson()}");
    // debugPrint("test: save element :> flavour  added :${FlavourItemListFromMap(flavors.toList())}");
  }

  /// RESET PRE SELECTED CATEGORIES IN ADDING DASHBOARD
  resetForDashboard() {
    selectedCategory = ''.obs;
    selectedFlavour = ''.obs;
    selectedGenders = [''].obs;
    selectedAges = [''].obs;
  }

  /// LOADING DASHBOARD ELEMENTS AND RESET THE PRE SELECTED CATEGORIES ELEMENT LEVEL
  resetForElement() {
    selectedIndexForElement = 0.obs;
    selectedMode = ''.obs;
    options = [''].obs;
    selectedCategory = ''.obs;
    selectedFlavour = ''.obs;
    selectedGenders = [''].obs;
    selectedAges = [''].obs;
    isMandatory = false.obs;
    questionTxt = ''.obs;
    showAddElementDrawer = false.obs;
    customPosition = const Offset(0, 0).obs;
    elementTextController.clear(); //edittext controller
    isExtended = false.obs;
    optionTextController.clear();
    maxLimitForNumber.clear();
    isNewElement.value = true;
    flowElementId = ''.obs;
    isDelete = false.obs;
    endDrawerType = ''.obs;
    startController.clear();
    endController.clear();
    maxController.clear();
    patternController.clear();
    number = Map();
    selectedAges.value = [];
    isListItemsOfDashboards = false.obs;
    _dashboardEntity = DashboardEntity(flowchartName: '', flowchartId: '');
    dashboards = ''.obs;
    startId = "".obs;
    endId = "".obs;
    errorMessage.value = '';
    isOptionsDialog = true.obs;
    ageGroupList.value.clear();
    isFollowUp = false.obs;
    isPregnancy = false.obs;
    // selectedShapeEntity = null;
    update();
  }

  /// PRE SELECTED METHOD FOR LOAD PRE SELECTED ELEMENTS FROM DASHBOARD TO ELEMNET LEVEL
  loadDataFromDashboard(DashboardEntity dashboardEntity) {
    List<AgeGroupItem> ageGroups = [];
    selectedCategory.value =
    dashboardEntity.clinicalPathwayCategoriesItem!.categoryList[0];
    // selectedFlavour.value = dashboardEntity.clinicalPathwayFlavourCategoriesItem!.flavourList[0];
    selectedGenders.value =
        dashboardEntity.genderGroupStandardItem!.genderGroupList;
    ageGroups = dashboardEntity.ageGroupItemList ?? [];
    for (AgeGroupItem ageGroup in ageGroups) {
      selectedAges.value.add(ageGroup.groupName!);
    }
    selectedAges.value.removeWhere((age) => age.isEmpty);

    update();
  }

  /// LOAD SELECTED DASHBOARD ITEMS
  loadData({required FlowElement flowElement}) {
    try {
      updateIndexForElements(index: flowElement.kind.index);
      customPosition.value = flowElement.position;
      questionTxt.value = flowElement.text;
      selectedMode.value = flowElement.selectedMode;
      options.value = flowElement.options.split("#");
      selectedCategory.value = flowElement.selectedGroup;
      // selectedFlavour.value = flowElement.selectedFlavour;
      isMandatory.value = bool.tryParse(flowElement.isMandatory) ?? false;
      selectedGenders.value = flowElement.genderGroup;
      elementTextController.text = flowElement.text;
      flowElementId.value = flowElement.id;
      isNewElement.value = false;
      endDrawerType = ''.obs; // for opening add element end drawer
      List<Map<String, dynamic>> numbers = flowElement.range;
      startController.text = numbers[0]['min'].toString();
      endController.text = numbers[0]['max'].toString();
      maxController.text = numbers[0]['length'].toString();
      patternController.text = numbers[0]['pattern'].toString();
      List<AgeGroupItem> ageGroups = [];
      selectedAges.value = [];
      ageGroups = flowElement.ageGroupQuestion;
      for (AgeGroupItem ageGroup in ageGroups) {
        // debugPrint("load data age group: ${ageGroup.groupName}");
        selectedAges.value.add(ageGroup.groupName!);
      }

      dashboards.value = flowElement.text;
      isFollowUp.value = flowElement.isFollowUp as bool;
      isPregnancy.value = flowElement.isPregnancy as bool;

      customAgeGroupListForElement();
      ageGroupItemList.clear();
      ageGroupItemList.addAll(ageGroupItemListForElement);

      update();
    } catch (error) {
      debugPrint("THIS IS ADDING DATA ERROR $error");
    }
  }


  /// OPEN END DRAWER ON PRESSING ON THE SCREEN DASHBOARD
  updatePositionAndEnableDrawer(
      {required bool enable, required Offset position}) {
    showAddElementDrawer.value = enable;
    customPosition.value = position;
    debugPrint("THIS IS CHECK ${showAddElementDrawer.value} $position");
    update();
  }

  /// VALIDATION FIELD IN THE ADD ELEMENT FIELDS
  String validationForAddingElement() {
    String msg = "";
    errorMessage.value = "";
    if (globals.elementShapesList[selectedIndexForElement.value].flowElementName
        ?.compareTo(AppConst.connectorElement) == 0) {
      if (questionTxt.value.isEmpty) {
        msg += "Select Navigation FlowChart element";
        errorMessage.value = msg;
        update();
        return msg;
      }
    } else {
      if (questionTxt.value.isEmpty) {
        msg += "Select Question Text";
        errorMessage.value = msg;
        update();
        return msg;
      }
      if (elementTextController.text.isEmpty) {
        msg += "Select Question Category";
        errorMessage.value = msg;
        update();
        return msg;
      }
    }
    if (selectedGenders.value.isEmpty) {
      msg += "\nSelect Genders";
      errorMessage.value = msg;
      update();
      return msg;
    }
    if (selectedAges.value.isEmpty) {
      msg += "Select Age Groups";
      errorMessage.value = msg;
      update();
      return msg;
    }
    if (globals.elementShapesList[selectedIndexForElement.value].typeMode
        .isNotEmpty && (selectedMode.value.isEmpty)) {
      msg += "Select Any selection mode for the Question";
      errorMessage.value = msg;
      update();
      return msg;
    }
    if ((selectedMode.value.compareTo("isNumeric") == 0)) {
      if ((startController.text.isEmpty || endController.text.isEmpty) &&
          (maxController.text.isEmpty) && (patternController.text.isEmpty)) {
        msg += "For numeric mode Atleast one of the options is required";
        errorMessage.value = msg;
        update();
        return msg;
      }
    }
    if ((selectedMode.value.compareTo("isOptions") == 0 ||
        selectedMode.value.compareTo("isMultiOptions") == 0)) {
      if (options.value.length < 2) {
        msg += 'Atleast 2 option should be entered for the Options';
        errorMessage.value = msg;
        update();
        return msg;
      }
    }
    errorMessage.value = msg;
    update();
    return msg;
  }


  /// ADD START AND END AGE GROUP IN THE ALERT DIALOG BOX HOME SCREEN
  addAgeGroupWithStartAndEndAgeOnPressButtonAdd(BuildContext context) {
    if ((groupName.value != null && groupName.value.isNotEmpty) &&
        (start.value != null) &&
        (end.value != null && end.value != 0)) {
      AgeGroupItem newItem = AgeGroupItem(
          groupName: groupName.value,
          start: start.value,
          end: end.value,
          priority: ageGroupItemList.length + 1);
      if (start < end.value) {
        debugPrint("New item: $newItem");
        ageGroupItemList.add(newItem); //add the new item to the list
        update();
        Get.back(); // Close the dialog with saving
      }
    }
  }

  /// ADDING OPTION ONPRESSED FUNCTION
  addOptionsInElement() {
    List<String> enteredOptions = optionTextController.value.map((controller) =>
        controller.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();
    print(enteredOptions);
    if (enteredOptions.length >= 2) {
      options.value = enteredOptions;
      updateIsExtented(isExtented: false, isOptionsDialog: true);
    } else {
      Fluttertoast.showToast(
          msg: "Options must be more than 2", timeInSecForIosWeb: 2);
    }
  }

  /// SELECT ALL THE AGE GROUP BY SELECT ALL ICONS
  selectAllAgeGroups() {
    List<String> allAgeGroupNames =
    ageGroupItemList!
        .map((item) => item.groupName!)
        .toList();
    selectedAges.value = allAgeGroupNames;
    update();
  }

  /// ADD CATEGORY ON PRESS ON THE SUBMIT BUTTON
  addAgeCategories() {
    /// Handle button press
    String category = addCategoriesController.text;

    clinicalPathwayCategoriesList.categoryList.add(category);

    /// Call the function to update the list in Firebase
    homeUseCase.updateCategoriesInFirebase(clinicalPathwayCategoriesList);

    /// Clear the text field after adding the category
    addCategoriesController.clear();
    update();

    ///GET BACK ON PRESS ON THE UPDATE BUTTON
    Get.back();
  }


  /// ################################################################# ///
  ///                     IS NUMERIC FIELD VALUES                       ///
  /// ################################################################# ///

  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();
  final TextEditingController maxController = TextEditingController();
  final TextEditingController patternController = TextEditingController();
  Map<String, String> number = Map();

  /// RANGE VALUES IN THE ELEMENT OF THE FLOW CHART
  updateNumber() {
    number["min"] = startController.value.text;
    number["max"] = endController.value.text;
    number["length"] = maxController.value.text;
    number["pattern"] = patternController.value.text;

    update();
    selectedLength.value = [number];
  }

  ///################### END OF IS NUMERIC FIELD VALUES ###################///


  /// DELETE ELEMENT FROM THE ADD ELEMENT
  deleteElement() {
    dashboard.removeElementById(flowElementId.value);
    resetForDashboard();
    Get.back();
  }

  updateAndCreateButton() async {
    (globals.elementShapesList[selectedIndexForElement.value]
        .flowElementName?.compareTo(AppConst.connectorElement) == 0)
        ? await updateDashboard(dashboards.value)
        : null;
    if (validationForAddingElement().isEmpty) {
      createOrEditElementInDashboard();
      resetForElement();
      // Navigator.pop(context);
      Get.back();
    }
  }

  /// COPY SHAPE PASTE FUNCTION WITH SOME SAME ELEMENT OF IT
  pasteElement() {
    for (int i = 0; i < numElements.value; i++) {
      for (final copiedShape in copiedShapes) {
        final incrementedIndex = startingIndex.value + i;
        final incrementedText = copiedShape.text + incrementedIndex.toString();
        final incrementedId = copiedShape.id + incrementedIndex.toString();
        final incrementedPosition = copiedShape.position +
            Offset((120 * i) as double, 0);
        final newShape = FlowElement(
          size: copiedShape.size,
          backgroundColor: copiedShape.backgroundColor,
          elevation: copiedShape.elevation,
          borderColor: copiedShape.borderColor,
          borderThickness: copiedShape.borderThickness,
          handlers: copiedShape.handlers,
          kind: copiedShape.kind,
          text: incrementedText,
          id: incrementedId,
          position: incrementedPosition,
          genderGroup: copiedShape.genderGroup,
          handlerSize: copiedShape.handlerSize,
          ageGroupQuestion: copiedShape.ageGroupQuestion,
          options: copiedShape.options,
          isMandatory: copiedShape.isMandatory,
          selectedMode: copiedShape.selectedMode,
          selectedGroup: copiedShape.selectedGroup,
        );
        dashboard.addElement(newShape);
      }
    }
    copiedShapes.clear();
  }


  updateListOfAgeGroupItems() {
    // await loadAgeGroups();
    ageGroupList.clear();
    debugPrint("selected ages ${selectedAges.value}");

    if (!isNewElement.value) {
      List<AgeGroupItem> elementAgeGroups = dashboard.elements[dashboard
          .findElementIndexById(flowElementId.value)].ageGroupQuestion;
      bool isAdded = false;
      for (AgeGroupItem ageGroupItem in ageGroupItemList) {
        for (String groupName in selectedAges.value) {
          if (ageGroupItem.groupName?.compareTo(groupName) == 0) {
            for (AgeGroupItem elementAges in elementAgeGroups) {
              if (elementAges.groupName?.compareTo(groupName) == 0) {
                ageGroupList.add(elementAges);
                isAdded = true;
                break;
              }
            }
            if (!isAdded) {
              ageGroupList.add(ageGroupItem);
            }
          }
        }
        isAdded = false;
      }
    } else {
      for (AgeGroupItem ageGroupItem in ageGroupItemList) {
        for (String groupName in selectedAges.value) {
          if (ageGroupItem.groupName?.compareTo(groupName) == 0) {
            ageGroupList.add(ageGroupItem);
          }
        }
      }
    }

    // debugPrint("ageGroupList :>${ageGroupList.value}");
    update();
  }


  updateRangeForAgeGroup(index) {
    ageGroupList.value[index].startRange = startRangeController.text;
    ageGroupList.value[index].endRange = endRangeController.text;
    updateListOfAgeGroupItems();
    update();
  }

  customAgeGroupListForElement() {
    try {
      ageGroupItemListForElement.clear();
      // debugPrint('customAgeGroupListForElement');
      if (!isNewElement.value) {
        // debugPrint('customAgeGroupListForElement updating');

        List<AgeGroupItem> elementAgeGroups = dashboard.elements[dashboard
            .findElementIndexById(flowElementId.value)].ageGroupQuestion;
        ageGroupItemListForElement.addAll(elementAgeGroups);
        // debugPrint('customAgeGroupListForElement updating element age group ${elementAgeGroups}');
        // debugPrint("general ages group: ${ageGroupItemList.length}");
        for (AgeGroupItem ageGroupItem in ageGroupItemList) {
          bool isDuplicate = false;
          for (AgeGroupItem addedAgeGroupItem in ageGroupItemListForElement) {
            if (addedAgeGroupItem.groupName?.compareTo(
                ageGroupItem.groupName!) == 0) {
              isDuplicate = true;
              break;
            }
          }
          if (!isDuplicate) {
            ageGroupItemListForElement.add(ageGroupItem);
          }
        }
        ageGroupItemListForElement.sort(
              (a, b) {
            // Compare priorities and return -1 for higher priority, and 1 otherwise
            return (a.priority != null && b.priority != null)
                ? a.priority!.compareTo(b.priority!)
                : 1;
          },
        );
        // debugPrint("customAgeGroupListForElement updating element ageGroupItem list :> ${ageGroupItemListForElement}");
      }
      else {
        // debugPrint('customAgeGroupListForElement new element');
        ageGroupItemListForElement.addAll(ageGroupItemList);
      }
      // debugPrint("customAgeGroupListForElement element ageGroupItem list :> ${ageGroupItemListForElement}");
    } catch (e) {
      debugPrintStack(label: "error customAgeGroupListForElement:> ${ageGroupItemListForElement}");
    }
    update();
  }

  updateIsMandatory(bool isMandatory) {
    this.isMandatory.value = isMandatory;
    update();
  }


  updateIsFollowUp(bool isFollowUp) {
    this.isFollowUp.value = isFollowUp;
    update();
  }

  updateIsPregnancy(bool isPregnancy) {
    this.isPregnancy.value = isPregnancy;
    update();
  }


  updateQuestionCategory(String isQuestionCategorie) {
    selectedCategory.value = isQuestionCategorie;
    update();
  }

  updateFlavourList(String isFlavourCategories) {
    selectedFlavour.value = isFlavourCategories;
    update();
  }


  updateGenderList(List<String> isGender) {
    selectedGenders.value = isGender;
    selectedGenders.value.removeWhere((gender) => gender.isEmpty);
    update();
  }

  deselectAllAgeGroups() {
    selectedAges.value = [];
    update();
  }

  updateAgeGroups(List<String> agegroups) {
    selectedAges.value = agegroups;
    update();
  }

  /// function - saving flavour list data
  Future<void> updateDataInFirestore(String flavorListName) async {
    try {
      CollectionReference collectionRef = FirebaseFirestore.instance.collection('adkCollection');

      Map<String, dynamic> adkData = {
        'age': selectedAges.value,
        'gender': selectedGenders.value,
        'isMandatory': isMandatory.value,
      };

      await collectionRef.doc('799841').update({
        'elements': FieldValue.arrayUnion([
          {'adk': adkData},
        ]),
      });

      print('ADK data updated in Firestore successfully for $flavorListName.');
    } catch (e) {
      print('Error updating ADK data in Firestore: $e');
    }
  }



/// function for saving aamc data

// Future<void> updateAAMCDataInFirestore() async {
//   try {
//     CollectionReference collectionRef = FirebaseFirestore.instance.collection('adkCollection');
//
//     Map<String, dynamic> aamcData = {
//       'age': selectedAges.value,
//       'gender': selectedGenders.value,
//       'isMandatory': isMandatory.value,
//     };
//
//     await collectionRef.doc('122279').set({
//       'elements': FieldValue.arrayUnion([
//         {'aamc': aamcData},
//       ]),
//     }, SetOptions(merge: true));
//
//     print('AAMC data updated in Firestore successfully at index 1 with document ID 23456.');
//   } catch (e) {
//     print('Error updating AAMC data in Firestore: $e');
//   }
// }
//


}