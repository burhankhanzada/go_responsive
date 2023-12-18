import 'package:flutter/widgets.dart';
import 'package:go_responsive/go_responsive.dart';

// **************************************************************************
// GoResponsiveGenerator
// **************************************************************************

String compact = 'compact';
String medium = 'medium';
String expanded = 'expanded';

class GoResponsiveWidget extends StatelessWidget {
  const GoResponsiveWidget({
    super.key,
    required this.defaultWidget,
    this.compact,
    this.medium,
    this.expanded,
  });

  final Widget defaultWidget;

  final Widget? compact;

  final Widget? medium;

  final Widget? expanded;

  @override
  Widget build(BuildContext context) {
    return context.goResponsiveValue(
      compact: compact,
      medium: medium,
      expanded: expanded,
      defaultValue: defaultWidget,
    );
  }
}

extension GoResponsiveBuildContextExtensions on BuildContext {
  GoResponsiveData get goResponsiveData => GoResponsiveBuilder.of(this);
  bool get isCompact => goResponsiveData.smallerOrEqualTo(compact);
  bool get isMedium => goResponsiveData.between(compact, medium);
  bool get isExpanded => goResponsiveData.between(medium, expanded);
  T goResponsiveValue<T>({
    required T defaultValue,
    T? compact,
    T? medium,
    T? expanded,
  }) {
    if (isCompact) {
      if (compact != null) return compact;
    }

    if (isMedium) {
      if (medium != null) return medium;
    }

    if (isExpanded) {
      if (expanded != null) return expanded;
    }

    return defaultValue;
  }
}
