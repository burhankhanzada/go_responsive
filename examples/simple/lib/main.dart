// ignore_for_file: unreachable_from_main

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:go_responsive/go_responsive.dart';

import 'go_responsive.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (context) => const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
      builder: (context, child) {
        return GoResponsiveBuilder(
          breakpoints: breakpoints,
          child: child,
        );
      },
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: context.goResponsiveValue(
          compact: Colors.red,
          medium: Colors.green,
          expanded: Colors.blue,
          defaultValue: Colors.black,
        ),
      ),
    );
  }
}

class Home2 extends StatelessWidget {
  const Home2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoResponsiveWidget(
        compact: Container(color: Colors.red),
        medium: Container(color: Colors.green),
        expanded: Container(color: Colors.blue),
        defaultWidget: Container(color: Colors.black),
      ),
    );
  }
}

class Home3 extends StatelessWidget {
  const Home3({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Colors.black;

    if (context.isCompact) {
      color = Colors.red;
    }

    if (context.isMedium) {
      color = Colors.green;
    }

    if (context.isExpanded) {
      color = Colors.blue;
    }

    return Scaffold(
      body: Container(color: color),
    );
  }
}

class Home4 extends StatelessWidget {
  const Home4({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Colors.black;

    if (context.goResponsiveData
        .smallerOrEqualTo(GoResponsiveBreakpoints.compact)) {
      color = Colors.red;
    }

    if (context.goResponsiveData.between(
      GoResponsiveBreakpoints.compact,
      GoResponsiveBreakpoints.expanded,
    )) {
      color = Colors.green;
    }

    if (context.goResponsiveData.between(
      GoResponsiveBreakpoints.medium,
      GoResponsiveBreakpoints.expanded,
    )) {
      color = Colors.blue;
    }

    return Scaffold(
      body: Container(color: color),
    );
  }
}
