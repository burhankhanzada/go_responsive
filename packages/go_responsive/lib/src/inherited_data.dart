import 'package:flutter/widgets.dart';

import 'data.dart';

class InheritedGoResponsiveData extends InheritedWidget {
  const InheritedGoResponsiveData({
    super.key,
    required this.data,
    required super.child,
  });

  final GoResponsiveData data;

  @override
  bool updateShouldNotify(InheritedGoResponsiveData oldWidget) =>
      data != oldWidget.data;

  static GoResponsiveData of(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<InheritedGoResponsiveData>();

    if (widget != null) return widget.data;

    throw FlutterError.fromParts([
      ErrorSummary(
        'GoResponsive.of() called with a context that does not contain GoResponsiveApp.',
      ),
      ErrorDescription(
        'No GoResponsiveData ancestor could be found starting from the context '
        'that was passed to GoResponsive.of(). Place a GoResponsiveApp at the root of the app',
      ),
      context.describeElement('The context used was'),
    ]);
  }
}
