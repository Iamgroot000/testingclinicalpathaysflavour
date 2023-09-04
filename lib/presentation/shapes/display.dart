import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:testing_clinicalpathways/domain/entities/flowChartEntities/getFlowChartEntitiesConnector.dart';
import 'package:get/get.dart';
import '../widgets/elementText.dart';

class BulletWidget extends GetWidget {
  final FlowElement element;

  const BulletWidget({
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
            painter: _MergedShapePainter(
              element: element,
            ),
          ),
          ElementTextWidget(element: element),
        ],
      ),
    );
  }
}


class _MergedShapePainter extends CustomPainter {
  final FlowElement element;

  _MergedShapePainter({
    required this.element,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    paint.strokeJoin = StrokeJoin.round;
    paint.style = PaintingStyle.fill;
    paint.color = Colors.white;

    final double width = size.width;
    final double height = size.height;
    final double radius = width * 0.9;

    final Path path1 = Path()
      ..moveTo(width * 0.8, 0)
      ..lineTo(width, height * 0.5)
      ..lineTo(width * 0.8, height)
      ..lineTo(width * 0.2, height)
      ..lineTo(0, height * 0.5)
      ..lineTo(width * 0.2, 0)
      ..close();

    final Path path2 = Path()
      ..addRRect(RRect.fromLTRBAndCorners(
        width * 0.2,
        0,
        width,
        height,
        topRight: Radius.circular(radius),
        bottomRight: Radius.circular(radius),
      ));

    final Path mergedPath = Path.combine(
      PathOperation.union,
      path1,
      path2,
    );

    paint.strokeWidth = element.borderThickness;
    paint.color = element.borderColor;
    paint.style = PaintingStyle.stroke;
    canvas.drawPath(mergedPath, paint);
  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}











// class _BulletPainter extends CustomPainter {
//   final FlowElement element;
//
//   _BulletPainter({
//     required this.element,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint();
//
//
//     paint.strokeJoin = StrokeJoin.round;
//     paint.style = PaintingStyle.fill;
//     paint.color = element.backgroundColor;
//
//
//     final double centerX = size.width / 2;
//     final double centerY = size.height / 15;
//     final double radius = math.min(size.width, size.height);
//
//
//
//     final Path path = Path();
//     path.moveTo(centerX + radius, centerY);
//     path.quadraticBezierTo(
//         centerX, centerY - radius *  0.5, centerX - radius, centerY);
//     path.lineTo(centerX - radius * 2.0, centerY + radius * 0.5);
//     path.lineTo(centerX - radius, centerY + radius);
//     path.quadraticBezierTo(
//         centerX + radius * 1.5, centerY + radius, centerX + radius, centerY);
//     path.lineTo(centerX + radius * 1, radius * 1);
//     path.close();
//
//     if (element.elevation > 0.01) {
//       canvas.drawShadow(
//         path.shift(Offset(element.elevation, element.elevation)),
//         element.borderColor,
//         element.elevation,
//         true,
//       );
//     }
//     canvas.drawPath(path, paint);
//
//     paint.strokeWidth = element.borderThickness;
//     paint.color = element.borderColor;
//     paint.style = PaintingStyle.stroke;
//     canvas.drawPath(path, paint);
//   }
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }

