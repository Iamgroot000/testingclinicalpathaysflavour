
import 'package:testing_clinicalpathways/domain/entities/flowChartEntities/getFlowChartEntitiesConnector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawingArrow extends GetxController {
  DrawingArrow._();
  static final instance = DrawingArrow._();

  ArrowParams params = const ArrowParams();
  setParams(ArrowParams params) {
    this.params = params;
    update();
  }

  Offset from = Offset.zero;
  setFrom(Offset from) {
    this.from = from;
    update();
  }

  Offset to = Offset.zero;
  setTo(Offset to) {
    this.to = to;
    update();
  }

  bool isZero() {
    return from == Offset.zero && to == Offset.zero;
  }

  reset() {
    params = const ArrowParams();
    from = Offset.zero;
    to = Offset.zero;
    update();
  }
}
