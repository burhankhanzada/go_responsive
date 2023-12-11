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
}
