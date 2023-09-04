
import 'package:testing_clinicalpathways/domain/entities/flowChartEntities/getFlowChartEntitiesConnector.dart';
import 'package:testing_clinicalpathways/presentation/controllers/arrowController.dart';
import 'package:testing_clinicalpathways/presentation/widgets/handlerWidgets.dart';
import 'package:flutter/material.dart';

import '../../../presentation/controllers/dashboardController.dart';

/// Draw handlers over the element
class ElementHandlers extends StatelessWidget {
  final Dashboard dashboard;
  final FlowElement element;
  final Widget child;
  final double handlerSize;
  final Function(
      BuildContext context,
      Offset position,
      Handler handler,
      FlowElement element,
      )? onHandlerPressed;
  final Function(
      BuildContext context,
      Offset position,
      Handler handler,
      FlowElement element,
      )? onHandlerLongPressed;

  const ElementHandlers({
    Key? key,
    required this.dashboard,
    required this.element,
    required this.handlerSize,
    required this.child,
    required this.onHandlerPressed,
    required this.onHandlerLongPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: element.size.width + handlerSize,
      height: element.size.height + handlerSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          child,
          for (int i = 0; i < element.handlers.length; i++)
            _ElementHandler(
              element: element,
              handler: element.handlers[i],
              dashboard: dashboard,
              handlerSize: handlerSize,
              onHandlerPressed: onHandlerPressed,
              onHandlerLongPressed: onHandlerLongPressed,
            ),
        ],
      ),
    );
  }
}

class _ElementHandler extends StatelessWidget {
  final FlowElement element;
  final Handler handler;
  final Dashboard dashboard;
  final double handlerSize;
  final Function(
      BuildContext context,
      Offset position,
      Handler handler,
      FlowElement element,
      )? onHandlerPressed;
  final Function(
      BuildContext context,
      Offset position,
      Handler handler,
      FlowElement element,
      )? onHandlerLongPressed;

  const _ElementHandler({
    Key? key,
    required this.element,
    required this.handler,
    required this.dashboard,
    required this.handlerSize,
    required this.onHandlerPressed,
    required this.onHandlerLongPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDragging = false;

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
        alignment = const Alignment (1.0, 1.0);
        break;
      case Handler.bottomLeft:
        alignment = const Alignment(-1.0, 1.0);
        break;

    ///*********************************************************************
    /// HANDLER FOR THE HEXAGON

      case Handler.topRightHexa:
        alignment = const Alignment(0.9, -0.5);
        break;
      case Handler.topLeftHexa:
        alignment = const Alignment(-0.9, -0.5);
        break;
      case Handler.bottomRightHexa:
        alignment = const Alignment(0.9, 0.5);
        break;
      case Handler.bottomLeftHexa:
        alignment = const Alignment(-0.9, 0.5);
        break;
    ///*********************************************************************


    ///*********************************************************************
    /// HANDLER FOR THE PENTAGON

      case Handler.topRightPenta:
        alignment = const Alignment(1.0, -0.3);
        break;
      case Handler.topLeftPenta:
        alignment = const Alignment(-1.0, -0.3);
        break;
      case Handler.bottomRightPenta:
        alignment = const Alignment(0.6, 0.75);
        break;
      case Handler.bottomLeftPenta:
        alignment = const Alignment(-0.6, 0.75);
        break;
    ///*********************************************************************

    ///*********************************************************************
    /// HANDLER FOR THE DOCUMENT AND MULTI DOCUMENT

      case Handler.bottomCenterDoc:
        alignment = const Alignment(0.0, 0.2);
        break;

      case Handler.bottomCenterMultiDoc:
        alignment = const Alignment(0.0, 0.5);
        break;
      case Handler.topCenterMultiDoc:
        alignment = const Alignment(0.0, -0.75);
        break;

    ///*********************************************************************
    case Handler.rightCenterParallelogram:
    alignment = const Alignment(0.89, 0.0);
    break;

      case Handler.rightCenter:
      default:
        alignment = const Alignment(1.0, 0.0);
        break;
    }

    Offset tapDown = Offset.zero;
    return Align(
      alignment: alignment,
      child: DragTarget<Map>(
        onWillAccept: (data) {
          DrawingArrow.instance.setParams(DrawingArrow.instance.params
              .copyWith(endArrowPosition: alignment));
          if (data != null && element == data['srcElement']) return false;
          return true;
        },
        onAcceptWithDetails: (details) {
          dashboard.addNextById(
            details.data['srcElement'],
            element.id,
            DrawingArrow.instance.params.copyWith(endArrowPosition: alignment),
          );
        },
        onLeave: (data) {
          DrawingArrow.instance.setParams(DrawingArrow.instance.params
              .copyWith(endArrowPosition: const Alignment(0.0, 0.0)));
        },
        builder: (context, candidateData, rejectedData) {
          return Draggable<Map>(
            feedback: const SizedBox.shrink(),
            feedbackOffset: dashboard.handlerFeedbackOffset,
            childWhenDragging: HandlerWidget(
              width: handlerSize,
              height: handlerSize,
              backgroundColor: Colors.blue,
            ),
            data: {
              'srcElement': element,
              'alignment': alignment,
            },
            child: GestureDetector(
              onTapDown: (details) => tapDown =
                  details.globalPosition - dashboard.dashboardPosition,
              onTap: () {
                if (onHandlerPressed != null) {
                  onHandlerPressed!(context, tapDown, handler, element);
                }
              },
              onLongPress: () {
                if (onHandlerLongPressed != null) {
                  onHandlerLongPressed!(context, tapDown, handler, element);
                }
              },
              child: HandlerWidget(
                width: handlerSize,
                height: handlerSize,
              ),
            ),
            onDragUpdate: (details) {
              if (!isDragging) {
                DrawingArrow.instance.params = ArrowParams(
                    startArrowPosition: alignment,
                    endArrowPosition: const Alignment(0, 0));
                DrawingArrow.instance.from =
                    details.globalPosition - dashboard.dashboardPosition;
                isDragging = true;
              }
              DrawingArrow.instance.setTo(details.globalPosition -
                  dashboard.dashboardPosition +
                  dashboard.handlerFeedbackOffset);
            },
            onDragEnd: (details) {
              DrawingArrow.instance.reset();
              isDragging = false;
            },
          );
        },
      ),
    );
  }
}
