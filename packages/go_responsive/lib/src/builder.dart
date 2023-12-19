import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'breakpoint.dart';
import 'data.dart';
import 'inherited_data.dart';

typedef GoResponsiveBuilderFunction = Widget Function(
  BuildContext context,
  GoResponsiveData data,
  Widget? child,
);

class GoResponsiveBuilder extends StatefulWidget {
  const GoResponsiveBuilder({
    super.key,
    this.child,
    this.builder,
    required this.breakpoints,
  });

  final Widget? child;
  final GoResponsiveBuilderFunction? builder;
  final List<GoResponsiveBreakpoint> breakpoints;

  @override
  State<GoResponsiveBuilder> createState() => GoResponsiveBuilderState();
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
    final data = GoResponsiveData(
      width: width,
      breakpoint: breakpoint,
      breakpoints: breakpoints,
    );

    return InheritedGoResponsiveData(
      data: data,
      child: Builder(
        builder: (context) {
          return widget.builder?.call(context, data, widget.child) ??
              widget.child!;
        },
      ),
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
