// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:testing_clinicalpathways/domain/entities/flowChartEntities/getFlowChartEntitiesConnector.dart';
import 'package:testing_clinicalpathways/globals.dart';
import 'package:testing_clinicalpathways/globals.dart' as global;
import 'package:testing_clinicalpathways/presentation/exporter/appConstExport.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

/// Class to store all the scene elements.
/// It notifies changes to [FlowChart]
///
///

final Dashboard dashBoard = Dashboard();

class Dashboard extends GetxController {
  //FlowElement flowElement;
  List<FlowElement> elements;
  Offset dashboardPosition;
  Size dashboardSize;
  Offset handlerFeedbackOffset;
  GridBackgroundParams gridBackgroundParams;

  Dashboard()
      : elements = [],
        dashboardPosition = Offset.infinite,
        dashboardSize = const Size(0, 0),
        handlerFeedbackOffset = const Offset(-40, -40),
        gridBackgroundParams = const GridBackgroundParams();

  ///Manage
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'elements': elements.map((x) => x.toMap()).toList(),
    };
  }

  factory Dashboard.fromMap(Map<String, dynamic> map) {
    Dashboard d = Dashboard();
    d.elements = List<FlowElement>.from(
      (map['elements'] as List<dynamic>).map<FlowElement>(
            (x) => FlowElement.fromMap(x as Map<String, dynamic>),
      ),
    );
    return d;
  }

  String toJson() => json.encode(toMap());

  factory Dashboard.fromJson(String source) =>
      Dashboard.fromMap(json.decode(source) as Map<String, dynamic>);

  String prettyJson() {
    var spaces = ' ' * 2;
    var encoder = JsonEncoder.withIndent(spaces);
    return encoder.convert(toMap());
  }

  /// set grid background parameters
  setGridBackgroundParams(GridBackgroundParams params) {
    gridBackgroundParams = params;
    update();
  }

  /// set the feedback offset to help on mobile device to see the
  /// end of arrow and not hiding behind the finger when moving it
  setHandlerFeedbackOffset(Offset offset) {
    handlerFeedbackOffset = offset;
  }

  /// set [isResizable] element property
  setElementResizable(FlowElement element, bool resizable) {
    element.isResizing = resizable;
    update();
    // //notifyListeners();
    update();
  }

  /// add a [FlowElement] to the dashboard
  addElement(FlowElement element, {bool notify = true}) {
    if (element.id.isEmpty) {
      element.id = Uuid().v4();
    }
    elements.add(element);
    if (notify) {
      update();
    }
  }

  /// find the element by its [id]
  int findElementIndexById(String id) {
    return elements.indexWhere((element) => element.id == id);
  }

  /// remove all elements
  removeAllElements() {
    elements.clear();
    update();
  }

  /// remove the [handler] connection of [element]
  removeElementConnection(FlowElement element, Handler handler) {
    Alignment alignment;
    switch (handler) {
      case Handler.topCenter:
        alignment = const Alignment(0.0, -1.0);
        break;
      case Handler.bottomCenter:
        alignment = const Alignment(0.0, 1.0);
        break;
      case Handler.leftCenter:
        alignment = const Alignment(-1.0, 0.0);
        break;
      case Handler.topLeft:
        alignment = const Alignment(-1.0, -1.0);
        break;
      case Handler.topRight:
        alignment = const Alignment(1.0, -1.0);
        break;
      case Handler.bottomRight:
        alignment = const Alignment(1.0, 1.0);
        break;
      case Handler.bottomLeft:
        alignment = const Alignment(-1.0, 1.0);
        break;
      case Handler.rightCenter:
      default:
        alignment = const Alignment(1.0, 0.0);
        break;
    }
    element.next.removeWhere((handlerParam) =>
    handlerParam.arrowParams.startArrowPosition == alignment);
    update();
  }

  /// remove all the connection from the [element]
  removeElementConnections(FlowElement element) {
    element.next.clear();
    update();
  }

  /// remove all the elements with [id] from the dashboard
  removeElementById(String id) {
    // remove the element
    String elementId = '';
    elements.removeWhere((element) {
      if (element.id == id) {
        elementId = element.id;
      }
      return element.id == id;
    });

    // remove all connections to the elements found
    for (FlowElement e in elements) {
      e.next.removeWhere((handlerParams) {
        return elementId.contains(handlerParams.destElementId);
      });
    }
    update();
  }

  /// remove element
  /// return true if it has been removed
  bool removeElement(FlowElement element) {
    // remove the element
    bool found = false;
    String elementId = element.id;
    elements.removeWhere((e) {
      if (e.id == element.id) found = true;
      return e.id == element.id;
    });

    // remove all connections to the element
    for (FlowElement e in elements) {
      e.next.removeWhere(
              (handlerParams) => handlerParams.destElementId == elementId);
    }
    update();
    return found;
  }

  refreshUi() {
    update();
  }

  /// needed to know the diagram widget position to compute
  /// offsets for drag and drop elements
  setDashboardPosition(Offset position) {
    dashboardPosition = position;
  }

  /// needed to know the diagram widget size
  setDashboardSize(Size size) {
    dashboardSize = size;
  }

  /// make an arrow connection from [sourceElement] to
  /// the elements with id [destId]
  /// [arrowParams] definition of arrow parameters
  addNextById(FlowElement sourceElement, String destId, ArrowParams arrowParams,
      {bool notify = true}) {
    int found = 0;
    for (int i = 0; i < elements.length; i++) {
      if (elements[i].id == destId) {
        // if the [id] already exist, remove it and add this new connection
        sourceElement.next
            .removeWhere((element) => element.destElementId == destId);
        sourceElement.next.add(ConnectionParams(
          destElementId: elements[i].id,
          arrowParams: arrowParams,
          targetElementId: '',
        ));

        found++;
      }
    }

    if (found == 0) {
      debugPrint('Element with $destId id not found!');
      return;
    }
    if (notify) {
      update();
    }
  }

  // Future<void> flowChartId(BuildContext context, FlowElement element) async {
  //   // Show a dialog to select a group
  //
  //   String flowId = global.flowChartId.first;
  //
  //   if (element.navigationId == "none") {
  //     flowId = global.flowChartId.first;
  //   } else {
  //     for (int i = 0; i < global.flowChartId.length; i++) {
  //       if (element.navigationId != "") {
  //         if (global.flowChartId[i] == element.navigationId) {
  //           flowId = global.flowChartId[i];
  //           element.setFlowChartID(global.flowChartId[i]);
  //           element.setFlowChartIDIndex(i);
  //         }
  //       }
  //     }
  //   }
  //
  //   await showDialog(
  //     context: context,
  //     builder: (context) {
  //       // Build the dialog content
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           return AlertDialog(
  //             title: const Text('Select a group'),
  //             content: SingleChildScrollView(
  //               scrollDirection: Axis.vertical,
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   for (int i = 0; i < global.flowChartId.length; i++)
  //                     CheckboxListTile(
  //                       title: Text(global.flowChartId[i]),
  //                       value: global.flowChartId[i] == flowId,
  //                       onChanged: (value) {
  //                         setState(() {
  //                           if (value == true) {
  //                             flowId = global.flowChartId[i];
  //                             element.setFlowChartID(global.flowChartId[i]);
  //                             element.setFlowChartIDIndex(i);
  //                             print('this is the index $i');
  //                             print("THIS IS TEST ${global.flowChartId[i]}");
  //                           } else {
  //                             print("NOT FOUND ${global.flowChartId[i]}");
  //                           }
  //                         });
  //                       },
  //                     ),
  //                 ],
  //               ),
  //             ),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context, flowId);
  //                 },
  //                 child: Text('OK'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  //
  //   // Add the element to the selected group and notify listeners
  //   print('Adding $element has $flowId flow Chart ID');
  //   update();
  //   // //notifyListeners();
  //   update();
  // }

  /// save the dashboard into [completeFilePath]
  final storage = FirebaseStorage.instance;

  saveDashboard(docRef) async {
    try {
      final jsonData = prettyJson();
      final jsonMap = json.decode(jsonData)
      as Map<String, dynamic>; // get the formatted JSON data
      debugPrint('JSON data from flowchart');
      debugPrint(jsonData);
      await FirebaseFirestore.instance
      // .collection("TESTING")
          .collection(AppConst.adkCollection)
          .doc(docRef)
          .set(jsonMap);

      debugPrint("Dashboard saved to Fire_store successfully!");
    } catch (e) {
      debugPrint("Error saving dashboard to Fire_store : $e");
    }
  }

  updateDashboard(docRef) async {
    try {
      final jsonData = prettyJson();
      final jsonMap = json.decode(jsonData) as Map<String,
          dynamic>; // get the formatted JSON data
      // print('JSON data from flowchart');
      // print(JSON Data);
      await FirebaseFirestore.instance
      // .collection("TESTING")
          .collection(AppConst.adkCollection)
          .doc(docRef)
          .update(jsonMap);


      print("Dashboard updating to Firestore successfully!");
    } catch (e) {
      print("Error updating dashboard to Firestore : $e");
    }
  }

  /// clear the dashboard and load the new one

  loadDashboard(docRef) async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection(AppConst.adkCollection)
          .doc(docRef)
          .get();

      if (!docSnapshot.exists) {
        print("Dashboard data does not exist in Firestore.");
        return;
      }

      final jsonMap = docSnapshot.data() as Map<String, dynamic>;
      final jsonData = json.encode(jsonMap);

      // Decode the JSON data into FlowElement objects
      List<FlowElement> all = List<FlowElement>.from(
        (json.decode(jsonData)['elements'] as List<dynamic>).map<FlowElement>(
              (x) => FlowElement.fromMap(x as Map<String, dynamic>),
        ),
      );

      // Add the FlowElement objects to the elements list
      elements.clear();
      for (int i = 0; i < all.length; i++) {
        addElement(all.elementAt(i));
      }
      update();
    } catch (e) {
      print("Error loading dashboard from Firestore: $e");
    }
  }

  Future<void> copyFlowChart(String docref) async {
    try {
      // Get the reference to the original document
      DocumentReference sourceRef =
      FirebaseFirestore.instance.collection('flowCharts').doc(docref);

      // Get the data of the original document
      DocumentSnapshot sourceSnapshot = await sourceRef.get();
      Map<String, dynamic> sourceData =
      sourceSnapshot.data() as Map<String, dynamic>;

      dataList = [sourceData]; // Save sourceData in a list

      print("Flow chart copied ${sourceData} successfully!");
    } catch (e) {
      print("Error copying flow chart to new document: $e");
    }
  }

  Future<void> pasteCollection(String docref,
      List<Map<String, dynamic>> dataToPaste) async {
    try {
      for (final data in dataToPaste) {
        await FirebaseFirestore.instance
            .collection('flowCharts')
            .doc(docref)
            .update(data);
      }
      print("This data is for pasting $dataToPaste");

      print('Collection pasted successfully!');
    } catch (error) {
      print('Error pasting collection: $error');
    }
  }

  getSelectedDashboard(docRef) async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection(AppConst.adkCollection)
          .doc(docRef)
          .get();

      if (!docSnapshot.exists) {
        print("Dashboard data does not exist in Firestore.");
        return;
      }

      final jsonMap = docSnapshot.data() as Map<String, dynamic>;
      final jsonData = json.encode(jsonMap);

      // Decode the JSON data into FlowElement objects
      List<FlowElement> all = List<FlowElement>.from(
        (json.decode(jsonData)['elements'] as List<dynamic>).map<FlowElement>(
              (x) => FlowElement.fromMap(x as Map<String, dynamic>),
        ),
      );

      // Add the FlowElement objects to the elements list
      return all;
    } catch (e) {
      print(
          "Error loading dashboard from Firestore for get selected dashboard: $e");
    }
  }
}