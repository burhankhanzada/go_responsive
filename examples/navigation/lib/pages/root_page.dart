import 'package:flutter/material.dart';
import 'package:spaces2/spaces2.dart';

import '../utils/go_responsive_util.dart';
import '../utils/routes_util.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GoResponsiveWidget(
      compact: _buidlCompact(),
      defaultWidget: _buidlMediumExpanded(),
    );
  }

  Widget _buidlCompact() {
    return NavigatorPopHandler(
      onPop: () => navigatorKey.currentState!.pop(),
      child: Navigator(
        key: navigatorKey,
        initialRoute: RoutesUtil.home,
        onGenerateRoute: RoutesUtil.generateRoute,
      ),
    );
  }

  Widget _buidlMediumExpanded() {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SpacedRow(
        padding: const EdgeInsets.all(16),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text('Dawer'),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: NavigatorPopHandler(
                onPop: () => navigatorKey.currentState!.pop(),
                child: Navigator(
                  key: navigatorKey,
                  initialRoute: RoutesUtil.home,
                  onGenerateRoute: RoutesUtil.generateRoute,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
