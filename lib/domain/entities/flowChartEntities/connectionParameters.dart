import 'dart:convert';

import 'package:testing_clinicalpathways/domain/entities/flowChartEntities/arrowParameters.dart';

class ConnectionParams {
  final String destElementId;
  final ArrowParams arrowParams;

  const ConnectionParams({
    required this.destElementId,
    required this.arrowParams, required String targetElementId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'destElementId': destElementId,
      'arrowParams': arrowParams.toMap(),
    };
  }

  factory ConnectionParams.fromMap(Map<String, dynamic> map) {
    return ConnectionParams(
      destElementId: map['destElementId'] as String,
      arrowParams:
      ArrowParams.fromMap(map['arrowParams'] as Map<String, dynamic>), targetElementId: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ConnectionParams.fromJson(String source) =>
      ConnectionParams.fromMap(json.decode(source) as Map<String, dynamic>);
}
