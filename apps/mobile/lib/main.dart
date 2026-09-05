import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';
import 'app/config/app_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = AppConfig.fromEnvironment();
  if (config.supabaseUrl.isNotEmpty && config.supabasePublishableKey.isNotEmpty) {
    await Supabase.initialize(
      url: config.supabaseUrl,
      publishableKey: config.supabasePublishableKey,
    );
  }

  runZonedGuarded(
    () => runApp(const ProviderScope(child: ShiKazeApp())),
    (Object error, StackTrace stack) {
      debugPrint('$error\n$stack');
    },
  );
}
