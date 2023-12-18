import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:go_responsive/go_responsive.dart';
import 'package:go_responsive_annotation/go_responsive_annotation.dart';

import 'main.go_responsive.dart';

@GoResponsive()
const breakpoints = [
  GoResponsiveBreakpoint(size: 600, name: 'compact'),
  GoResponsiveBreakpoint(size: 840, name: 'medium'),
  GoResponsiveBreakpoint(size: double.maxFinite, name: 'expanded'),
];

void main() {
  runApp(
    DevicePreview(
      enabled: false,
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
          child: child!,
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
