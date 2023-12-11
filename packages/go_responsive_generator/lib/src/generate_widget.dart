import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';

Class generateGoResponsiveWidget(List<String> names) {
  final constructorParameters = ListBuilder<Parameter>(
    [
      Parameter(
        (p0) => p0
          ..named = true
          ..toSuper = true
          ..name = 'key',
      ),
      Parameter(
        (p0) => p0
          ..named = true
          ..toThis = true
          ..required = true
          ..name = 'defaultWidget',
      ),
      ...names.map((e) {
        return Parameter(
          (p0) => p0
            ..named = true
            ..toThis = true
            ..name = e,
        );
      }),
    ],
  );

  final constructor = Constructor(
    (builder) => builder
      ..constant = true
      ..optionalParameters = constructorParameters,
  );

  final fields = ListBuilder<Field>([
    Field(
      (p0) => p0
        ..modifier = FieldModifier.final$
        ..type = const Reference('Widget')
        ..name = 'defaultWidget',
    ),
    ...names.map((e) {
      return Field(
        (p0) => p0
          ..modifier = FieldModifier.final$
          ..type = const Reference('Widget?')
          ..name = e,
      );
    }),
  ]);

  final nameString = StringBuffer();

  for (final name in names) {
    nameString.writeln('$name: $name,');
  }

  final buildMethod = Method(
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

  return Class(
    (b) => b
      ..fields = fields
      ..constructors.add(constructor)
      ..name = 'GoResponsiveWidget'
      ..extend = const Reference('StatelessWidget')
      ..methods = ListBuilder([buildMethod]),
  );
}
