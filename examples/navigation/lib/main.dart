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
    return GoResponsiveBuilder(
      breakpoints: breakpoints,
      builder: (context, data, child) {
        final initialRoute = context.goResponsiveValue(
          defaultValue: RoutesUtil.tablet,
          compact: RoutesUtil.mobile,
        );

        return MaterialApp(
          // The key should be set because material app if stateful widget so
          // setting key make it rebuild with new route
          key: ValueKey(data),
          initialRoute: initialRoute,
          onGenerateRoute: RoutesUtil.generateRoute,
        );
      },
    );
  }
}

class MobilePage extends StatelessWidget {
  const MobilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Mobile'),
            FilledButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed(RoutesUtil.detail);
              },
              child: const Text('Detail'),
            ),
          ],
        ),
      ),
    );
  }
}

class TabletPage extends StatelessWidget {
  const TabletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Tablet'),
            FilledButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed(RoutesUtil.detail);
              },
              child: const Text('Detail'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Detail'),
      ),
    );
  }
}

class RoutesUtil {
  static const mobile = '/mobile';
  static const tablet = '/tablet';
  static const detail = '/detail';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final Widget page;

    switch (routeSettings.name) {
      case mobile:
        page = const MobilePage();
      case tablet:
        page = const TabletPage();
      case detail:
        page = const DetailPage();
      default:
        page = _errorPage();
    }

    return MaterialPageRoute(
      settings: routeSettings,
      builder: (context) => page,
    );
  }

  static Widget _errorPage() {
    return const Scaffold(
      body: Center(
        child: Text('Error'),
      ),
    );
  }
}
