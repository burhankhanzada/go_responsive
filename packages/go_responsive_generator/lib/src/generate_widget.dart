import 'package:code_builder/code_builder.dart';

Class generateGoResponsiveWidget(List<String> names) {
  return Class(
    (b) => b
      ..name = 'GoResponsiveWidget'
      ..extend = const Reference('StatelessWidget')
      ..fields.addAll(_generateFields(names))
      ..constructors.add(_generateConstructor(names))
      ..methods.add(_generateBuildMethod(names)),
  );
}

List<Field> _generateFields(List<String> names) {
  return [
    ...names.map((e) {
      return Field(
        (p0) => p0
          ..modifier = FieldModifier.final$
          ..type = const Reference('Widget?')
          ..name = e,
      );
    }),
    Field(
      (p0) => p0
        ..modifier = FieldModifier.final$
        ..type = const Reference('Widget')
        ..name = 'defaultWidget',
    ),
  ];
}

Constructor _generateConstructor(List<String> names) {
  final constructorParameters = [
    Parameter(
      (p0) => p0
        ..named = true
        ..toSuper = true
        ..name = 'key',
    ),
    ...names.map((e) {
      return Parameter(
        (p0) => p0
          ..named = true
          ..toThis = true
          ..name = e,
      );
    }),
    Parameter(
      (p0) => p0
        ..named = true
        ..toThis = true
        ..required = true
        ..name = 'defaultWidget',
    ),
  ];

  return Constructor(
    (builder) => builder
      ..constant = true
      ..optionalParameters.addAll(constructorParameters),
  );
}

Method _generateBuildMethod(List<String> names) {
  final nameString = StringBuffer();

  for (final name in names) {
    nameString.writeln('$name: $name,');
  }

  return Method(
    (p0) => p0
      ..name = 'build'
      ..annotations.add(const Reference('override'))
      ..returns = const Reference('Widget')
      ..requiredParameters.addAll([
        Parameter(
          (p0) => p0
            ..name = 'context'
            ..type = const Reference('BuildContext'),
        ),
      ])
      ..body = Code('''
    return context.goResponsiveValue(
      $nameString
      defaultValue: defaultWidget,
    );
                '''),
  );
}
