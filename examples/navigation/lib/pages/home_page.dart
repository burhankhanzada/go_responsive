import 'package:flutter/material.dart';

import '../utils/routes_util.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Home'),
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
