
import 'package:testing_clinicalpathways/domain/entities/flowChartEntities/getFlowChartEntitiesConnector.dart';
import 'package:testing_clinicalpathways/presentation/controllers/arrowController.dart';
import 'package:testing_clinicalpathways/presentation/controllers/dashboardController.dart';
import 'package:testing_clinicalpathways/presentation/widgets/drawArrow.dart';
import 'package:testing_clinicalpathways/presentation/widgets/elementWidget.dart';
import 'package:testing_clinicalpathways/presentation/widgets/gridBackground.dart';
import 'package:flutter/material.dart';



/// Main flow chart Widget.
/// It displays the background grid, all the elements and connection lines
class FlowChartWidget extends StatefulWidget {
  /// callback for tap on dashboard
  final Function(BuildContext context, Offset position)? onDashboardTapped;

  /// callback for long tap on dashboard
  final Function(BuildContext context, Offset position)? onDashboardLongtTapped;

  /// callback for element pressed
  final Function(BuildContext context, Offset position, FlowElement element)?
  onElementPressed;

  /// callback for element long pressed
  final Function(BuildContext context, Offset position, FlowElement element)?
  onElementLongPressed;
  final Function(BuildContext context, Offset position, FlowElement element)?onElementSelectAndDrag;

  /// callback for handler pressed
  final Function(
      BuildContext context,
      Offset position,
      Handler handler,
      FlowElement element,
      )? onHandlerPressed;

  /// callback for handler long pressed
  final Function(
      BuildContext context,
      Offset position,
      Handler handler,
      FlowElement element,
      )? onHandlerLongPressed;

  /// main dashboard to use
  final Dashboard dashboard;

  const FlowChartWidget({
    Key? key,
    this.onElementPressed,
    this.onElementLongPressed,
    this.onElementSelectAndDrag,
    this.onDashboardTapped,
    this.onDashboardLongtTapped,
    this.onHandlerPressed,
    this.onHandlerLongPressed,
    required this.dashboard,
  }) : super(key: key);

  @override
  State<FlowChartWidget> createState() => _FlowChartWidgetState();
}

class _FlowChartWidgetState extends State<FlowChartWidget> {
  @override
  void initState() {
    super.initState();
    widget.dashboard.addListener(_elementChanged);
  }

  @override
  void dispose() {
    widget.dashboard.removeListener(_elementChanged);
    super.dispose();
  }

  _elementChanged() {
    if (mounted) setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    /// get dashboard position after first frame is drawn
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        final object = (context.findRenderObject() as RenderBox);
        final translation = object.getTransformTo(null).getTranslation();
        final Size size = object.semanticBounds.size;
        Offset position = Offset(translation.x, translation.y);

        widget.dashboard.setDashboardSize(size);
        widget.dashboard.setDashboardPosition(position);
      }

    });

    GlobalKey gridKey = GlobalKey();
    Offset tapDown = Offset.zero;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 10,
          width: MediaQuery.of(context).size.width,
          child: ClipRect(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Draw the grid
                Positioned.fill(
                  child: GestureDetector(
                    onTapDown: (details) {
                      tapDown = details.localPosition;
                    },
                    onTap: widget.onDashboardTapped == null
                        ? null
                        : () => widget.onDashboardTapped!(
                      gridKey.currentContext!,
                      tapDown,
                    ),
                    onLongPress: widget.onDashboardLongtTapped == null
                        ? null
                        : () => widget.onDashboardLongtTapped!(
                      gridKey.currentContext!,
                      tapDown,
                    ),
                    child: GridBackground(
                      key: gridKey,
                      params: widget.dashboard.gridBackgroundParams,
                    ),
                  ),
                ),
                // Draw elements
                for (int i = 0; i < widget.dashboard.elements.length; i++)
                  ElementWidget(
                    key: UniqueKey(),
                    dashboard: widget.dashboard,
                    element: widget.dashboard.elements.elementAt(i),
                    onElementPressed: widget.onElementPressed == null
                        ? null
                        : (context, position) => widget.onElementPressed!(
                      context,
                      position,
                      widget.dashboard.elements.elementAt(i),
                    ),
                    onElementLongPressed: widget.onElementLongPressed == null
                        ? null
                        : (context, position) => widget.onElementLongPressed!(
                      context,
                      position,
                      widget.dashboard.elements.elementAt(i),
                    ),
                    onElementSelectAndDrag : widget.onElementSelectAndDrag == null
                        ? null
                        : (context, position) => widget.onElementSelectAndDrag!(
                      context,position,widget.dashboard.elements.elementAt(i),),
                    onHandlerPressed: widget.onHandlerPressed == null
                        ? null
                        : (context, position, handler, element) => widget
                        .onHandlerPressed!(context, position, handler, element),
                    onHandlerLongPressed: widget.onHandlerLongPressed == null
                        ? null
                        : (context, position, handler, element) =>
                        widget.onHandlerLongPressed!(
                            context, position, handler, element),
                  ),
                // Draw arrows
                for (int i = 0; i < widget.dashboard.elements.length; i++)
                  for (int n = 0; n < widget.dashboard.elements[i].next.length; n++)
                    DrawArrow(
                      key: UniqueKey(),
                      srcElement: widget.dashboard.elements[i],
                      destElement: widget.dashboard.elements[widget.dashboard
                          .findElementIndexById(
                          widget.dashboard.elements[i].next[n].destElementId)],
                      arrowParams: widget.dashboard.elements[i].next[n].arrowParams,
                    ),
                // user drawing when connecting elements
                const DrawingArrowWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget to draw interactive connection when the user tap on handlers
class DrawingArrowWidget extends StatefulWidget {
  const DrawingArrowWidget({super.key});

  @override
  State<DrawingArrowWidget> createState() => _DrawingArrowWidgetState();
}

class _DrawingArrowWidgetState extends State<DrawingArrowWidget> {
  @override
  void initState() {
    super.initState();
    DrawingArrow.instance.addListener(_arrowChanged);
  }

  @override
  void dispose() {
    DrawingArrow.instance.removeListener(_arrowChanged);
    super.dispose();
  }

  _arrowChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (DrawingArrow.instance.isZero()) return const SizedBox.shrink();
    return CustomPaint(
      painter: ArrowPainter(
        params: DrawingArrow.instance.params,
        from: DrawingArrow.instance.from,
        to: DrawingArrow.instance.to,
      ),
    );
  }
}
