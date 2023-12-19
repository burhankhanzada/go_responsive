// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'go_responsive_util.dart';

// **************************************************************************
// GoResponsiveGenerator
// **************************************************************************

class GoResponsiveBreakpoints {
  static String compact = 'compact';

  static String medium = 'medium';

  static String expanded = 'expanded';
}

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
  GoResponsiveData get goResponsiveData => GoResponsive.of(this);
  bool get isCompact =>
      goResponsiveData.smallerOrEqualTo(GoResponsiveBreakpoints.compact);
  bool get isMedium => goResponsiveData.between(
        GoResponsiveBreakpoints.compact,
        GoResponsiveBreakpoints.medium,
      );
  bool get isExpanded => goResponsiveData.between(
        GoResponsiveBreakpoints.medium,
        GoResponsiveBreakpoints.expanded,
      );
  T goResponsiveValue<T>({
    T? compact,
    T? medium,
    T? expanded,
    required T defaultValue,
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
