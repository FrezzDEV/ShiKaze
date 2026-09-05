import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router/app_router.dart';

class ShiKazeApp extends ConsumerWidget {
  const ShiKazeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'ShiKaze',
      routerConfig: router,
      theme: ThemeData(useMaterial3: true),
    );
  }
}
