# GoResponsive [![MIT][mit_badge]][mit_link]

A simple, easy but expressive responsive framework.

![Preview](example/preview.gif)

## Features

GoResponsive makes responsive design easy by:

- Generating `.is{breakpoint_name}` extension methods on BuildContext so can be used as condition
- Generate `GoResponsiveWidget` with all defined breakpoint as optional parameters wit and a required defaultWidget paramter default behaviour if none brekpoint match size.
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
    GoResponsiveBreakpoint(size: 600, name: 'small'),
    GoResponsiveBreakpoint(size: 840, name: 'medium'),
    GoResponsiveBreakpoint(size: double.maxFinite, name: 'large'),
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

- now run `dart run build_runner build` in console which will generate `main.g.dart`

  ```dart
  class GoResponsiveWidget extends StatelessWidget {
    const GoResponsiveWidget({
      super.key,
      required this.defaultWidget,
      this.small,
      this.medium,
      this.large,
    });

    final Widget defaultWidget;

    final Widget? small;

    final Widget? medium;

    final Widget? large;

    @override
    Widget build(BuildContext context) {
      return context.goResponsiveValue(
        small: small,
        medium: medium,
        large: large,
        defaultValue: defaultWidget,
      );
    }
  }

  extension GoResponsiveBuildContextExtensions on BuildContext {
    GoResponsiveData get goResponsiveData => GoResponsiveBuilder.of(this);
    bool get isSmall => goResponsiveData.smallerOrEqualTo('small');
    bool get isMedium => goResponsiveData.between('small', 'medium');
    bool get isLarge => goResponsiveData.between('medium', 'large');
    T goResponsiveValue<T>({
      required T defaultValue,
      T? small,
      T? medium,
      T? large,
    }) {
      if (isSmall) {
        if (small != null) return small;
      }

      if (isMedium) {
        if (medium != null) return medium;
      }

      if (isLarge) {
        if (large != null) return large;
      }

      return defaultValue;
    }
  }
  ```

- then import `main.g.dart` in which `GoResponsiveWidget` is Defined and can be used like this:

  ```dart
  class Home extends StatelessWidget {
    const Home({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: GoResponsiveWidget(
          small: Container(
            color: Colors.red,
          ),
          medium: Container(
            color: Colors.green,
          ),
          large: Container(
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

[go_responsive_pub]: https://pub.dartlang.org/packages/go_responsive

[go_responsive_annotation_pub]: https://pub.dartlang.org/packages/go_responsive_annotation

[go_responsive_generator_pub]: https://pub.dartlang.org/packages/go_responsive_generator

[go_responsive_badge]: https://img.shields.io/pub/v/go_responsive?logo=dart&color=blue

[go_responsive_annotation_badge]: https://img.shields.io/pub/v/go_responsive_annotation?logo=dart&&color=blue

[go_responsive_generator_badge]: https://img.shields.io/pub/v/go_responsive_generator?logo=dart&color=blue

[contibution_url]: https://github.com/burhankhanzada/go_responsive/graphs/contributors
[contibution_image]: https://contrib.rocks/image?repo=burhankhanzada/go_responsive
