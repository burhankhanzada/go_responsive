import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';

Extension generateGoResponsiveBuildContextExtensions(List<String> names) {
  var lastName = names.first;

  return Extension(
    (b) => b
      ..name = 'GoResponsiveBuildContextExtensions'
      ..on = const Reference('BuildContext')
      ..methods.addAll([
        goResponsiveData(),
        ...names.map(
          (e) => nameMethod(e, lastName, (name) => lastName = name),
        ),
        getGoResponsiveValue(names),
      ]),
  );
}

Method nameMethod(String name, String lastName, void Function(String name) callback) {
  final capitalizeName =
      name.substring(0, 1).toUpperCase() + name.substring(1).toLowerCase();

  var condition = "between('$lastName', '$name')";

  if (name == lastName) {
    condition = "smallerOrEqualTo('$name')";
  }

  callback(name);

  return Method(
    (p0) => p0
      ..lambda = true
      ..type = MethodType.getter
      ..name = 'is$capitalizeName'
      ..returns = const Reference('bool')
      ..body = Code('goResponsiveData.$condition'),
  );
}

Method goResponsiveData() {
  return Method(
    (p0) => p0
      ..lambda = true
      ..type = MethodType.getter
      ..name = 'goResponsiveData'
      ..returns = const Reference('GoResponsiveData')
      ..body = const Code('GoResponsiveBuilder.of(this)'),
  );
}

Method getGoResponsiveValue(List<String> names) {
  final getResponsiveValueMethodParameters = ListBuilder<Parameter>(
    [
      Parameter(
        (p0) => p0
          ..named = true
          ..required = true
          ..type = const Reference('T')
          ..name = 'defaultValue',
      ),
      ...names.map((e) {
        return Parameter(
          (p0) => p0
            ..named = true
            ..type = const Reference('T?')
            ..name = e,
        );
      }),
    ],
  );

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

  return Method(
    (p0) => p0
      ..name = 'goResponsiveValue'
      ..types.add(const Reference('T'))
      ..returns = const Reference('T')
      ..optionalParameters = getResponsiveValueMethodParameters
      ..body = Code('''
        $nameString
        return defaultValue;
      '''),
  );
}
