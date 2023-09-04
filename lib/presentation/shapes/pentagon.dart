import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'package:testing_clinicalpathways/domain/entities/flowChartEntities/getFlowChartEntitiesConnector.dart';
import 'package:get/get.dart';
import '../widgets/elementText.dart';

class PentagonWidget extends GetWidget {
  final FlowElement element;

  const PentagonWidget({
    Key? key,
    required this.element,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: element.size.width,
      height: element.size.height,
      child: Stack(
        children: [
          CustomPaint(
            size: element.size,
            painter: _PentagonPainter(
              element: element,
            ),
          ),
          ElementTextWidget(element: element),
        ],
      ),
    );
  }
}

class _PentagonPainter extends CustomPainter {
  static const int numSides = 5;

  final FlowElement element;

  _PentagonPainter({
    required this.element,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    final Path path = Path();

    paint.strokeJoin = StrokeJoin.round;
    paint.style = PaintingStyle.fill;
    paint.color = element.backgroundColor;

    final double sideLength = math.min(size.width, size.height) / 2;
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;


    final double rotationAngle = math.pi / 3.3; // 45-degree angle in radians

    // Apply rotation transformation
    canvas.translate(centerX, centerY);
    canvas.rotate(rotationAngle);
    canvas.translate(-centerX, -centerY);

    path.moveTo(centerX + sideLength * math.cos(0), centerY + sideLength * math.sin(0));
    for (int i = 1; i <= numSides; i++) {
      final double theta = 2.0 * math.pi / numSides * i;
      final double x = centerX + sideLength * math.cos(theta);
      final double y = centerY + sideLength * math.sin(theta);
      path.lineTo(x, y);
    }
    path.close();

    if (element.elevation > 0.01) {
      canvas.drawShadow(
        path.shift(Offset(element.elevation, element.elevation)),
        element.borderColor,
        element.elevation,
        true,
      );
    }
    canvas.drawPath(path, paint);

    paint.strokeWidth = element.borderThickness;
    paint.color = element.borderColor;
    paint.style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
