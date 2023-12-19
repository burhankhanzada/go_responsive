import 'breakpoint.dart';

class GoResponsiveData {
  const GoResponsiveData({
    required this.width,
    required this.breakpoint,
    required List<GoResponsiveBreakpoint> breakpoints,
  }) : _breakpoints = breakpoints;

  final double width;
  final GoResponsiveBreakpoint breakpoint;
  final List<GoResponsiveBreakpoint> _breakpoints;

  bool equals(String name) => breakpoint.name == name;

  GoResponsiveBreakpoint _getFirstMatchBreakePoint(String name) {
    return _breakpoints.firstWhere((element) => element.name == name);
  }

  bool largerThan(String name) {
    return width > _getFirstMatchBreakePoint(name).size;
  }

  bool smallerThan(String name) {
    return width < _getFirstMatchBreakePoint(name).size;
  }

  bool largerOrEqualTo(String name) {
    return width >= _getFirstMatchBreakePoint(name).size;
  }

  bool smallerOrEqualTo(String name) {
    return width <= _getFirstMatchBreakePoint(name).size;
  }

  bool between(String start, String end) {
    return largerThan(start) && smallerOrEqualTo(end);
  }
}
