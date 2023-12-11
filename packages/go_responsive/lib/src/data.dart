import 'breakpoint.dart';
import 'builder.dart';

class GoResponsiveData {
  const GoResponsiveData({
    required this.width,
    required this.breakpoint,
    required this.breakpoints,
  });

  factory GoResponsiveData.fromWidgetState(
    GoResponsiveBuilderState state,
  ) {
    return GoResponsiveData(
      width: state.width,
      breakpoint: state.breakpoint,
      breakpoints: state.breakpoints,
    );
  }

  final double width;
  final GoResponsiveBreakpoint breakpoint;
  final List<GoResponsiveBreakpoint> breakpoints;

  bool equals(String name) => breakpoint.name == name;

  bool largerThan(String name) {
    return width > getFirstMatchBreakePoint(name).size;
  }

  bool smallerThan(String name) {
    return width < getFirstMatchBreakePoint(name).size;
  }

  bool largerOrEqualTo(String name) {
    return width >= getFirstMatchBreakePoint(name).size;
  }

  bool smallerOrEqualTo(String name) {
    return width <= getFirstMatchBreakePoint(name).size;
  }

  GoResponsiveBreakpoint getFirstMatchBreakePoint(String name) {
    return breakpoints.firstWhere((element) => element.name == name);
  }

  bool between(String start, String end) {
    return largerThan(start) && smallerOrEqualTo(end);
  }
}
