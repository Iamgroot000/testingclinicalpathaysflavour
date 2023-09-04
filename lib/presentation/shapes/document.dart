import 'package:flutter/material.dart';

import 'package:testing_clinicalpathways/domain/entities/flowChartEntities/getFlowChartEntitiesConnector.dart';
import 'package:get/get.dart';
import '../widgets/elementText.dart';

class CurvedContainer extends GetWidget {
  final FlowElement element;

  const CurvedContainer({
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
            painter: _DocumentSymbolPainter(
              element: element,
            ),
          ),
          ElementTextWidget(element: element),
        ],
      ),
    );
  }
}

class _DocumentSymbolPainter extends CustomPainter {
  final FlowElement element;

  _DocumentSymbolPainter({
    required this.element,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;
    // final double radius = width * 0.1;
    // final double curveHeight = height * 0.2;

    final Paint paint = Paint()
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.fill
      ..color = element.backgroundColor;

    final path = Path()
      ..lineTo(0, size.height - 50)// Start at the bottom-left corner
      ..quadraticBezierTo( size.width / 4, size.height, // Control point 1
        size.width / 2, size.height - 60, // Control point 2
    )
      ..quadraticBezierTo(
      3 * size.width / 4, size.height - 90, // Control point 3
      size.width, size.height - 30, // End point
    )
    ..lineTo(size.width, 0) // Draw a straight line to the top-right corner
    ..close();



    if (element.borderThickness > 0) {
      paint
        ..style = PaintingStyle.stroke
        ..strokeWidth = element.borderThickness
        ..color = element.borderColor;

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_DocumentSymbolPainter oldDelegate) {
    return oldDelegate.element != element;
  }
}

//
// class WaveShapePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..color = Colors.blue;
//     final path = Path()
//       // ..lineTo(0, size.height - 50)
//       // ..quadraticBezierTo(size.width / 4, size.height - 80, size.width / 2, size.height - 50)
//       // ..quadraticBezierTo(3 / 4 * size.width, size.height - 20, size.width, size.height - 50)
//       // ..lineTo(size.width, 0)
//       // ..close();
//
//
//
//       ..lineTo(size.width, size.height - 30) // Start at the bottom-right corner
//       ..quadraticBezierTo(
//         size.width / 4, size.height - 90, // Control point 3
//         0, size.height - 30, // End point
//       )
//       ..quadraticBezierTo(
//         size.width / 2, size.height - 60, // Control point 1
//         3 * size.width / 4, size.height, // Control point 2
//       )
//       ..lineTo(0, 0) // Draw a straight line to the top-left corner
//       ..close();
//
//
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(WaveShapePainter oldDelegate) => false;
// }


