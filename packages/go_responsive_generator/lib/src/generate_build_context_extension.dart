import 'package:code_builder/code_builder.dart';

Extension generateGoResponsiveBuildContextExtensions(List<String> names) {
  return Extension(
    (b) => b
      ..name = 'GoResponsiveBuildContextExtensions'
      ..on = const Reference('BuildContext')
      ..methods.add(_generateGoResponsiveDataMethod())
      ..methods.addAll(_generateIsBreakpointNameMethods(names))
      ..methods.add(_generateGoResponsiveValueMethod(names)),
  );
}

Method _generateGoResponsiveDataMethod() {
  return Method(
    (p0) => p0
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
        (e) => _generateIsBreakpointNameMethod(
          e,
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
    (p0) => p0
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
        (p0) => p0
          ..named = true
          ..type = const Reference('T?')
          ..name = e,
      );
    }),
    Parameter(
      (p0) => p0
        ..named = true
        ..required = true
        ..type = const Reference('T')
        ..name = 'defaultValue',
    ),
  ];

  return Method(
    (p0) => p0
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
