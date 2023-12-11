import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

import 'breakpoint.dart';
import 'data.dart';
import 'inherited_data.dart';

class GoResponsiveBuilder extends StatefulWidget {
  const GoResponsiveBuilder({
    super.key,
    required this.breakpoints,
    required this.child,
  });

  final Widget child;
  final List<GoResponsiveBreakpoint> breakpoints;

  @override
  State<GoResponsiveBuilder> createState() => GoResponsiveBuilderState();

  static GoResponsiveData of(BuildContext context) {
    final data =
        context.dependOnInheritedWidgetOfExactType<InheritedGoResponsiveData>();
    if (data != null) {
      return data.data;
    }
    throw FlutterError.fromParts(
      <DiagnosticsNode>[
        ErrorSummary(
          'GoResponsiveBuilder.of() called with a context that does not contain ResponsiveBuilder.',
        ),
        ErrorDescription(
            'No GoResponsiveData ancestor could be found starting from the context that was passed '
            'to GoResponsiveBuilder.of(). Place a GoResponsiveBuilder at the root of the app'),
        context.describeElement('The context used was'),
      ],
    );
  }
}

class GoResponsiveBuilderState extends State<GoResponsiveBuilder>
    with WidgetsBindingObserver {
  Size get size => MediaQuery.of(context).size;

  double get width => size.width;

  GoResponsiveBreakpoint breakpoint =
      const GoResponsiveBreakpoint(size: 0, name: '');

  late final breakpoints = widget.breakpoints;

  @override
  void initState() {
    super.initState();

    // Dimensions are only available after first frame paint.
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Directly updating dimensions is safe because frame callbacks
      // in initState are guaranteed.
      setBreakpoint();
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(GoResponsiveBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    // When [ResponsiveBreakpoints]'s constructor is
    // used directly in the widget tree and a parent
    // MediaQueryData changes, update state.
    // The screen dimensions are passed immediately.
    setBreakpoint();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InheritedGoResponsiveData(
      data: GoResponsiveData.fromWidgetState(this),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    // When physical dimensions change, update state.
    // The required MediaQueryData is only available
    // on the next frame for physical dimension changes.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Widget could be destroyed by resize. Verify widget
      // exists before updating dimensions.
      if (mounted) {
        setBreakpoint();
        setState(() {});
      }
    });
  }

  void setBreakpoint() {
    breakpoint = breakpoints.firstWhereOrNull(
          (element) => width >= element.size && width <= element.size,
        ) ??
        const GoResponsiveBreakpoint(size: 0, name: '');
  }
}
