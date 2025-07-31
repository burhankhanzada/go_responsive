import 'package:flutter/material.dart';
import 'package:go_responsive/go_responsive.dart';

import 'pages/root_page.dart';
import 'utils/go_responsive_util.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const RootPage(),
      builder: (context, child) {
        return GoResponsiveBuilder(breakpoints: breakpoints, child: child);
      },
    );
  }
}
