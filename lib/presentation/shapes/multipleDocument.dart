import 'package:flutter/material.dart';
import 'package:testing_clinicalpathways/domain/entities/flowChartEntities/getFlowChartEntitiesConnector.dart';
import 'package:get/get.dart';
import 'document.dart';
import '../widgets/elementText.dart';

class MultipleShape extends GetWidget {
  final FlowElement element;

  const MultipleShape({
    Key? key,
    required this.element,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:  170, // Adjust the width as needed
      height: 110, // Adjust the height as needed
      child: Stack(
        children: [
          Positioned(
            child: CustomPaint(
              painter: _DocumentSymbolPainter(
                element: element,

                // element: FlowElement(
                //   backgroundColor: Colors.white,
                //   size: Size(150, 100), // Adjust the size as needed
                //   borderThickness: 2, // Adjust the border thickness as needed
                //   borderColor: Colors.blue,
                // ),
              ),
              child: SizedBox(
                width: 150, // Adjust the size as needed
                height: 100, // Adjust the size as needed
              ),
            ),
          ),
          Positioned(
            top: 5, // Adjust the positioning as needed
            left: 5, // Adjust the positioning as needed
            child: CustomPaint(
              painter: _DocumentSymbolPainter(
                element: element,
                // element: FlowElement(
                //   backgroundColor: Colors.white,
                //   size: Size(150, 100), // Adjust the size as needed
                //   borderThickness: 2, // Adjust the border thickness as needed
                //   borderColor: Colors.blue,
                // ),
              ),
              child: SizedBox(
                width: 150, // Adjust the size as needed
                height: 100, // Adjust the size as needed
              ),
            ),
          ),
          Positioned(
            top: 10, // Adjust the positioning as needed
            left: 10, // Adjust the positioning as needed
            child: CustomPaint(
              painter: _DocumentSymbolPainter(
                element: element,
                // element: FlowElement(
                //   backgroundColor: Colors.white,
                //   size: Size(150, 100), // Adjust the size as needed
                //   borderThickness: 2, // Adjust the border thickness as needed
                //   borderColor: Colors.blue,
                // ),
              ),
              child: SizedBox(
                width: 150, // Adjust the size as needed
                height: 100,
                child: ElementTextWidget(element: element),// Adjust the size as needed
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// class MultipleShape extends StatelessWidget {
//   final FlowElement element;
//
//   const MultipleShape({
//     Key? key,
//     required this.element,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 300,
//       height: 150,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: 3,
//         itemBuilder: (context, index) {
//           return CustomPaint(
//             painter: _DocumentSymbolPainter(element: element),
//             child: ElementTextWidget(element: element),
//           );
//         },
//       ),
//     );
//   }
// }


class _DocumentSymbolPainter extends CustomPainter {
  final FlowElement element;

  _DocumentSymbolPainter({
    required this.element,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;

    final Paint paint = Paint()
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.fill
      ..color = element.backgroundColor; // Set the background color to white

    final path = Path()
      ..lineTo(0, size.height - 10)
      ..quadraticBezierTo(size.width / 4, size.height, size.width / 2, size.height - 20)
      ..quadraticBezierTo(3 * size.width / 4, size.height - 30, size.width, size.height - 10)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);

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

