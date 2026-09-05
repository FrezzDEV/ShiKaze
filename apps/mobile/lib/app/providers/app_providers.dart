import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_config.dart';
import '../../features/manga/data/repositories/manga_repository_impl.dart';
import '../../features/manga/domain/repositories/manga_repository.dart';
import '../../core/network/api_client.dart';

final appConfigProvider = Provider<AppConfig>((ref) {
  return AppConfig.fromEnvironment();
});

final dioProvider = Provider<Dio>((ref) {
  final config = ref.watch(appConfigProvider);
  return Dio(BaseOptions(baseUrl: config.apiBaseUrl));
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(dio: ref.watch(dioProvider));
});

final mangaRepositoryProvider = Provider<MangaRepository>((ref) {
  return MangaRepositoryImpl(ref.watch(apiClientProvider));
});
