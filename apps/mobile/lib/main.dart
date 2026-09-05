import 'dart:async';

import 'package:flutter/widgets.dart';
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
    () => runApp(const ShiKazeApp()),
    (Object error, StackTrace stack) {
      // TODO: connect to crash reporting after the first stable MVP.
      debugPrint('$error\n$stack');
    },
  );
}
