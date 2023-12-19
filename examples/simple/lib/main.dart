import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:go_responsive/go_responsive.dart';
import 'package:go_responsive_annotation/go_responsive_annotation.dart';

import 'main.go_responsive.dart';

@goResponsive
const breakpoints = [
  GoResponsiveBreakpoint(size: 600, name: 'compact'),
  GoResponsiveBreakpoint(size: 840, name: 'medium'),
  GoResponsiveBreakpoint(size: double.maxFinite, name: 'expanded'),
];

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
      home: const Scaffold(
        body: Home(),
      ),
      builder: (context, child) {
        return const GoResponsiveBuilder(breakpoints: breakpoints);
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
