# GoResponsive [![MIT][mit_badge]][mit_link]

A simple but expressive responsive framework inspired by [responsive_framework][responsive_framework] conitinal logics and context based responsive data & [responsive_builder][responsive_builder_pub] responsive widget with all supported breakpoint as parameters which will genrated by code generation.

![Preview](example/preview.gif)

## Features

GoResponsive makes responsive design easy by:


- Generate `GoResponsiveWidget` with all defined breakpoint as optional parameters with and a required defaultWidget parameter.
- Generating `.is{breakpoint_name}` extension methods on BuildContext so can be used with condition.
- Generate `goResponsiveValue<T>` extension method on BuildContext so can be used set dynamic value.

## Getting started

| Package                  | Version                                                                       |
| -------------------------|-------------------------------------------------------------------------------|
| go_responsive            | [![pub pakage][go_responsive_badge]][go_responsive_pub]                       |
| go_responsive_annotation | [![pub pakage][go_responsive_annotation_badge]][go_responsive_annotation_pub] |
| go_responsive_generator  | [![pub pakage][go_responsive_generator_badge]][go_responsive_generator_pub]   |

```yaml
dependencies:
  ...
  go_responsive: <version>
  go_responsive_annotation: <version>

dev_dependencies:
  ...
  build_runner: <version>
  go_responsive_generator: <version>

```

## Uasage

- Define breakepoints as top level list of `GoResponsiveBreakpoint` and annotate it with `@GoResponsive()`:

  ```dart
  @GoResponsive()
  const breakpoints = [
    GoResponsiveBreakpoint(size: 600, name: 'compact'),
    GoResponsiveBreakpoint(size: 840, name: 'medium'),
    GoResponsiveBreakpoint(size: double.maxFinite, name: 'expanded'),
  ];
  ```

- return `GoResponsiveBuilder` from MaterialApp builder function and set breakpoint to already defined `breakpoints` list:

  ```dart
  class App extends StatelessWidget {
    const App({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: const Home(),
        builder: (context, child) {
          return GoResponsiveBuilder(
            breakpoints: breakpoints,
            child: child!,
          );
        },
      );
    }
  }
  ```

- now run `dart run build_runner build` in console which will generate `<file_name>.name.go_responsive.dart`

- then import `<file_name>.name.go_responsive.dart` in which `GoResponsiveWidget` is Defined and can be used like this:

  ```dart
  class Home extends StatelessWidget {
    const Home({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: GoResponsiveWidget(
          compact: Container(
            color: Colors.red,
          ),
          medium: Container(
            color: Colors.green,
          ),
          expanded: Container(
            color: Colors.blue,
          ),
          defaultWidget: Container(
            color: Colors.black,
          ),
        ),
      );
    }
  }
  ```

> Please see example for complete understanding.

## My other packages

[Time Picker Wheel](https://pub.dev/packages/time_picker_wheel) Time Picker inspired by Oppo Clock app set alram time screen with full customization

## Contributors

[![Contributors][contibution_image]][contibution_url]

[mit_badge]: https://img.shields.io/badge/license-MIT-green.svg
[mit_link]: https://opensource.org/licenses/MIT

[responsive_framework]: https://pub.dev/packages/responsive_framework

[responsive_builder_pub]: https://pub.dev/packages/responsive_builder

[go_responsive_pub]: https://pub.dartlang.org/packages/go_responsive

[go_responsive_annotation_pub]: https://pub.dartlang.org/packages/go_responsive_annotation

[go_responsive_generator_pub]: https://pub.dartlang.org/packages/go_responsive_generator

[go_responsive_badge]: https://img.shields.io/pub/v/go_responsive?logo=dart&color=blue

[go_responsive_annotation_badge]: https://img.shields.io/pub/v/go_responsive_annotation?logo=dart&&color=blue

[go_responsive_generator_badge]: https://img.shields.io/pub/v/go_responsive_generator?logo=dart&color=blue

[contibution_url]: https://github.com/burhankhanzada/go_responsive/graphs/contributors
[contibution_image]: https://contrib.rocks/image?repo=burhankhanzada/go_responsive
