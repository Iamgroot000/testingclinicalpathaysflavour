// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:testing_clinicalpathways/domain/entities/flowChartEntities/getFlowChartEntitiesConnector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


/// Draw arrow from [srcElement] to [destElement]
/// using [arrowParams] parameters
class DrawArrow extends StatefulWidget {
  final ArrowParams arrowParams;
  final FlowElement srcElement;
  final FlowElement destElement;

  const DrawArrow({
    super.key,
    this.arrowParams = const ArrowParams(),
    required this.srcElement,
    required this.destElement,
  });

  @override
  State<DrawArrow> createState() => _DrawArrowState();
}

class _DrawArrowState extends State<DrawArrow> {
  @override
  void initState() {
    super.initState();
    widget.srcElement.addListener(_elementChanged);
    widget.destElement.addListener(_elementChanged);
  }

  @override
  void dispose() {
    widget.srcElement.removeListener(_elementChanged);
    widget.destElement.removeListener(_elementChanged);
    super.dispose();
  }

  _elementChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Offset from = Offset(
      widget.srcElement.position.dx +
          widget.srcElement.handlerSize / 2.0 +
          (widget.srcElement.size.width *
              ((widget.arrowParams.startArrowPosition.x + 1) / 2)),
      widget.srcElement.position.dy +
          widget.srcElement.handlerSize / 2.0 +
          (widget.srcElement.size.height *
              ((widget.arrowParams.startArrowPosition.y + 1) / 2)),
    );
    Offset to = Offset(
      widget.destElement.position.dx +
          widget.destElement.handlerSize / 2.0 +
          (widget.destElement.size.width *
              ((widget.arrowParams.endArrowPosition.x + 1) / 2)),
      widget.destElement.position.dy +
          widget.destElement.handlerSize / 2.0 +
          (widget.destElement.size.height *
              ((widget.arrowParams.endArrowPosition.y + 1) / 2)),
    );

    return RepaintBoundary(
      child: CustomPaint(
        painter: ArrowPainter(
          params: widget.arrowParams,
          from: from,
          to: to,
        ),
      ),
    );
  }
}

/// Paint the arrow connection taking in count the
/// [params.startArrowPosition] and [params.endArrowPosition] alignment
class ArrowPainter extends CustomPainter {
  final ArrowParams params;
  final Offset from;
  final Offset to;

  ArrowPainter({
    required this.params,
    required this.from,
    required this.to,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    Path path = Path();

    double distance = 0;

    double dx = 0;
    double dy = 0;

    Offset p0 = Offset(from.dx, from.dy);
    Offset p4 = Offset(to.dx, to.dy);
    distance = (p4 - p0).distance / 3;

    // checks for the arrow direction
    if (params.startArrowPosition.x > 0) {
      dx = distance;
    } else if (params.startArrowPosition.x < 0) {
      dx = -distance;
    }
    if (params.startArrowPosition.y > 0) {
      dy = distance;
    } else if (params.startArrowPosition.y < 0) {
      dy = -distance;
    }
    Offset p1 = Offset(from.dx + dx, from.dy + dy);
    dx = 0;
    dy = 0;

    // checks for the arrow direction
    if (params.endArrowPosition.x > 0) {
      dx = distance;
    } else if (params.endArrowPosition.x < 0) {
      dx = -distance;
    }
    if (params.endArrowPosition.y > 0) {
      dy = distance;
    } else if (params.endArrowPosition.y < 0) {
      dy = -distance;
    }
    Offset p3 = params.endArrowPosition == const Alignment(0.0, 0.0)
        ? Offset(to.dx, to.dy)
        : Offset(to.dx + dx, to.dy + dy);
    Offset p2 = Offset(
      p1.dx + (p3.dx - p1.dx) / 2,
      p1.dy + (p3.dy - p1.dy) / 2,
    );

    path.moveTo(p0.dx, p0.dy);
    path.conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 1.0);
    path.conicTo(p3.dx, p3.dy, p4.dx, p4.dy, 1.0);

    // canvas.drawCircle(p0, 10, paint);
    // canvas.drawCircle(p1, 9, paint);
    // canvas.drawCircle(p2, 8, paint);
    // canvas.drawCircle(p3, 7, paint);
    canvas.drawCircle(p4, 6, paint);

    paint.color = params.color;
    paint.strokeWidth = params.thickness;
    paint.style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ArrowPainter oldDelegate) =>
      !(from == oldDelegate.from && to == oldDelegate.to);
}
