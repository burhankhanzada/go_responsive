import 'package:code_builder/code_builder.dart';

Extension generateGoResponsiveBuildContextExtensions(List<String> names) {
  return Extension(
    (builder) => builder
      ..name = 'GoResponsiveBuildContextExtensions'
      ..on = const Reference('BuildContext')
      ..methods.add(_generateGoResponsiveDataMethod())
      ..methods.add(_generateGoResponsiveValueMethod(names))
      ..methods.add(_generateIsPortraitMethod())
      ..methods.add(_generateIsLandscapeMethod())
      ..methods.addAll(_generateIsBreakpointNameMethods(names))
      ..methods.addAll(_generateIsConditionBreakpointNameMethods(names)),
  );
}

Method _generateIsPortraitMethod() {
  return Method(
    (builder) => builder
      ..lambda = true
      ..type = MethodType.getter
      ..name = 'isPortrait'
      ..returns = const Reference('bool')
      ..body = const Code(
        'MediaQuery.of(this).orientation == Orientation.portrait',
      ),
  );
}

Method _generateIsLandscapeMethod() {
  return Method(
    (builder) => builder
      ..lambda = true
      ..type = MethodType.getter
      ..name = 'isLandscape'
      ..returns = const Reference('bool')
      ..body = const Code(
        'MediaQuery.of(this).orientation == Orientation.landscape',
      ),
  );
}

Method _generateGoResponsiveDataMethod() {
  return Method(
    (builder) => builder
      ..lambda = true
      ..type = MethodType.getter
      ..name = 'goResponsiveData'
      ..returns = const Reference('GoResponsiveData')
      ..body = const Code('GoResponsive.of(this)'),
  );
}

List<Method> _generateIsBreakpointNameMethods(List<String> names) {
  var lastName = names.first;

  return names
      .map(
        (name) => _generateIsBreakpointNameMethod(
          name,
          lastName,
          (name) => lastName = name,
        ),
      )
      .toList();
}

Method _generateIsBreakpointNameMethod(
  String name,
  String lastName,
  void Function(String name) callback,
) {
  var condition =
      'between(GoResponsiveBreakpoints.$lastName, GoResponsiveBreakpoints.$name,)';

  if (name == lastName) {
    condition = 'smallerOrEqualTo(GoResponsiveBreakpoints.$name)';
  }

  callback(name);

  final capitalizeName =
      name.substring(0, 1).toUpperCase() + name.substring(1).toLowerCase();

  return Method(
    (builder) => builder
      ..lambda = true
      ..type = MethodType.getter
      ..name = 'is$capitalizeName'
      ..returns = const Reference('bool')
      ..body = Code('goResponsiveData.$condition'),
  );
}

Method _generateGoResponsiveValueMethod(List<String> names) {
  final nameString = StringBuffer();

  for (final name in names) {
    final capitalizeName =
        name.substring(0, 1).toUpperCase() + name.substring(1).toLowerCase();

    nameString.writeln('''
    if(is$capitalizeName) {
      if ($name != null) return $name;
    }
    ''');
  }

  final parameters = [
    ...names.map((e) {
      return Parameter(
        (builder) => builder
          ..named = true
          ..type = const Reference('T?')
          ..name = e,
      );
    }),
    Parameter(
      (builder) => builder
        ..named = true
        ..required = true
        ..type = const Reference('T')
        ..name = 'defaultValue',
    ),
  ];

  return Method(
    (builder) => builder
      ..name = 'goResponsiveValue'
      ..types.add(const Reference('T'))
      ..returns = const Reference('T')
      ..optionalParameters.addAll(parameters)
      ..body = Code('''
        $nameString
        return defaultValue;
      '''),
  );
}

List<Method> _generateIsConditionBreakpointNameMethods(List<String> names) {
  final methodsList = <Method>[];

  for (final name in names) {
    methodsList.addAll([
      _generateIsLargerThanBreakpointNameMethod(name),
      _generateIsSmallerThanBreakpointNameMethod(name),
      _generateIsLargerOrEqualToBreakpointNameMethod(name),
      _generateIsSmallerOrEqualToBreakpointNameMethod(name),
    ]);
  }

  return methodsList;
}

Method _generateIsLargerThanBreakpointNameMethod(String name) {
  final condition = 'largerThan(GoResponsiveBreakpoints.$name)';

  final capitalizeName =
      name.substring(0, 1).toUpperCase() + name.substring(1).toLowerCase();

  return Method(
    (builder) => builder
      ..lambda = true
      ..type = MethodType.getter
      ..name = 'isLargerThan$capitalizeName'
      ..returns = const Reference('bool')
      ..body = Code('goResponsiveData.$condition'),
  );
}

Method _generateIsSmallerThanBreakpointNameMethod(String name) {
  final condition = 'smallerThan(GoResponsiveBreakpoints.$name)';

  final capitalizeName =
      name.substring(0, 1).toUpperCase() + name.substring(1).toLowerCase();

  return Method(
    (builder) => builder
      ..lambda = true
      ..type = MethodType.getter
      ..name = 'isSmallerThan$capitalizeName'
      ..returns = const Reference('bool')
      ..body = Code('goResponsiveData.$condition'),
  );
}

Method _generateIsLargerOrEqualToBreakpointNameMethod(String name) {
  final condition = 'largerOrEqualTo(GoResponsiveBreakpoints.$name)';

  final capitalizeName =
      name.substring(0, 1).toUpperCase() + name.substring(1).toLowerCase();

  return Method(
    (builder) => builder
      ..lambda = true
      ..type = MethodType.getter
      ..name = 'isLargerOrEqualTo$capitalizeName'
      ..returns = const Reference('bool')
      ..body = Code('goResponsiveData.$condition'),
  );
}

Method _generateIsSmallerOrEqualToBreakpointNameMethod(String name) {
  final condition = 'smallerOrEqualTo(GoResponsiveBreakpoints.$name)';

  final capitalizeName =
      name.substring(0, 1).toUpperCase() + name.substring(1).toLowerCase();

  return Method(
    (builder) => builder
      ..lambda = true
      ..type = MethodType.getter
      ..name = 'isSmallerOrEqualTo$capitalizeName'
      ..returns = const Reference('bool')
      ..body = Code('goResponsiveData.$condition'),
  );
}
