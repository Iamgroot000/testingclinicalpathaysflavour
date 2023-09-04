
import 'package:testing_clinicalpathways/domain/entities/ageGroupVariables.dart';
import 'package:testing_clinicalpathways/domain/entities/flowChartEntities/getFlowChartEntitiesConnector.dart';
import 'package:testing_clinicalpathways/presentation/controllers/dashboardController.dart';
import 'package:testing_clinicalpathways/presentation/handlers/elementHandlers.dart';
import 'package:testing_clinicalpathways/presentation/shapes/imunizationRepresent.dart';
import 'package:testing_clinicalpathways/presentation/shapes/shapesExporter.dart';
import 'package:testing_clinicalpathways/presentation/widgets/resizeWidget.dart';
import 'package:flutter/material.dart';


/// Widget that use [element] properties to display it on the dashboard scene
class ElementWidget extends StatefulWidget {
  final Dashboard dashboard;
  final FlowElement element;
  final Function(BuildContext context, Offset position)? onElementPressed;
  final Function(BuildContext context, Offset position)? onElementLongPressed;
  final Function(BuildContext context, Offset position)? onElementSelectAndDrag;
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

  const ElementWidget({
    Key? key,
    required this.dashboard,
    required this.element,
    this.onElementPressed,
    this.onElementLongPressed,
    this.onElementSelectAndDrag,
    this.onHandlerPressed,
    this.onHandlerLongPressed,
  }) : super(key: key);

  @override
  State<ElementWidget> createState() => _ElementWidgetState();
}

class _ElementWidgetState extends State<ElementWidget> {
  // local widget touch position when start dragging
  Offset delta = Offset.zero;

  @override
  void initState() {
    super.initState();
    widget.element.addListener(_elementChanged);
  }

  @override
  void dispose() {
    widget.element.removeListener(_elementChanged);
    super.dispose();
  }

  _elementChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget element;

    switch (widget.element.kind) {
      case ElementKind.diamond:
        element = DiamondWidget(element: widget.element);
        break;
      case ElementKind.storage:
        element = StorageWidget(element: widget.element);
        break;
      case ElementKind.ovalStart:
        element = OvalWidget(element: widget.element);
        break;
      case ElementKind.ovalEnd:
        element = OvalWidget(element: widget.element);
        break;
      case ElementKind.circle:
        element = CircleWidget(element: widget.element);
        break;
      case ElementKind.hexagon:
        element = HexagonWidget(element: widget.element);
        break;
      case ElementKind.parallelogram:
        element = ParallelogramWidget(element: widget.element);
        break;
      case ElementKind.pentagon:
        element = PentagonWidget(element: widget.element);
        break;
      case ElementKind.document:
        element = CurvedContainer(element: widget.element,);
        break;
      case ElementKind.displaySymbol:
        element = BulletWidget(element: widget.element);
        break;
      case ElementKind.multipleDisplaySymbol:
      element = MultipleShape(element: widget.element);
      break;
      case ElementKind.immunizationRepresent:
        element = ImmunizationRectangleWidget(element: widget.element);
        break;
      case ElementKind.rectangle:
      default:
        element = RectangleWidget(element: widget.element);
    }

    if (widget.element.isResizing) {
      return Transform.translate(
        offset: widget.element.position,
        transformHitTests: true,
        child: ResizeWidget(
          element: widget.element,
          dashboard: widget.dashboard,
          child: element,
        ),
      );
    }

    element = Padding(
      padding: EdgeInsets.all(widget.element.handlerSize / 2),
      child: element,
    );

    Offset tapLocation = Offset.zero;
    return Transform.translate(
      offset: widget.element.position,
      transformHitTests: true,
      child: GestureDetector(
        onTapDown: (details) {
          tapLocation = details.globalPosition;

        },
        onTap: () {
          if (widget.onElementPressed != null) {
            widget.onElementPressed!(context, tapLocation);
          }
        },
        onLongPress: () {
          if (widget.onElementLongPressed != null) {
            widget.onElementLongPressed!(context, tapLocation);

          }
        },
        child:
        Listener(
          onPointerDown: (event) {
            delta = event.localPosition;
          },
          child: Draggable<FlowElement>(
            data: widget.element,
            dragAnchorStrategy: childDragAnchorStrategy,
            childWhenDragging: const SizedBox.shrink(),
            feedback: Material(
              color: Colors.transparent,
              child: element,
            ),
            child: ElementHandlers(
              dashboard: widget.dashboard,
              element: widget.element,
              handlerSize: widget.element.handlerSize,
              onHandlerPressed: widget.onHandlerPressed,
              onHandlerLongPressed: widget.onHandlerLongPressed,
              child: element,
            ),
            onDragUpdate: (details) {
              widget.element.changePosition(details.globalPosition -
                  widget.dashboard.dashboardPosition -
                  delta);
            },
            onDragEnd: (details) {
              widget.element.changePosition(
                  details.offset - widget.dashboard.dashboardPosition);
            },
            onDragStarted: (){
              if (widget.onElementSelectAndDrag != null) {
                widget.onElementSelectAndDrag!(context, tapLocation);
              }
            },
          ),
        ) ,
      ),
    );
  }

}
