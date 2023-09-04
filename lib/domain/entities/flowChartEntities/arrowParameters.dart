import 'dart:convert';

import 'package:flutter/material.dart';

/// Arrow parameters used by [DrawArrow] widget
class ArrowParams {
  final double thickness;
  final Color color;
  final Alignment startArrowPosition;
  final Alignment endArrowPosition;

  const ArrowParams({
    this.thickness = 1.7,
    this.color = Colors.black,
    this.startArrowPosition = Alignment.centerRight,
    this.endArrowPosition = Alignment.centerLeft,
  });

  ArrowParams copyWith({
    double? thickness,
    Color? color,
    Alignment? startArrowPosition,
    Alignment? endArrowPosition,
  }) {
    return ArrowParams(
      thickness: thickness ?? this.thickness,
      color: color ?? this.color,
      startArrowPosition: startArrowPosition ?? this.startArrowPosition,
      endArrowPosition: endArrowPosition ?? this.endArrowPosition,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'thickness': thickness,
      'color': color.value,
      'startArrowPositionX': startArrowPosition.x,
      'startArrowPositionY': startArrowPosition.y,
      'endArrowPositionX': endArrowPosition.x,
      'endArrowPositionY': endArrowPosition.y,
    };
  }

  factory ArrowParams.fromMap(Map<String, dynamic> map) {
    return ArrowParams(
      thickness: map['thickness'] as double,
      color: Color(map['color'] as int),
      startArrowPosition: Alignment(
        map['startArrowPositionX'] as double,
        map['startArrowPositionY'] as double,
      ),
      endArrowPosition: Alignment(
        map['endArrowPositionX'] as double,
        map['endArrowPositionY'] as double,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ArrowParams.fromJson(String source) =>
      ArrowParams.fromMap(json.decode(source) as Map<String, dynamic>);
}