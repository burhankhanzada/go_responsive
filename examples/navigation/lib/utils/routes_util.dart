import 'package:flutter/material.dart';

import '../pages/detatil_page.dart';
import '../pages/home_page.dart';

class RoutesUtil {
  static const home = '/home';
  static const detail = '/detail';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final Widget page;

    switch (routeSettings.name) {
      case home:
        page = const HomePage();
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
